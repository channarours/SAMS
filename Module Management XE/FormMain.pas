unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.ComCtrls, uMethod, System.IniFiles, MySeed, FormParam,
  mTypes, GetKHAversion, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP,Contnrs,FormSetting,MySetting,MyMail,uUtilitise,MyObject;

const
  wm_start = WM_USER + $1005;

type
  TMainForm = class(TForm)
    mmBar: TMainMenu;
    mniModule: TMenuItem;
    pnlWorkArea: TPanel;
    pnlTop: TPanel;
    pnlSearch: TPanel;
    pnlDate: TPanel;
    srchModule: TSearchBox;
    dtpFrom: TDateTimePicker;
    lblTo: TLabel;
    dtpTo: TDateTimePicker;
    btnStart: TButton;
    btnUpdate: TButton;
    lvModule: TListView;
    pnlinDateL: TPanel;
    pnlinDateR: TPanel;
    stat1: TStatusBar;
    trycn: TTrayIcon;
    pnlMainForm: TPanel;
    pnlModuelInfo: TPanel;
    pnlLModule: TPanel;
    pnlRModule: TPanel;
    pnlLTmodule: TPanel;
    pnlLBModule: TPanel;
    lvModuleInfo: TListView;
    srchModuleName: TSearchBox;
    pnlRTModule: TPanel;
    pnlRBModule: TPanel;
    grpMoudleInfo: TGroupBox;
    grdpnlModule: TGridPanel;
    lblName: TLabel;
    edtName: TEdit;
    lblType: TLabel;
    edtType: TEdit;
    lblService: TLabel;
    edtService: TEdit;
    lblCode: TLabel;
    edtCode: TEdit;
    lblParam: TLabel;
    edtParam: TEdit;
    pnlRBButton: TPanel;
    btnSave: TButton;
    btnDelete: TButton;
    Main: TMenuItem;
    Setting1: TMenuItem;
    Help1: TMenuItem;
    AboutUS1: TMenuItem;
    btnCount: TButton;

    { Panel Main Form Interface code }
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure InitComp();
    procedure lvModuleAdvancedCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: Boolean);
    procedure loadModuleToMainForm();
    procedure btnStartClick(Sender: TObject);
    procedure statusClicked();
    procedure trycnClick(Sender: TObject);

    // Menu code Interface coding
    procedure MainClick(Sender: TObject);
    procedure New1Click(Sender: TObject);
    // End Menu code Interface coding

    { End Main Form Interface code }

    { Panel Module Infomation Interface code }
    procedure loadFiletoNewModuleInfo();
    procedure loadModuleInfo();
    procedure clearEdit();
    procedure saveModule(Sender: TObject);
    procedure lvModuleInfoClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure edtParamClick(Sender: TObject);
    procedure mniModuleClick(Sender: TObject);
    procedure btnCountClick(Sender: TObject);
    procedure Setting1Click(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);

    { End Module infomation Interface code }
  private
    { Private declarations }
  public
    procedure _ExecuteAndWait(const aCommander: string);
    procedure _ExecMultiProcess(ProgramName: String; Wait: Boolean);
    procedure _wmReceiveData(var msg: TWMCopyData); message WM_COPYDATA;
    procedure _wmStart(var msg: TMessage); message wm_start;
    function getModuleDir:string;
    function getModuleExt:String;
  end;
var
  MainForm: TMainForm;
  TMSetting: TFSetting;
  FmyUser:TUser;

implementation
uses
  drawprogressU;
{ Object to use with multi thread }

type
  TMyThread = class(TThread)
    procedure Execute; override;
  end;

  TModule = class(TObject)
    index: integer;
    types: string;
    name: string;
    service: string;
    code: string;
    status: string;
    keycode: string;
    result: string;
    version: string;
  end;

  TExModuleList = class(TObjectList)
  protected
    procedure setModule(I: Integer; obj: TModule);
    function getModule(I: Integer): TModule;
  public
    property Module[I: Integer]: TModule read getModule write setModule;
  end;
    { Object to use with multi thread }
var
   ExModulelist:TExModuleList;
   ModuleList:TExModuleList; // ArrayList **************
{$R *.dfm}
{ Execute Module list ------> }
procedure TExModuleList.setModule(I: Integer; obj: TModule);
begin
  Items[I] := obj;
end;

function TExModuleList.getModule(I: Integer): TModule;
begin
  Result := TModule(Items[I]);
