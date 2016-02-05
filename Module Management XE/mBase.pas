unit mBase;


interface

uses
  Windows, Messages, SysUtils, uMethod, ComObj, Seed;

  procedure DataString(const _data, _type: string);
  procedure SendData(const cpdt: TCopyDataStruct);

  function  mOccurError(): Boolean;
  procedure mCheckError(const aErrCode: HResult; const aErrConst: array of const);

  procedure mSetStatus(const status: String);
  procedure mSetResult();
  procedure mSetParam();

  procedure mSetProgress(const progress: Integer);
  procedure mErrorCode(const ErrorStr : String);

  procedure Run();

var
  FinalResult: Boolean = False;
  FLastError: HResult;

  APHD : String; //Application Handler

implementation

uses
  main, mTypes, StrUtils;

procedure DataString(const _data, _type: string);
var
  copyDataStruct: TCopyDataStruct;
  stringToSend: String;
begin
  stringToSend := _type + '[' + _data + ']';
  copyDataStruct.dwData := 0; //use it to identify the message contents
  copyDataStruct.cbData := 1 + Length(stringToSend);
  copyDataStruct.lpData := PChar(stringToSend);
  SendData(copyDataStruct);
end;

procedure SendData(const cpdt: TCopyDataStruct);
var
  receiverHandle: THandle;
  res: integer;
begin
  receiverHandle := FindWindow(nil, PChar(APHD));
  if receiverHandle = 0 then
  begin
    MessageBox(0,PChar('CopyData Receiver NOT found!'), '', 0);
    Exit;
  end;
  res := SendMessage(receiverHandle, WM_COPYDATA, 0, Integer(@cpdt)) ;
end;

procedure mCheckError(const aErrCode: HResult; const aErrConst: array of const);
var
  i: Integer;
begin
  for i := 0 to High(aErrConst) do begin
    case aErrConst[i].VType of
      vtBoolean: begin
        if (FLastError = S_M_OK) and not aErrConst[i].VBoolean then
          FLastError := aErrCode;
        end;
    else Break;
    end;
    if Failed(FLastError) then Break;
  end;
end;

function mOccurError(): Boolean;
begin
  Result := Failed(FLastError);
end;

procedure mSetProgress(const progress: Integer);
begin
  SendMessage(FindWindow(nil, PChar(APHD)), WM_USER + $1001 , 0, progress);
end;

procedure mSetStatus(const status: String);
var
  FName: String;
begin
  FName := StrGrab(ExtractFileName(ParamStr(0)),'','.');
  DataString(FName + ' : ' + status, M_SDT_STATUS);
end;

procedure mSetResult();
var
  rResult: String;
  i : Integer;
begin
  i := 1;
  while i < M_MAXPARAM do
  begin
    rResult := rResult
            + 'Result'
            + IntToStr(i)
            + '='
            + BASEResult.Items[i];
    inc(i);
  end;
  DataString(rResult, M_SDT_RESULT);
end;

procedure mSetParam();
var
  i : Integer;
begin
  i := 1;
  while i < M_MAXPARAM do
  begin
    BASEParam.Items[i] := StrGrab(SeedDecFromBase64('mParam', ParamStr(2)), 'Param'
                                                                     + IntToStr(i)
                                                                     + '=', 'Param');
    inc(i);
  end;
end;

procedure mErrorCode(const ErrorStr : String);
begin
  DataString(ErrorStr, M_SDT_ERROR);
end;

procedure Run();
var
  ErrorCode: HResult;
  ErrorStr : String;
begin
  mSetStatus(M_STP_ON_START);

  while true do begin
    mSetStatus(M_STP_ON_INIT);
    ErrorCode := OnInit;

    //Set Param String
    mSetParam();

    if Failed(ErrorCode) and Succeeded(FLastError) then FLastError := ErrorCode;
    if Failed(FLastError) then break;

    mSetStatus(M_STP_ON_PARAM);
    ErrorCode := OnParam;
    if Failed(ErrorCode) and Succeeded(FLastError) then FLastError := ErrorCode;
    if Failed(FLastError) then break;

    mSetStatus(M_STP_ON_LOGIN);
    ErrorCode := OnLogin;
    if Failed(ErrorCode) and Succeeded(FLastError) then FLastError := ErrorCode;
    if Failed(FLastError) then break;

    mSetStatus(M_STP_ON_ENTER);
    ErrorCode := OnEnter;
    if Failed(ErrorCode) and Succeeded(FLastError) then FLastError := ErrorCode;
    if Failed(FLastError) then break;

    mSetStatus(M_STP_ON_EXCUTE);
    ErrorCode := OnExcute;
      if FinalResult then begin
        FLastError := S_M_OK;
        if Succeeded(FLastError) then break;
      end else begin
        if Failed(ErrorCode) and Succeeded(FLastError) then FLastError := ErrorCode;
        if Failed(FLastError) then break;
      end;

    mSetStatus(M_STP_ON_RESULT);
    ErrorCode := OnResult;
    if Failed(ErrorCode) and Succeeded(FLastError) then FLastError := ErrorCode;
    if Failed(FLastError) then break;

    mSetStatus(M_STP_ON_FINAL);
    ErrorCode := OnFinal;
    if Failed(ErrorCode) and Succeeded(FLastError) then FLastError := ErrorCode;
    if Failed(FLastError) then break;

    mSetStatus(M_STP_ON_END);
    break;
  end;
  try
    OleError(FLastError);
  except
    on E: EOleSysError do begin  //OLE error 8000E000
      ErrorStr := RightStr(E.Message, 8);
      if Pos('OLE',E.Message) = 0 then
      ErrorStr := '00000000';
    end;
  end;
  mErrorCode(ErrorStr);
end;


end.
