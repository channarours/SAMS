unit uWebagent;

interface

uses
  Windows, Messages, Classes, WinInet, SysUtils, uParseURI;

type
  EProgressEvent = procedure(const ReadByte, ReadBytes, TotalBytes: DWORD);
  EProgressEventObj = procedure(const ReadByte, ReadBytes, TotalBytes: DWORD) of object;
  EConnectEvent = procedure(const aResultStr: string; var vResultStr: string);
  EConnectEventObj = procedure(const aResultStr: string; var vResultStr: string) of object;
  TWebAgent = class
  private
    FKeepAlive: Boolean;
    procedure SetHeaders(const Value: string);
    function GetHeaders: string;
  protected
    FURI: TURI;
    FAlwaysPost: Boolean;
    FSession, FConnect, FRequest: hInternet;
    FUseCache: Boolean;
    FAcceptType, FAgent, FVersion, FHeaders, FHeadersEx, FReferer, FFileName, FResultStr: string;
    FTimeOut, FResultSize: Integer;
    FStatusCode, FLastError: Integer;
    FProgressEvent: EProgressEvent;
    FProgressEventObj: EProgressEventObj;
    FConnectEvent: EConnectEvent;
    FConnectEventObj: EConnectEventObj;
    FDefaultUserInfo: Boolean;
    FUserName, FPassword: AnsiString;
  public
    function Connect(const aURL: string; const aQuery: string = ''; const aFileName: string = ''; const aURLEncode: Boolean = True): LongBool;
    function Disconnect: Boolean;

    function URLEncode(const aStr: string): string;

    function SetCookie(const aName, aValue: string): Boolean;
    function GetCookie(const aName: string = ''): string;

    property UseCache: Boolean read FUseCache write FUseCache;
    property AlwaysPost: Boolean read FAlwaysPost write FAlwaysPost;
    property ResultStr: string read FResultStr;
    property ResultSize: Integer read FResultSize;
    property ProgressEvent: EProgressEvent read FProgressEvent write FProgressEvent;
    property ProgressEventObj: EProgressEventObj read FProgressEventObj write FProgressEventObj;
    property ConnectEvent: EConnectEvent read FConnectEvent write FConnectEvent;
    property ConnectEventObj: EConnectEventObj read FConnectEventObj write FConnectEventObj;
    property Agent: string read FAgent write FAgent;
    property Version: string read FVersion write FVersion;
    property Headers: string read FHeaders write SetHeaders;
    property HeadersEx: string read GetHeaders;
    property AcceptType: string read FAcceptType write FAcceptType;
    property Referer: string read FReferer write FReferer;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property StatusCode: Integer read FStatusCode;
    property LastError: Integer read FLastError;

    property DefaultUserInfo: Boolean    read FDefaultUserInfo write FDefaultUserInfo;
    property UserName       : AnsiString read FUserName        write FUserName;
    property Password       : AnsiString read FPassword        write FPassword;

    property KeepAlive: Boolean read FKeepAlive write FKeepAlive;

    constructor Create;
    destructor  Destroy; override;
  end;

implementation

{ TAgent }

function TWebAgent.Connect(const aURL: string; const aQuery: string = ''; const aFileName: string = ''; const aURLEncode: Boolean = True): LongBool;
var
  RequestMethod: string;
  ContentLen, ContentLenSize, dwIndex: DWORD;
  FileBuf: array of Char;
  FileHandle: hWnd;
  FileIndex: DWORD;
  FileSize: DWORD;
  FileTotalIndex: DWORD;
  aResult: Boolean;
  RequestFlags: DWORD;