end;

{ End Execute Module list <--------- }

{ Panel Main Form code implementation -------> }
procedure TMainForm.FormCreate(Sender: TObject);
var
  strs: string;
begin
  pnlModuelInfo.Visible := false;
  pnlMainForm.Visible := True;
  ExModulelist := TExModuleList.Create;
  ModuleList := TExModuleList.Create;
  loadModuleToMainForm;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  InitComp;
end;

function TMainForm.getModuleDir: string;
begin
  Result := sUserTemp.getSetting.getModuleSetting.GetmoduleDir;
end;

function TMainForm.getModuleExt: String;
begin
  Result := sUserTemp.getSetting.getModuleSetting.Getextension;
end;

procedure TMainForm.InitComp;
var
  lvX: Integer;
begin
  lvX := lvModule.Width;
  lvModule.Columns[0].Width := Round((lvX * 3) / 100);
  lvModule.Columns[1].Width := Round((lvX * 12) / 100);
  lvModule.Columns[2].Width := Round((lvX * 12) / 100);
  lvModule.Columns[3].Width := Round((lvX * 12) / 100);
  lvModule.Columns[4].Width := Round((lvX * 12) / 100) - 1;
  lvModule.Columns[5].Width := Round((lvX * 25) / 100) - 2;
  lvModule.Columns[6].Width := Round((lvX * 12) / 100) - 2;
  lvModule.Columns[7].Width := Round((lvX * 12) / 100) - 2;
  lvModule.Refresh;
  lvX := lvModuleInfo.Width;
  lvModuleInfo.Columns[0].Width := Round((lvX * 19) / 100) - 4;
  lvModuleInfo.Columns[1].Width := Round((lvX * 40) / 100);
  lvModuleInfo.Columns[2].Width := Round((lvX * 40) / 100);
  lvModuleInfo.Refresh;

  if Self.Width > 900 then
  begin
    pnlRBButton.Margins.Bottom := 30;
    grpMoudleInfo.Margins.Bottom := 280;
  end
  else
  begin
    grpMoudleInfo.Margins.Bottom := 150;
    pnlRBButton.Margins.Bottom := 10;
  end;

end;

procedure TMainForm.lvModuleAdvancedCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
const
  ProgressBarCol = 5;
  Max = 100;
var
  Rct, PBRct: TRect;
  Percent: Integer;
  I: Integer;
begin
  if (SubItem = ProgressBarCol) and (Stage = cdPostPaint) then
  begin
    Percent := Integer(Item.Data);
    SetBkMode(Sender.Canvas.Handle, TRANSPARENT);

    Rct := Item.DisplayRect(drBounds);
    for I := 0 to SubItem - 1 do
      Rct.Left := Rct.Left + Sender.Column[I].Width;
    Rct.Right := Rct.Left + Sender.Column[SubItem].Width;
    // Sender.Canvas.TextOut(Rct.Left + 2, Rct.Top + 2, IntToStr(Percent) + '%');

    PBRct.Left := Rct.Left + Sender.Canvas.TextWidth('100') - 18;
    PBRct.Right := Rct.Right - 2;
    PBRct.Top := Rct.Top + 2;
    PBRct.Bottom := Rct.Bottom - 2;
    if PBRct.Right > PBRct.Left then
      if Percent <= Max then
      begin
        if (Percent = 0) then
        begin
          DrawProgress(Sender.Canvas, PBRct, Percent, Max, clLime, '', lvModule.Font);
        end
        else if (Percent > 0) and (Percent < Max) then
        begin
          DrawProgress(Sender.Canvas, PBRct, Percent, Max, clRed, 'Processing', lvModule.Font);
        end
        else if (Percent = Max) then
          DrawProgress(Sender.Canvas, PBRct, Percent, Max, clLime, 'completed', lvModule.Font);
      end;
  end

end;

procedure TMainForm.loadModuleToMainForm;
var
 i:Integer;
