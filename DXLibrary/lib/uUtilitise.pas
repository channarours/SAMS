unit uUtilitise;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.CheckLst, System.Actions, Vcl.ActnList, Vcl.WinXCtrls, StrUtils, IniFiles, Math, IdHTTP, IdIOHandler,OleCtrls, SHDocVw,
  MSHTML,Registry,ShellAPI,MySeed, Menus, mTypes, Grids, ValEdit,uMethod;
Type
  TUtilitise = Class
    public

  function FileVersion(const FileName:TFileName):String;
  function FileDecryption(const filename:String;key:String):String;
  function FileEncryption(const filename:String;key:String;source:String):String;
  procedure CreateFile(const filename:String;source:String);
  function ReadFile(const filename:string):String;
  procedure SetAutoStart_REG(AppName, AppTitle: string; bRegister: Boolean);
  procedure RemoveEntryFromRegistry(AppName:String);
  procedure DialogBoxAutoClose(const ACaption, APrompt: string; DuracaoEmSegundos: Integer;AppClose:Boolean);
  function DOSOUTPUT(CommandLine: string; Work: string = 'C:\'): string;
  function ConvertTime12To24(Time12:String):String;
  function GetValueCheckListBox(CheckListBox: TCheckListBox): string;
  function FindFile(const path:string;const extension:string):TStringList;
  End;
implementation
// Pisal
function TUtilitise.ReadFile(const filename:String):String;
var
  text, temp: string;
  F: TextFile;
begin
  if FileExists(filename) then
  begin
     AssignFile(F, filename);
  // Reopen the file for reading
  Reset(F);

  // Display the file contents
  while not Eof(F) do
  begin
    ReadLn(F, text);
    temp := temp + text;
  end;
  // Close the file for the last time
  CloseFile(F);
  Result:=temp;
  end else Result:='NAN';
end;
function TUtilitise.GetValueCheckListBox(CheckListBox: TCheckListBox): string;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to CheckListBox.Count - 1 do
  begin
    if CheckListBox.Checked[i] then
      Result := Result +Copy(CheckListBox.Items[i],0,3)+',';
  end;
  Result:=copy(Result,0,Length(result)-1);
end;

function TUtilitise.ConvertTime12To24(Time12:String):String; //07:49:00 PM = 19 : 49 : 00
var
  zone,temp:String;
  H,M,S:Byte;
begin
  zone:=StrGrab(Time12,' ','');
  H:=StrToInt( copy(Time12,0,StrPos(':',Time12,1)-1));
  temp:= copy(Time12,StrPos(':',Time12,1)+1,StrPos(':',Time12,2));
  if (SameText(zone,'PM')) then
  begin
    if H=12 then
      H:=12
    else
    begin H:=H+12;
    temp:=IntToStr(H)+':'+temp; end;
  end else
  begin
    if H<10 then
    begin temp:='0'+IntToStr(H)+':'+temp; end
    else
    begin temp:=IntToStr(H)+':'+temp; end;
  end;
  Result:=temp;
end;

function TUtilitise.DOSOUTPUT(CommandLine: string; Work: string = 'C:\'): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          //WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + Buffer;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure TUtilitise.DialogBoxAutoClose(const ACaption, APrompt: string; DuracaoEmSegundos: Integer;AppClose:Boolean);
var
  Form: TForm;
  Prompt: TLabel;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  nX, Lines: Integer;

  function GetAveCharSize(Canvas: TCanvas): TPoint;
    var
      I: Integer;
      Buffer: array[0..51] of Char;
    begin
      for I := 0 to 25 do Buffer[I]          := Chr(I + Ord('A'));
      for I := 0 to 25 do Buffer[I + 26]    := Chr(I + Ord('a'));
      GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
      Result.X := Result.X div 52;
    end;

begin
  Form       := TForm.Create(Application);
  Lines   := 0;

  For nX := 1 to Length(APrompt) do
     if APrompt[nX]=#13 then Inc(Lines);

  with Form do
    try
      Font.Name:='Arial';     //mcg
      Font.Size:=10;          //mcg
      Font.Style:=[fsBold];
      Canvas.Font    := Font;
      DialogUnits    := GetAveCharSize(Canvas);
      //BorderStyle    := bsDialog;
      BorderStyle    := bsToolWindow;
      FormStyle         := fsStayOnTop;
      BorderIcons      := [];
      Caption          := ACaption;
      ClientWidth    := MulDiv(Screen.Width div 4, DialogUnits.X, 4);
      ClientHeight    := MulDiv(23 + (Lines*10), DialogUnits.Y, 8);
      Position          := poScreenCenter;

      Prompt             := TLabel.Create(Form);
      with Prompt do
      begin
        Parent          := Form;
        AutoSize       := True;
        Left             := MulDiv(8, DialogUnits.X, 4);
        Top             := MulDiv(8, DialogUnits.Y, 8);
        Caption       := APrompt;
      end;

      Form.Width:=Prompt.Width+Prompt.Left+50;  //mcg fix

      Show;
      Application.ProcessMessages;
      if AppClose= true then
      Application.Terminate;
    finally
       Sleep(DuracaoEmSegundos*1000);
      Form.Free;
    end;
end;


procedure TUtilitise.RemoveEntryFromRegistry(AppName:String);
var key: string;
     Reg: TRegIniFile;
begin
  key := '\Software\Microsoft\Windows\CurrentVersion\Run';
  Reg:=TRegIniFile.Create;
try
  Reg.RootKey:=HKey_Local_Machine;
  if Reg.OpenKey(Key,False) then Reg.DeleteValue(AppName);
  finally
  Reg.Free;
  end;
end;

procedure TUtilitise.SetAutoStart_REG(AppName, AppTitle: string; bRegister: Boolean);
const
  RegKey = '\Software\Microsoft\Windows\CurrentVersion\Run';
  // or: RegKey = '\Software\Microsoft\Windows\CurrentVersion\RunOnce';
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    if Registry.OpenKey(RegKey, False) then
    begin
      if bRegister = False then
        Registry.DeleteValue(AppTitle)
      else
        Registry.WriteString(AppTitle, AppName);
    end;
  finally
    Registry.Free;
  end;
end;
procedure TUtilitise.CreateFile(const filename:String;source:String);
var
  F: TextFile;
begin
 AssignFile(F, filename);
  ReWrite(F);
  Write(F, source);
  //Write(F, source);
  CloseFile(F)
end;

function TUtilitise.FileDecryption(const filename:String;key:String):String;
var
  text, temp,fullFileName,fileini: string;
  F: TextFile;
begin
  if FileExists(filename) then
  begin
     AssignFile(F, filename);
  // Reopen the file for reading
  Reset(F);

  // Display the file contents
  while not Eof(F) do
  begin
    ReadLn(F, text);
    temp := temp + text;
  end;
  // Close the file for the last time
  CloseFile(F);
  Result := seedDcpFromSHA256(key, temp);
  end else Result:='NAN';
end;
function TUtilitise.FileEncryption(const filename:String;key:String;source:String):String;
var
  textString: string;
  F: TextFile;
begin
  AssignFile(F, filename);
  ReWrite(F);
  textString := SeedEncToSHA256(key, source);
  Write(F, textString);
  //Write(F, source);
  CloseFile(F);
  Result := 'Success';
end;
function TUtilitise.FileVersion(const FileName: TFileName): String;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
begin
  Result := 'null';
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
          Result := Format('v%d.%d.%d build %d', [
            HiWord(dwFileVersionMS), //Major
            LoWord(dwFileVersionMS), //Minor
            HiWord(dwFileVersionLS), //Release
            LoWord(dwFileVersionLS)]); //Build
  finally
    FreeMem(PVerInfo, VerInfoSize);
  end;
end;

function TUtilitise.FindFile(const path, extension: string): TStringList;
var
  SR: TSearchRec;
  FileList : TStringList;
begin
  if FindFirst(Path + '\*.' + extension, faAnyFile, SR) = 0 then
  begin
    FileList := TStringList.Create;
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        FileList.Add(SR.Name);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
  Result := FileList;

end;

end.