begin
  Result      := False;
  FResultStr  := '';
  FStatusCode := 999;
  FLastError  := 999;
  FResultSize := -1;
  if FReferer <> '' then begin
    FURI.Paser(FReferer);
    FReferer := '';
  end;
  if not FURI.Paser(aURL) then Exit;
  while True do begin
    if (FURI.Host <> FURI.HostOld) or (FURI.Port <> FURI.PortOld) then begin
      Disconnect;
      FSession := InternetOpen(PChar(FAgent), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
      if FSession = nil then begin
        FLastError := 890;
        Break;
      end;
      if DefaultUserInfo then begin
          FConnect := InternetConnect(FSession, PChar(FURI.Host), FURI.Port{INTERNET_DEFAULT_HTTPS_PORT}, PChar(FURI.User), PChar(FURI.Password), INTERNET_SERVICE_HTTP, 0, 0);
      end else begin
          FConnect := InternetConnect(FSession, PChar(FURI.Host), FURI.Port{INTERNET_DEFAULT_HTTPS_PORT}, PChar(FUserName), PChar(FPassword), INTERNET_SERVICE_HTTP, 0, 0);
      end;
      if FConnect = nil then begin
        FLastError := 900;
        Break;
      end;
    end;
    // set connection time out
    ContentLen := FTimeOut * 1000;
    InternetQueryOption(FConnect, INTERNET_OPTION_CONNECT_TIMEOUT, @ContentLen, ContentLenSize);
    InternetSetOption(FConnect, INTERNET_OPTION_CONNECT_TIMEOUT, @ContentLen, SizeOf(ContentLen));
    InternetSetOption(FConnect, INTERNET_OPTION_RECEIVE_TIMEOUT, @ContentLen, SizeOf(ContentLen));
    if AlwaysPost then RequestMethod := 'POST'
    else if aQuery = '' then RequestMethod := 'GET' else RequestMethod := 'POST';
    if FURI.Skim = 'https' then begin
      RequestFlags := INTERNET_FLAG_SECURE
                   or INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS
                   or INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP
                   or INTERNET_FLAG_IGNORE_CERT_CN_INVALID
                   or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID;
    end else begin
      RequestFlags := 0;
    end;
    RequestFlags := RequestFlags or INTERNET_FLAG_RELOAD;
    if not FUseCache then RequestFlags := RequestFlags or INTERNET_FLAG_NO_CACHE_WRITE;
    if FKeepAlive then RequestFlags := RequestFlags or INTERNET_FLAG_KEEP_CONNECTION;
    FRequest := HttpOpenRequest(FConnect, PChar(RequestMethod), PChar(FURI.Path), PChar(FVersion), PChar(FURI.Referer), @FAcceptType, RequestFlags, 0);
    if FRequest = nil then begin
      FLastError := 910;
      Break;
    end;
    if RequestMethod = 'GET' then begin
      aResult := HttpSendRequest(FRequest, PChar(FHeaders), Length(FHeaders), nil, 0);
    end else begin
      aResult := HttpSendRequest(FRequest, PChar(FHeaders), Length(FHeaders), PChar(aQuery), Length(aQuery));
    end;
    if not aResult then begin
      FLastError := 920;
      Break;
    end;
    ContentLen := 0;
    ContentLenSize := 0;
    dwIndex := 0;
    aResult := HttpQueryInfo(FRequest, HTTP_QUERY_STATUS_CODE or HTTP_QUERY_FLAG_NUMBER, @ContentLen, ContentLenSize, dwIndex);
    if not aResult then begin
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin
        ContentLenSize := SizeOf(ContentLen);
        aResult := HttpQueryInfo(FRequest, HTTP_QUERY_STATUS_CODE or HTTP_QUERY_FLAG_NUMBER, @ContentLen, ContentLenSize, dwIndex);
      end;
    end;
    FStatusCode := ContentLen;
    if (not aResult) or (ContentLen < 200) or (ContentLen > 299) then begin
      FLastError := 930;
      {$IFDEF HTTP_STATUS_SERVER_ERROR_PASS}
      if not FStatusCode = 500 then
      {$ENDIF HTTP_STATUS_SERVER_ERROR_PASS}
      Break;
    end;
    ContentLen := 0;
    ContentLenSize := 0;
    dwIndex := 0;
    aResult := HttpQueryInfo(FRequest, HTTP_QUERY_CONTENT_LENGTH or HTTP_QUERY_FLAG_NUMBER, @ContentLen, ContentLenSize, dwIndex);
    if not aResult then begin
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then begin
        ContentLenSize := SizeOf(ContentLen);
        aResult := HttpQueryInfo(FRequest, HTTP_QUERY_CONTENT_LENGTH or HTTP_QUERY_FLAG_NUMBER, @ContentLen, ContentLenSize, dwIndex);
        FResultSize := ContentLen;
      end;
    end;
    ContentLenSize := 4096;
    SetLength(FileBuf, ContentLenSize);
    if aFileName <> '' then begin
      FileTotalIndex := 0;
      FileHandle := CreateFile(PChar(aFileName), GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_ARCHIVE, 0);
      if FileHandle = INVALID_HANDLE_VALUE then begin
        FLastError := 940;
        Break;
      end;
    end;
    FResultStr := '';
    FileTotalIndex := 0;
    while True do begin
      FillChar(FileBuf[0], Length(FileBuf), #0);
      aResult := InternetReadFile(FRequest, FileBuf, ContentLenSize, dwIndex);
      if not aResult then begin
        FLastError := 950;
        Break;
      end;
      if dwIndex = 0 then begin
        FLastError := 951;
        Break;
      end;
      FResultStr := FResultStr + Copy(string(FileBuf), 1, dwIndex);
      if aFileName <> '' then begin
        WriteFile(FileHandle, FileBuf[0], dwIndex, FileIndex, nil);
        FileTotalIndex := FileTotalIndex + FileIndex;
        if Assigned(FProgressEvent) then FProgressEvent(FileIndex, FileTotalIndex, ContentLen);
        if Assigned(FProgressEventObj) then FProgressEventObj(FileIndex, FileTotalIndex, ContentLen);
      end else begin
        if Assigned(FProgressEvent) then FProgressEvent(dwIndex, Length(FResultStr), ContentLen);
        if Assigned(FProgressEventObj) then FProgressEventObj(dwIndex, Length(FResultStr), ContentLen);
      end;
    end;
    if aFileName <> '' then CloseHandle(FileHandle);
    if ContentLen > 0 then begin
      if aFileName = '' then begin
        if Length(FResultStr) > 0 then Result := True;
      end else begin
        if FileTotalIndex > 0 then Result := True;
      end;
    end else begin
      Result := True;
    end;
    if FLastError = 951 then FLastError := 0;
    Break;
  end;
  if Length(FileBuf) > 0 then FillChar(FileBuf[0], Length(FileBuf), #0);
  SetLength(FileBuf, 0);
  InternetCloseHandle(FRequest);
  if Result then begin
    if Assigned(FConnectEvent) then FConnectEvent(FResultStr, FResultStr);
    if Assigned(FConnectEventObj) then FConnectEventObj(FResultStr, FResultStr);
  end;
end;

function TWebAgent.GetCookie(const aName: string): string;
var
  Buff: array of Char;
  Size: DWORD;
  aResult: Boolean;
  CookieTemp: string;
begin
  InternetGetCookie(PChar(FURI.Skim + '://' + FURI.Host), nil, nil, Size);
  SetLength(Buff, Size);
  FillChar(Buff[0], Size, 0);
  aResult := InternetGetCookie(PChar(FURI.Skim + '://' + FURI.Host), nil, @Buff[0], Size);
  CookieTemp := StrPas(PChar(Buff));
  if aName = '' then begin
    Result := CookieTemp;
  end else begin
    CookieTemp := Copy(CookieTemp, Pos(aName, CookieTemp) + Length(aName) + 1, MaxInt);
    if Pos(';', CookieTemp) > 0 then begin
      Result := Copy(CookieTemp, 1, Pos(';', CookieTemp) - 1);
    end else begin
      Result := CookieTemp;
    end;
  end;
end;

function TWebAgent.SetCookie(const aName, aValue: string): Boolean;
begin
  Result := InternetSetCookie(PChar(FURI.Skim + '://' + FURI.Host), PChar(aName), PChar(aValue));
end;

constructor TWebAgent.Create;
begin
  FURI := TURI.Create;
  FAcceptType := 'Accept: */*';
  FAgent := 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; IPMS/734B1AAC-14B72885BCB; TEAM_20110715003325__1.0.0.9; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1))';
  FVersion := 'HTTP/1.0';
  FHeaders := 'Content-Type: application/x-www-form-urlencoded';
  FReferer := '';
  FTimeOut := 60;
  FUseCache := False;
  FKeepAlive := True;
  FUserName := 'anonymous';
  FPassword := 'IEUser';
  FDefaultUserInfo := True;
  FProgressEvent    := nil;
  FProgressEventObj := nil;
  FConnectEvent     := nil;
  FConnectEventObj  := nil;
end;

function TWebAgent.Disconnect: Boolean;
begin
  if FConnect <> nil then InternetCloseHandle(FConnect);
  if FSession <> nil then InternetCloseHandle(FSession);
end;

destructor TWebAgent.Destroy;
begin
  FProgressEvent    := nil;
  FProgressEventObj := nil;
  FConnectEvent     := nil;
  FConnectEventObj  := nil;
  FURI.Free;
  FURI := nil;
  Disconnect;
  Inherited;
end;

procedure TWebAgent.SetHeaders(const Value: string);
begin
  if Value = '' then
    FHeaders := ''
  else if Pos(':', Value) > 0 then
    FHeaders := Value
  else
    FHeaders := 'Content-Type: ' + Value;
end;

function TWebAgent.URLEncode(const aStr: string): string;
  function AscToHex(const Value: Char): string;
  var
    HiNibble, LoNibble: Integer;
  begin
    Result := '';
    HiNibble := Cardinal(Value) div 16;
    LoNibble := Cardinal(Value) mod 16;
    if HiNibble > 9 then
      Result := Result  + Chr((Ord('A') + HiNibble - 10))
    else
      Result := Result  + Chr((Ord('0') + HiNibble));

    if LoNibble > 9 then
      Result := Result  + Chr((Ord('A') + LoNibble - 10))
    else
      Result := Result  + Chr((Ord('0') + LoNibble));
  end;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(aStr) do begin
    case aStr[i] of
      // reserved char
      '$', {'&',} '+', ',', '/', ':', ';', {'=',} '?', '@': Result := Result + '%' + AscToHex(aStr[i]);
      // unsafety char
      ' ', '"', '<', '>', '#', '%', '{', '}', '|', '^', '~', '[', ']', '`': Result := Result + '%' + AscToHex(aStr[i]);
      // non ascii char
      #128..#255: Result := Result + '%' + AscToHex(aStr[i]);
      else
        Result := Result + aStr[i];
    end;
  end;
end;

function TWebAgent.GetHeaders: string;
begin
  Result := FHeadersEx;
end;

end.