begin
  with sUserTemp.getModuleList.getModuleInfo do
  begin
    if Count > 0 then
    begin
      lvModule.Clear;
      for i := 0 to Count - 1 do
      begin
        with lvModule.Items.Add do
        begin
          Caption := '';
          SubItems.Add(Items[i].Getname);
          SubItems.Add(Items[i].Gettypes);
          SubItems.Add(Items[i].Getservice);
          SubItems.Add(Items[i].Getcode);
          SubItems.Add('');
          SubItems.Add('');
          SubItems.Add(myUtilitise.FileVersion(getModuleDir + '\' + Items[i].Getcode + '.' + getModuleExt));
        end;
      end;

    end;
  end;



end;

procedure TMainForm.statusClicked;
const
  statusLeft = 76;
  statusRight = 88;
var
  pt: TPoint;
  lvX, pos: Integer;
begin
  pt := lvModule.ScreenToClient(Mouse.CursorPos);
  lvX := lvModule.Width;
  pos := Round((pt.X * 100) / lvX);
  if (pos > statusLeft) and (pos < statusRight) then
    ShowMessage(Format('Pixel x : %d%', [pos]));

end;

// Menu code implementation
procedure TMainForm.MainClick(Sender: TObject);
begin
  pnlMainForm.Visible := True;
  pnlModuelInfo.Visible := false;
  InitComp;
  loadModuleToMainForm;
end;

procedure TMainForm.New1Click(Sender: TObject);
begin
  pnlMainForm.Visible := false;
  pnlModuelInfo.Visible := True;
  InitComp;
  loadFiletoNewModuleInfo;
end;
// End Menu code implementation
{ End Panel Main Form code implementaion <------- }

{ Module Management Code block -------> }

procedure TMainForm._ExecuteAndWait(const aCommander: string);
var
  tmpStartupInfo: TStartupInfo;
  tmpProcessInformation: TProcessInformation;
  tmpProgram: string;
begin
  tmpProgram := Trim(aCommander);
  FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
  with tmpStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    wShowWindow := SW_HIDE;
  end;
  // ShowMessage('1');
  if CreateProcess(nil, pchar(tmpProgram), nil, nil, True, CREATE_NO_WINDOW, nil, nil, tmpStartupInfo, tmpProcessInformation) then
  begin
    // loop every 10 ms
    while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
    end;
    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);
  end
  else
  begin
    RaiseLastOSError;
  end;

end;

procedure TMainForm._ExecMultiProcess(ProgramName: string; Wait: Boolean);
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: Boolean;
  ProcID: Integer;
begin
  { fill with known state }
  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);
  CreateOK := CreateProcess(nil, pchar(ProgramName), nil, nil, false, CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);
  { check to see if successful }
  if CreateOK then
  begin
    // may or may not be needed. Usually wait for child processes
    if Wait then
      WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  end
  else
  begin
    ShowMessage('Unable to run ' + ProgramName);
  end;
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;

procedure TMainForm._wmReceiveData(var msg: TWMCopyData);
var
  progress: Integer;
  I,mIndex,lIndex: Integer;
  senderMessage:String;
  senderName   : String;
  senderStatus : string;
  senderProgress:string;
  senderIsKilled:string;
begin
  senderMessage := pchar(msg.CopyDataStruct.lpData);
  senderName    := Trim(StrGrab(senderMessage, '[', ':'));
  senderStatus  := Trim(StrGrab(senderMessage, ':', ']'));
  senderProgress:= Trim(StrGrab(senderMessage, '(', ')'));
  senderIsKilled:= Trim(StrGrab(senderMessage, '*', '*'));



  with sUserTemp.getModuleProcessList.getProcess do
  begin
    for i := 0 to count -1  do
      begin
        if SameText(senderName,Items[i].GetmName) then
        begin
          lIndex := Items[i].GetlIndex;
          mIndex := Items[i].GetmIndex;
          Items[i].SetmStatus(senderIsKilled);

          // set progress bar
          if senderProgress.IsEmpty then
             progress := 0
          else
             progress := StrToInt(senderProgress);

          with lvModule.Items.Item[lIndex] do
          begin
            // update progress bar
            Data := Pointer(progress);
            // Update Status
            SubItems[5] := senderStatus;
          end;

          // Check Process
        if Pos(M_SDT_RESULT, senderMessage) <> 0 then
        begin
          Items[i].SetmResult(senderStatus);
        end
        else if Pos(M_SDT_ERROR, senderMessage) <> 0 then
        begin
          Items[i].SetmKeycode(senderStatus);
        end;
        end;
      end;
  end;
