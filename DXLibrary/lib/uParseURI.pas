unit uParseURI;

interface

type

{ TURI }

  TURI = class
    private
      FSkim: string;             // protocol skim
      FHost: string;             // Host Name
      FPort: Word;               // Port Number
      FPortOld: Word;            // Old Port Number
      FUser: string;             // User Name
      FPassword: string;         // Password
      FPath: string;             // Path
      FHostOld: string;          // Old Host Name
      FReferer: string;          // Refered host name or URI
      FSecureConnect: Boolean;   // need secure connection
    public
      property Skim: string read FSkim;
      property Host: string read FHost;
      property Port: Word read FPort;
      property PortOld: Word read FPortOld;
      property User: string read FUser;
      property Password: string read FPassword;
      property Path: string read FPath;
      property HostOld: string read FHostOld;
      property Referer: string read FReferer;
      property SecureConnect: Boolean read FSecureConnect;

      function Paser(const aURI: string): Boolean;
  end;

implementation

uses
  WinINet;

{ utility functions }

function IntToStr(const aValue: Integer): string;
var
  Value: Integer;
  i, j, k: Integer;
  Sign: string;
begin
  Result := '';
  Value := aValue;
  Sign := '';
  if Value < 0 then begin
    Sign := '-';
    Value := -Value;
  end;
  for i := 9 downto 0 do begin
    k := 1;
    for j := 1 to i do k := k * 10;
    j := Value div k;
    if Boolean(j) or (Result <> '') then Result := Result + Chr(j + Ord('0'));
    Value := Value - j * k;
  end;
  if Result = '' then Result := '0';
  Result := Sign + Result;
end;

function StrToInt(const aValue: string): Integer;
var
  i, j, k: Integer;
  Sign: Integer;
begin
  Result := 0;
  Sign := 0;
  if Length(aValue) < 1 then Exit;
  if aValue[1] = '-' then Sign := -1;
  for i := 1 - Sign to Length(aValue) do begin
    k := 1;
    for j := Length(aValue) downto i + 1 do k := k * 10;
    Result := Result + (Ord(aValue[i]) - Ord('0')) * k;
  end;
  if Sign < 0 then Result := - Result;
end;

function UpperCase(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    if (S[i] >= 'a') and (S[i] <= 'z') then
      Result := Result + Chr(Ord(S[i]) - 32)
    else
      Result := Result + S[i];
end;

function LowerCase(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    if (S[i] >= 'A') and (S[i] <= 'Z') then
      Result := Result + Chr(Ord(S[i]) + 32)
    else
      Result := Result + S[i];
end;

const
  DefaultUserName: PChar   = 'anonymous';
  DefaultPassword: PChar   = 'IEUser';

{ TURI }

function TURI.Paser(const aURI: string): Boolean;
var
  Temp: Integer;
  TempStr: string;
  TempURI: string;
begin
  Result := False;
  // phase referer
  FHostOld := FHost;
  FPortOld := FPort;
  if FHostOld <> '' then begin
    if FUser <> DefaultUserName then begin
      FReferer := FSkim + '://' + FUser + ':' + FPassword + '@' + FHost;
    end else begin
      FReferer := FSkim + '://' + FHost;
    end;
    if FPort <> 80 then FReferer := FReferer + ':' + IntToStr(FPort);
    FReferer := FReferer + FPath;
  end;
  TempURI := aURI;
  // phase protocol skima
  FSkim := 'http';
  FSecureConnect := False;
  Temp := Pos('://', aURI);
  if Temp <> 0 then begin
    FSkim := LowerCase(Copy(TempURI, 1, Temp - 1));
    TempURI := Copy(TempURI, Temp + 3, Length(TempURI) - Temp - 2);
  end;
  if FSkim = 'https' then FSecureConnect := True;
  // phase user account
  FUser := DefaultUserName;
  FPassword := DefaultPassword;
  Temp := Pos('@', TempURI);
  if Temp <> 0 then begin
    TempStr := Copy(TempURI, 1, Temp - 1);
    TempURI := Copy(TempURI, Temp + 1, Length(TempURI) - Temp);
    // phase password
    Temp := Pos(':', TempStr);
    if Temp = 0 then   // user account only
      FUser := TempStr
    else begin         // password exist
      FUser := Copy(TempStr, 1, Temp - 1);
      FPassword := Copy(TempStr, Temp + 1, Length(TempStr) - Temp);
    end;
  end;
  // phase host name
  FHost := '';
  FPort := 0;
  Temp := Pos('/', TempURI);
  if Temp <> 0 then begin
    TempStr := Copy(TempURI, 1, Temp - 1);
    FPath := Copy(TempURI, Temp, Length(TempURI) - Temp + 1);
    // phase port number
    Temp := Pos(':', TempStr);
    if Temp = 0 then   // host name only
      FHost := TempStr
    else begin         // port number exist
      FHost := Copy(TempStr, 1, Temp - 1);
      FPort := StrToInt(Copy(TempStr, Temp + 1, Length(TempStr) - Temp));
    end;
  end else begin
    // phase port number
    Temp := Pos(':', TempURI);
    if Temp = 0 then   // host name only
      FHost := TempURI
    else begin         // port number exist
      FHost := Copy(TempURI, 1, Temp - 1);
      FPort := StrToInt(Copy(TempURI, Temp + 1, Length(TempURI) - Temp));
    end;
    FPath := '/';
  end;
  if FPort = 0 then begin
    if FSecureConnect then
      FPort := INTERNET_DEFAULT_HTTPS_PORT
    else
      FPort := INTERNET_DEFAULT_HTTP_PORT;
  end;
  if FHost <> '' then Result := True;
end;

end.