//
//
//
//  if not SameText(dclSMProcess, '') then
//    progress := StrToInt(dclSMProcess)
//  else
//    progress := 0;
//
//  for I := 0 to lvModule.Items.Count - 1 do
//  begin
//    with
//     lvModule.Items.Item[I] do
//    begin
//      if SameText(dclSMName, SubItems[3]) then
//      begin
//        dclI := I;
//        SubItems[5] := dclSMStatus;
//        Data := Pointer(progress);
//      end;
//    end;
//    lvModule.Refresh;
//  end;
//
//  for I := 0 to ExModulelist.Count - 1 do
//  begin
//    if SameText(dclSMName, ExModulelist.getModule(i).name) then
//    begin
//      ExModulelist.getModule(i).status := dclSMThread;
//    end;
//  end;
//
//  for I := 0 to ModuleList.Count - 1 do
//  begin
//    if SameText(dclSMName, ModuleList.getModule(i).name) then
//    begin
//      ModuleList.getModule(i).status := dclSMStatus;
//    end;
//  end;
//
//  if pos(M_SDT_RESULT, dclDataStr) <> 0 then
//  begin
//     //ShowMessage(dclDataStr);
//    for I := 0 to ModuleList.Count - 1 do
//    begin
//      if SameText(dclSMName, ModuleList.getModule(i).name) then
//      begin
//        ModuleList.getModule(i).result := dclSMStatus;
//      end;
//    end;
//  end;
//  if pos(M_SDT_STATUS, dclDataStr) <> 0 then
//       //ShowMessage(dclDataStr);
//  begin
//    for I := 0 to ModuleList.Count - 1 do
//    begin
//      if SameText(dclSMName, ModuleList.getModule(i).name) then
//      begin
//        ModuleList.getModule(i).status := dclSMStatus;
//      end;
//    end;
//  end;
//  if pos(M_SDT_ERROR, dclDataStr) <> 0 then
//       //ShowMessage(dclDataStr);
//  begin
//    for I := 0 to ModuleList.Count - 1 do
//    begin
//      if SameText(dclSMName, ModuleList.getModule(i).name) then
//      begin
//        ModuleList.getModule(i).keycode := dclSMStatus;
//      end;
//    end;
//  end;

end;

procedure TMainForm._wmStart(var msg: TMessage);
var
  MyThread: TMyThread;
begin
  MyThread := TMyThread.Create(True);
  MyThread.FreeOnTerminate := True;
  MyThread.Start;
end;
{ End Module Management Code block <------- }

{ Panel Module Infomation code implementation -------> }

procedure TMainForm.loadFiletoNewModuleInfo;
var
  dclInitFile: TIniFile;
  dclSection: TStringList;
  dclI, I: Integer;
  dclMName, dclMType: string;
  dclParam, delimeter: string;
begin
  lvModuleInfo.Clear;
  delimeter := '|';

  // Clear all Textedit control
  for I := 0 to grdpnlModule.ControlCount - 1 do
    if grdpnlModule.Controls[I] is TEdit then
    begin
      (grdpnlModule.Controls[I] as TEdit).Clear;
    end;
  // Disable btnDelete
  btnDelete.Enabled := false;
  // Checking file ModuleInfo.reg exist...
  if FileExists(ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg') then
  begin
    // dclInitFile := TIniFile.Create(ExtractFilePath(ParamStr(0) + 'Logs\ModuleInfo.reg'));
    dclInitFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Logs\ModuleInfo.reg');
    dclSection := TStringList.Create;
    dclInitFile.ReadSections(dclSection);
    for dclI := 0 to dclSection.Count - 1 do
    begin
      dclParam := dclInitFile.ReadString('Module' + IntToStr(dclI), 'ModuleInfo', '');
      dclParam := seedDcpFromSHA256('ModuleInfo', dclParam);
      dclMName := StrGrab(dclParam, delimeter, delimeter, 1);
      dclMType := StrGrab(dclParam, delimeter, delimeter, 2);

      // adding module information to lvModuleInfo
      with lvModuleInfo.Items.Add do
      begin
        Caption := IntToStr(dclI + 1);
        SubItems.Add(dclMName);
        SubItems.Add(dclMType);
      end;

    end;
  end
  else
    ShowMessage('File is not exsit...!')
end;

procedure TMainForm.loadModuleInfo;
var
  i: Integer;
begin
  with sUserTemp.getModuleList.getModuleInfo do
  begin
    if Count > 0 then
    begin
      lvModuleInfo.Clear;
      for i := 0 to Count - 1 do
      begin
        with lvModuleInfo.Items.Add do
        begin
          Caption := IntToStr(i + 1);
          SubItems.Add(Items[i].Getname);
          SubItems.Add(Items[i].Gettypes);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.saveModule(Sender: TObject);
var
index:Integer;
begin
  if lvModuleInfo.Selected <> nil then
  begin
    index := lvModuleInfo.Selected.Index;
    with sUserTemp.getModuleList.getModuleInfo.Items[index] do
    begin
      Setid(index);
      Setname(edtName.Text);
      Settypes(edtType.Text);
      Setservice(edtService.Text);
      Setcode(edtCode.Text);
      Setparam(edtParam.Text);
    end;
    updateData;
    ShowMessage('Update completed!');
  end;
  clearEdit;
  loadModuleInfo;

end;

procedure TMainForm.Setting1Click(Sender: TObject);
begin
  SSetting.Show;
end;

procedure TMainForm.btnCountClick(Sender: TObject);
var
  mResult: string;
  i: Integer;
begin
  for i := 0 to ModuleList.Count - 1 do
  begin
    with ModuleList.getModule(i) do
    begin
      mResult := 'Name : ' + name + #13#10 + 'Type : ' + types + #13#10 + 'Service : ' + service + #13#10 + 'status : ' + status + #13#10 + 'Keycode : ' + keycode + #13#10 + 'Version : ' + version + #13#10 + 'Result : ' + result;
    end;
    ShowMessage(mResult);
  end;
  ShowMessage(IntToStr(sUserTemp.getSetting.getScheduleSetting.getTask.Items[0].GetTaskid));
end;

procedure TMainForm.btnDeleteClick(Sender: TObject);
var
  index: Integer;
begin
  if lvModuleInfo.Selected <> nil then
  begin
    index := lvModuleInfo.Selected.Index;
    with sUserTemp.getModuleList.getModuleInfo do
    begin
      Remove(Items[index]);
    end;
    updateData;
    clearEdit;
    loadModuleInfo;
    ShowMessage('Delete Completed!');
  end;
end;

procedure TMainForm.lvModuleInfoClick(Sender: TObject);
var
  index: integer;
begin
  if lvModuleInfo.Selected <> nil then
  begin
    index := lvModuleInfo.Selected.Index;
    with sUserTemp.getModuleList.getModuleInfo.Items[index] do
    begin
      edtName.Text := Getname;
      edtType.Text := Gettypes;
      edtService.Text := Getservice;
      edtCode.Text := Getcode;
      edtParam.Text := Getparam;
    end;
  end;

end;

procedure TMainForm.edtParamClick(Sender: TObject);
var
  clsParam: TParam;
begin
  clsParam := TParam.Create(nil);
  edtParam.Text := clsParam.GetParam(edtParam.Text);
  FreeAndNil(clsParam);
end;

{ End Panel Module Infomation code implementaion  <-------- }
procedure TMainForm.btnStartClick(Sender: TObject);
var
  MyThread: TMyThread;
begin
  //SendMessage(Self.Handle, wm_start, 0, 0);

  MyThread := TMyThread.Create(True);
  MyThread.FreeOnTerminate := True;
  MyThread.Start;
end;

procedure TMainForm.btnUpdateClick(Sender: TObject);
var
  index:Integer;
begin
  if lvModule.Selected <> nil then
  begin
    index := lvModule.Selected.Index;
    pnlMainForm.Visible := false;
    pnlModuelInfo.Visible := True;
    loadModuleInfo;
    with sUserTemp.getModuleList.getModuleInfo.Items[index] do
    begin
      edtName.Text := Getname;
      edtType.Text := Gettypes;
      edtService.Text := Getservice;
      edtCode.Text := Getcode;
      edtParam.Text := Getparam;
    end;

  end;
end;

procedure TMainForm.clearEdit;
begin
  edtName.Clear;
  edtType.Clear;
  edtService.Clear;
  edtCode.Clear;
  edtParam.Clear;
end;

procedure TMainForm.mniModuleClick(Sender: TObject);
begin
  pnlMainForm.Visible := false;
  pnlModuelInfo.Visible := True;
  clearEdit;
  loadModuleInfo;
end;

{ Multi Processing Implementation code block }
procedure TMyThread.Execute;
var
  count,next,i,j: Integer;
  aParam, mExecute: string;
  remain_module: Integer;

  isCheck: Boolean;
  mPath, extension: string;
  terminated: string;
  mIndex:integer;
begin
  mPath := sUserTemp.getSetting.getModuleSetting.GetmoduleDir + '\';
  extension :='.'+ sUserTemp.getSetting.getModuleSetting.Getextension;
  isCheck := false;
  sUserTemp.getModuleProcessList.getProcess.Clear;
  try
    count := 0;
    // count all module that has checked to run
    for i := 0 to MainForm.lvModule.Items.Count - 1 do
    begin
      with MainForm.lvModule.Items[i] do
      begin
        if Checked then
        begin
          with sUserTemp.getModuleList.getModuleInfo do
          begin
            for j := 0 to count - 1  do
              begin
                if SameText(SubItems[3],Items[j].Getcode) then
                begin
                  with sUserTemp.getModuleProcessList do
                  begin
                    addProcess(i,j+1,Items[j].Getcode);
                  end;
                end;
              end;
          end;
          isCheck := true;
        end;
      end;
    end;
    // Access listview items with indx's value
    next := 0;
    with sUserTemp.getModuleProcessList.getProcess do
    begin
      remain_module := count;
      if isCheck = true then
      begin
        repeat
          with sUserTemp.getSetting.getModuleSetting do
          begin
            if remain_module <= Getthread then
            begin
              for i  := next to remain_module - 1 do
                begin
                  with sUserTemp.getModuleList.getModuleInfo do
                  begin
                    for j := 0 to count -1 do
                      begin



                        if Items[j].Getid = sUserTemp.getModuleProcessList.getProcess.Items[i].GetmIndex then
                        begin
                           aParam := Items[j].Getparam;
                           aParam := seedDcpFromSHA256('mParam', aParam);
                           aParam := StringReplace(aParam, '[DTP-START]', FormatDateTime('yyyymmdd', MainForm.dtpFrom.DateTime), [rfReplaceAll, rfIgnoreCase]);
                           aParam := StringReplace(aParam, '[DTP-END]', FormatDateTime('yyyymmdd', MainForm.dtpTo.DateTime), [rfReplaceAll, rfIgnoreCase]);
                           mExecute := mPath + Items[j].Getcode + extension;
                           MainForm._ExecMultiProcess(mExecute, false);
                        end;
                      end;
                  end;
                end;
                remain_module := 0;
            end
            else if remain_module > Getthread then
                 begin
                    for i := 0 to remain_module - 1 do
                    begin
                      with sUserTemp.getModuleList.getModuleInfo do
                      begin
                        for j := 0 to count - 1 do
                        begin
                          if Items[j].Getid = sUserTemp.getModuleProcessList.getProcess.Items[i].GetmIndex then
                          begin
                            aParam := Items[j].Getparam;
                            aParam := seedDcpFromSHA256('mParam', aParam);
                            aParam := StringReplace(aParam, '[DTP-START]', FormatDateTime('yyyymmdd', MainForm.dtpFrom.DateTime), [rfReplaceAll, rfIgnoreCase]);
                            aParam := StringReplace(aParam, '[DTP-END]', FormatDateTime('yyyymmdd', MainForm.dtpTo.DateTime), [rfReplaceAll, rfIgnoreCase]);
                            mExecute := mPath + Items[j].Getcode + extension;
                            MainForm._ExecMultiProcess(mExecute, false);
                            sUserTemp.getModuleProcessList.getProcess.Items[i].SetmStatus('Running');
                          end;
                        end;
                      end;
                      Inc(next);
                    end;
                    terminated := 'False';
                      repeat
                        with sUserTemp.getModuleProcessList.getProcess do
                        begin
                          for j := 0 to Count - 1 do
                            begin
                              if SameText('Running',Items[i].GetmStatus) then
                              begin
                                terminated := 'False';
                              end
                              else
                              begin
                                terminated := 'True';
                              end;
                            end;
                        end;
                      until terminated = 'True' ;
                    remain_module := remain_module - Getthread;
                 end;
          end;
        until remain_module = 0 ;
      end;
    end;
  except
    ShowMessage('Start Error...');
  end;
  if not isCheck then
    MessageBox(0, pchar('Please choose the module that you want to run!'), '', MB_OK + MB_ICONINFORMATION);
end;

{ End mulit Processing Implementation code block }

procedure TMainForm.trycnClick(Sender: TObject);
begin
  Self.Visible := True;
end;

end.
