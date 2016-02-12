unit FormSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.CheckLst, System.Actions, Vcl.ActnList, Vcl.WinXCtrls,
  uUtilitise, uTaskSchedule, MyMail, MySetting, Vcl.FileCtrl, uMethod,
  FormModuleInfo, myobject, Grids;

type
  TFSetting = class(TForm)
    ctgrypnlgrpSetting: TCategoryPanelGroup;
    ctgrypnlGeneral: TCategoryPanel;
    ctgrypnl2: TCategoryPanel;
    pnlRSetting: TPanel;
    pnlASchedule: TPanel;
    pnlASTop: TPanel;
    pnlASButtom: TPanel;
    grpAStop: TGroupBox;
    lblBegintask: TLabel;
    cbbtaskType: TComboBox;
    lblStart: TLabel;
    dtpSStartDate: TDateTimePicker;
    dtpSTime: TDateTimePicker;
    rgChoose: TRadioGroup;
    chklstDays: TCheckListBox;
    edtadminMail: TEdit;
    btnRemove: TButton;
    btnOk: TButton;
    btnCancle: TButton;
    mmoMailBody: TMemo;
    tvTaskManager: TTreeView;
    tvGeneral: TTreeView;
    pnlErrorSetting: TPanel;
    pnlErrorTop: TPanel;
    pnlErrorButtom: TPanel;
    pnlErrorKeyTButtom: TPanel;
    lblSearchkey: TLabel;
    btnSave: TButton;
    grpErrorKey: TGroupBox;
    lblKeycode: TLabel;
    edtkeycode: TEdit;
    lblDefinition: TLabel;
    mmoKeyDefinition: TMemo;
    pnlModuleSetting: TPanel;
    pnlTModuleSetting: TPanel;
    grpTModuleSetting: TGroupBox;
    lblModuleDir: TLabel;
    edtModuleDirs: TEdit;
    btnModuleDirs: TButton;
    lblModuleExtension: TLabel;
    edtModuleExtension: TEdit;
    lblModuleThread: TLabel;
    cbbModuleThread: TComboBox;
    btnModuleSettingOk: TButton;
    btnModuleSettingCancle: TButton;
    pnlBModuleSetting: TPanel;
    pnlMailSetting: TPanel;
    pnlTEmailSetting: TPanel;
    grpMailSetting: TGroupBox;
    lblserver: TLabel;
    edtMailServer: TEdit;
    lblserverpost: TLabel;
    edtServerPort: TEdit;
    lblEncryptSSL: TLabel;
    cbbSSL: TComboBox;
    grpMailUserPass: TGroupBox;
    btnMailApply: TButton;
    btnConnect: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    lblPassword: TLabel;
    lblUsername: TLabel;
    btnServerSave: TButton;
    btnCancel: TButton;
    chkMail: TCheckBox;
    lvTaskList: TListView;
    lvTModuleList: TListView;
    btnTSave: TButton;
    TaskList: TLabel;
    ModuleList: TLabel;
    lvmoduleSetting: TListView;
    lblCurrentModule: TLabel;
    pnlBBModuleSetting: TPanel;
    btnAddModuleInfo: TButton;
    lvErrorKeys: TListView;
    edtkeySearch: TEdit;
    lvServerList: TListView;
    T1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tvTaskManagerClick(Sender: TObject);
    procedure tvGeneralClick(Sender: TObject);
    procedure cbbtaskTypeChange(Sender: TObject);
    procedure btnCancleClick(Sender: TObject);
    procedure rgChooseClick(Sender: TObject);
    procedure chklstDaysClick(Sender: TObject);
    procedure dtpSStartDateChange(Sender: TObject);
    procedure dtpSTimeChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnModuleDirsClick(Sender: TObject);
    procedure btnAddModuleInfoClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure lvErrorKeysDblClick(Sender: TObject);
    procedure edtkeySearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnServerSaveClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnMailApplyClick(Sender: TObject);
    procedure lvServerListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure init;
    procedure btnModuleSettingOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvmoduleSettingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SSetting: TFSetting;
  mySchedule: TSchedule;
  myUser: TUser;
  AppPath: string;
  AppFullPath: string;
  rgOption: string;
  dtpDatePick: string;
  dtpTimePick: string;
  dayPick: string;
  QueryTask: string;
  keydata: string;
  code, defi: string;

implementation

{$R *.dfm}
const
  TaskTitle = 'SAMS'; // Task Title, use to apply task schedule setting
  FileKey = '..\data\key.txt';

procedure TFSetting.btnAddModuleInfoClick(Sender: TObject);
var
  command:string;
  index :integer;
  moCode:String;
begin
  if lvmoduleSetting.Selected <> nil then
  begin
    index := lvmoduleSetting.Selected.Index;
    command := btnAddModuleInfo.Caption;
    moCode := lvmoduleSetting.Items.Item[index].SubItems[0];
    if SameText(command, 'Update information') then
    begin
      frmModuleInfo.getCommand(moCode, 'update');
      frmModuleInfo.Show;
    end
    else if SameText(command, 'Add information') then
    begin
      frmModuleInfo.getCommand(moCode, 'add');
      frmModuleInfo.Show;

    end;

  end;
end;



procedure TFSetting.btnCancleClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFSetting.btnConnectClick(Sender: TObject);
begin
  sUserTemp.getSetting.getEmailSetting.addAccount(edtUsername.Text, edtPassword.Text);
  with sUserTemp.getSetting.getEmailSetting.getAccount do
  begin
    with sUserTemp.getSetting.getEmailSetting.getServerList.Items[0] do
    begin
      myemail.setServer(Gethost);
      myemail.setPort(Getport);
      myemail.setTLS(Getsecure);
      myemail.connect(Getusername, Getpassword);
      myemail.isAuthentication;
    end;
  end;
end;

procedure TFSetting.btnMailApplyClick(Sender: TObject);
begin
  // clear edit text
  edtServerPort.Clear;
  edtMailServer.Clear;
  cbbSSL.Text := 'True';
  edtUsername.Clear;
  edtPassword.Clear;
end;

procedure TFSetting.btnModuleDirsClick(Sender: TObject);
var
  SELDIRHELP: Integer;
  Dir: string;
  FileList: TStringList;
  name: string;
  i: integer;
begin
  Dir := GetCurrentDir;
  SELDIRHELP := 1000;
  if Vcl.FileCtrl.SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP) then
  begin
    edtModuleDirs.Text := Dir;
    FileList := TStringList.Create;
    // insert file information to lvModulelist
    FileList := myUtilitise.FindFile(Dir, edtModuleExtension.Text);
    for i := 0 to FileList.Count - 1 do
    begin
      with lvmoduleSetting.Items.Add do
      begin
        name := StrGrab(FileList.Strings[i], '', '.');
        Caption := IntToStr(i + 1);
        SubItems.Add(name);
        SubItems.Add(myUtilitise.FileVersion(Dir + '\' + FileList.Strings[i]));
      end;
    end;

  end;

end;

procedure TFSetting.btnModuleSettingOkClick(Sender: TObject);
var
  temp:String;
begin

  with sUserTemp.getSetting.getModuleSetting do
  begin
    SetmoduleDir(edtModuleDirs.Text);
    Setextension(edtModuleExtension.Text);
    Setthread(StrToInt(cbbModuleThread.Text));
  end;

  temp := myJsoun.toJson(sUserTemp);
  myUtilitise.CreateFile(FileCore,temp);
end;

procedure TFSetting.btnOkClick(Sender: TObject);
var
  buttonSelected: Integer;
  str: string;
begin

  case cbbtaskType.ItemIndex of
    0:
      begin // on schedule
        case rgChoose.ItemIndex of
          0:
            begin // One Time
              QueryTask := '/Create /SC ' + rgOption + ' /TN "' + TaskTitle + '" /TR "' + AppFullPath + '" /ST ' + dtpTimePick + ' /f';
              sUserTemp.getSetting.getScheduleSetting.addTask(0, cbbtaskType.Items[cbbtaskType.ItemIndex], TTaskType.onSchedule, TScheduleType.oneTime, dtpDatePick, dtpTimePick, AppFullPath);
            end;
          1:
            begin // on Daily
              QueryTask := '/Create /SC ' + rgOption + ' /TN "' + TaskTitle + '" /TR "' + AppFullPath + '" /ST ' + dtpTimePick + ' /f';
              sUserTemp.getSetting.getScheduleSetting.addTask(0, cbbtaskType.Items[cbbtaskType.ItemIndex], TTaskType.onSchedule, TScheduleType.onDaily, '', dtpTimePick, AppFullPath);
            end;
          2:
            begin // on Weekly
              QueryTask := '/Create /SC ' + rgOption + ' /D ' + dayPick + ' /TN "' + TaskTitle + '" /TR "' + AppFullPath + '" /ST ' + dtpTimePick + ' /f';
              sUserTemp.getSetting.getScheduleSetting.addTask(0, cbbtaskType.Items[cbbtaskType.ItemIndex], TTaskType.onSchedule, TScheduleType.onWeekly, dayPick, dtpTimePick, AppFullPath);
            end;
        end;
      end;
    1:
      begin // on logon
        sUserTemp.getSetting.getScheduleSetting.addTask(1, cbbtaskType.Items[cbbtaskType.ItemIndex], TTaskType.onLogOn, TScheduleType.Undefine, '', '', AppFullPath);
        QueryTask := '/Create /SC ' + cbbtaskType.Items[cbbtaskType.ItemIndex] + ' /TN "' + TaskTitle + '" /TR "' + AppFullPath + '" /f';
      end;
    2:
      begin // on start
        sUserTemp.getSetting.getScheduleSetting.addTask(2, cbbtaskType.Items[cbbtaskType.ItemIndex], TTaskType.onStartUp, TScheduleType.Undefine, '', '', AppFullPath);
        myUtilitise.SetAutoStart_REG(AppFullPath, TaskTitle, true);
      end;
  end;
  if cbbtaskType.ItemIndex >= 2 then
  begin
    buttonSelected := messagedlg('Task Updated : ' + cbbtaskType.Items[cbbtaskType.ItemIndex], mtWarning, mbOKCancel, 0);
    if buttonSelected = mrOK then
    begin
      mySchedule.AddTask(QueryTask);
      str := myJsoun.toJson(myUser);
      myUtilitise.CreateFile(fileCore, str);
    end;
  end;
end;

procedure TFSetting.btnRemoveClick(Sender: TObject);
var
  buttonSelected: Integer;
begin

  buttonSelected := messagedlg('Task Remove', mtWarning, mbOKCancel, 0);
  if buttonSelected = mrOK then
  begin
    mySchedule.RemoveTask(TaskTitle);
    myUtilitise.RemoveEntryFromRegistry(TaskTitle);
  end;
end;

procedure TFSetting.btnSaveClick(Sender: TObject);
var
  lastRow: Integer;
  Code: string;
  i: Integer;
  notExit: Boolean;
begin
  notExit := False;
  lastRow := lvErrorKeys.Items.Count;
  if (edtKeyCode.Text = '') or (mmoKeyDefinition.Text = '') or (Length(edtKeyCode.Text) > 10) then
    ShowMessage('Invalid data!!!')
  else
  begin
    for i := 0 to lastRow - 1 do
      if SameText(lvErrorKeys.Items[i].SubItems[0], edtKeyCode.Text) then
      begin
        ShowMessage('Duplicated Data');
        notExit := true;
        break;
      end;
  end;

  if notExit = False then
  begin
    Code := Copy(edtKeyCode.text, 1, 10);
    with lvErrorKeys.Items.Add do
    begin
      Caption := IntToStr(lastRow + 1);
      SubItems.Add(edtkeycode.Text);
      SubItems.Add(mmoKeyDefinition.Text);
    end;

    Insert(',[(' + edtKeyCode.Text + ')]={[_' + mmoKeyDefinition.Text + '_]}', keydata, Pos('}}', keydata) + 1);

    myUtilitise.CreateFile(FileKey, keydata);
    edtKeyCode.Text := '';
    mmoKeyDefinition.Lines.Clear;
  end;
end;

procedure TFSetting.btnServerSaveClick(Sender: TObject);
var
  ind, lastrow, buttonSelected: Integer;
  Servername, Port: string;
  i: Integer;
  notExit: Boolean;
begin
    notExit := True;
    lastRow := lvServerList.Items.Count;
    if (edtMailServer.Text = '') or (edtServerPort.Text = '') then
    begin
      ShowMessage('Invalid data!!!');
    end
    else if lastrow = 0 then
    begin
      notExit:= True;
    end
    else if lastrow > 0 then
    begin
      ShowMessage('Items count :'+IntToStr(lastrow));
      for i := 0 to lastrow-1 do
      begin
        //ShowMessage(lvServerList.Items[i].SubItems[0]+''+lvServerList.Items[i].SubItems[1]);
        if SameText(edtMailServer.Text, lvServerList.Items[i].SubItems[0]) and SameText(edtServerPort.Text, lvServerList.Items[i].SubItems[1]) then // duplicate data
          begin
            ShowMessage('Server Duplicated');
            notExit:=False;
          end
        {with lvServerList.Items[i] do
        begin
          ShowMessage(SubItems[0]+''+SubItems[1]);
          if SameText(edtMailServer.Text, SubItems[0]) and SameText(edtServerPort.Text, SubItems[1]) then // duplicate data
          begin
            ShowMessage('Server Duplicated');
            break;
          end
          else
          begin // Not Duplicate data
            ShowMessage('Index : '+IntToStr(i));
            notExit := True;

            //break;
            break;
          end;
        end;}
      end;
  end;
  if notExit = True then
  begin
    with sUserTemp.getSetting.getEmailSetting do
    begin
      addServer(edtMailServer.Text, StrToInt(edtServerPort.Text), StrToBool(cbbSSL.Text), False);
    end;
    with lvServerList.Items.Add do
    begin
      Caption := IntToStr(lvServerList.Items.Count);
      SubItems.Add(edtMailServer.Text);
      SubItems.Add(edtServerPort.Text);
      SubItems.Add(cbbSSL.Text);
      SubItems.Add('False');
    end;
  end;
  // Enable Task Connect and Apply
  edtUsername.Enabled := True;
  edtPassword.Enabled := True;
  btnConnect.Enabled := True;
  btnMailApply.Enabled := True;
        // Add To Servers to Listview;
end;

procedure TFSetting.cbbtaskTypeChange(Sender: TObject);
var
  itemTitle: string;
  itemIndex: Byte;
begin
  itemTitle := cbbtaskType.Items[cbbtaskType.ItemIndex];
  itemIndex := cbbtaskType.ItemIndex;
  if itemIndex = 0 then
  begin
  {***Enable Tool Automatic Schedule block***}
    chklstDays.Enabled := False;
    rgChoose.Enabled := True;
    dtpSStartDate.Enabled := False;
    dtpSTime.Enabled := False;
  {---Enable Tool Automatic Schedule block---}
  end;

end;

procedure TFSetting.chklstDaysClick(Sender: TObject);
begin
  dayPick := myUtilitise.GetValueCheckListBox(chklstDays);
end;

procedure TFSetting.dtpSStartDateChange(Sender: TObject);
begin
  dtpDatePick := DateToStr(dtpSStartDate.Date);
end;

procedure TFSetting.dtpSTimeChange(Sender: TObject);
begin
  dtpTimePick := TimeToStr(dtpSTime.time);
end;

procedure TFSetting.edtkeySearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  if (edtkeySearch.Text = '') or (Length(edtkeySearch.Text) > 8) then
    mmoKeyDefinition.Lines.Clear()
  else
  begin

    for i := 0 to lvErrorKeys.Items.Count - 1 do
      if SameText(lvErrorKeys.Items[i].SubItems[0], edtkeySearch.Text) then
      begin
        lvErrorKeys.Items[i].Selected := true;
        lvErrorKeys.Scroll(0, i * Abs(lvErrorKeys.Font.Height));
        lvErrorKeys.SetFocus;
        break;
      end;
  end;
end;

procedure TFSetting.FormCreate(Sender: TObject);
var
  lvX: Integer;
  j, i: Integer;
begin
  i := 1;
  lvX := lvErrorKeys.Width;

  lvErrorKeys.Columns[0].Width := Round((lvX * 10) / 100);
  lvErrorKeys.Columns[1].Width := Round((lvX * 30) / 100);
  lvErrorKeys.Columns[2].Width := Round((lvX * 59) / 100);
  lvErrorKeys.Refresh;
  //Transfer key data to object keydata
  keydata := myUtilitise.ReadFile(FileKey);
  //lvErrorKeys.Items.Add.Caption:='DDD';
  while True do
  begin
    code := StrGrab(keydata, '[(', ')]', i);
    defi := StrGrab(keydata, '{[_', '_]}', i);

    if (code <> '') then
    begin
      with lvErrorKeys.Items.Add do
      begin
        Caption := IntToStr(i);
        SubItems.Add(code);
        SubItems.Add(defi);
      end;
      Inc(i);
    end
    else
    begin
      break;
    end;
  end;
  //-----------------------------------
  edtUsername.Enabled := False;
  edtPassword.Enabled := False;
  btnConnect.Enabled := False;
  btnMailApply.Enabled := False;

  cbbSSL.Text := 'True';
  pnlRSetting.Visible := true;
  pnlErrorSetting.Visible := False;
  pnlASchedule.Visible := False;
  pnlMailSetting.Visible := False;
  pnlModuleSetting.Visible := False;
  AppPath := ExtractFilePath(Application.ExeName);
  AppFullPath := Application.ExeName;
end;

procedure TFSetting.FormShow(Sender: TObject);
begin
init;
end;

procedure TFSetting.init;
var
  FileList :TStringList;
  i,j:Integer;
begin
  { Module Setting }

  with sUserTemp.getSetting.getModuleSetting do
  begin

    edtModuleDirs.Text := GetmoduleDir;
    edtModuleExtension.Text := Getextension;
    cbbModuleThread.Text    := IntToStr(Getthread);
     FileList := TStringList.Create;
    // insert file information to lvModulelist
    FileList := myUtilitise.FindFile(GetmoduleDir,Getextension);
    if FileList <> nil then
    begin
      lvmoduleSetting.Clear;
      for i := 0 to FileList.Count - 1 do
        begin
            with lvmoduleSetting.Items.Add do
            begin
              name    := StrGrab(FileList.Strings[i],'','.');
              Caption := IntToStr(i+1);
              SubItems.Add(name);
              SubItems.Add(myUtilitise.FileVersion(GetmoduleDir+'\'+FileList.Strings[i]));
              SubItems.Add('N/A');
            end;
        end;

      for i := 0 to lvmoduleSetting.Items.Count - 1 do
        begin
            with sUserTemp.getModuleList.getModuleInfo do
              begin
                for j := 0 to Count - 1 do
                begin
                  if SameText(lvmoduleSetting.Items.Item[i].SubItems[0],Items[j].Getcode) then
                  begin
                    lvmoduleSetting.Items.Item[i].SubItems[2] := '';
                  end;
                end;
              end;

        end;
    end;
  end;
end;

procedure TFSetting.lvErrorKeysDblClick(Sender: TObject);
var
  index: Integer;
begin
  index := lvErrorKeys.Selected.Index;
  ShowMessage(lvErrorKeys.Items[index].SubItems[1]);
end;

procedure TFSetting.lvmoduleSettingClick(Sender: TObject);
var
index : integer;
begin
  if lvmoduleSetting.Selected <> nil then
  begin
    index := lvmoduleSetting.Selected.Index;
    with lvmoduleSetting.Items.Item[index] do
    begin
      if SameText(SubItems[2], '') then
      begin
        btnAddModuleInfo.Enabled := true;
        btnAddModuleInfo.Caption := 'Update information';
      end
      else
      begin
        btnAddModuleInfo.Enabled := true;
        btnAddModuleInfo.Caption := 'Add information';
      end;

    end;
  end;
end;

procedure TFSetting.lvServerListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  with lvServerList.Selected do
  begin
    edtMailServer.Clear;
    edtServerPort.Clear;
    Sleep(500);
    edtMailServer.Text := SubItems[0];
    edtServerPort.Text := SubItems[1];
    cbbSSL.Text := SubItems[2];
  end;

end;

procedure TFSetting.rgChooseClick(Sender: TObject);
var
  index: Byte;
begin
  index := rgChoose.ItemIndex;
  if index = 2 then // weekly option
  begin
    rgOption := 'WEEKLY';
    chklstDays.Enabled := True;
    dtpSStartDate.Enabled := False;
    dtpSTime.Enabled := True;
  end
  else if index = 1 then // Daily Option
  begin
    rgOption := 'DAILY';
    chklstDays.Enabled := False;
    dtpSStartDate.Enabled := False;
    dtpSTime.Enabled := True;
  end
  else if index = 0 then
  begin
    rgOption := 'ONCE';
    chklstDays.Enabled := False;
    dtpSStartDate.Enabled := True;
    dtpSTime.Enabled := True;
  end;
end;

procedure TFSetting.tvGeneralClick(Sender: TObject);
var
  selectText: string;
begin
  if tvGeneral.Selected <> nil then
  begin
    selectText := tvGeneral.Selected.Text;
    if SameText(selectText, 'Error Setting') then
    begin
      pnlASchedule.Visible := False;
      pnlMailSetting.Visible := False;
      pnlErrorSetting.Visible := true;
    end
    else if SameText(selectText, 'Module Setting') then
    begin
      pnlModuleSetting.Visible := True;
      pnlErrorSetting.Visible := false;
      pnlMailSetting.Visible := False;
      pnlASchedule.Visible := False;
    end
    else if SameText(selectText, 'Mail Setting') then
    begin
      pnlMailSetting.Visible := True;
      pnlErrorSetting.Visible := False;
      pnlModuleSetting.Visible := False;
      pnlASchedule.Visible := False;
    end
    else
    begin
      pnlErrorSetting.Visible := False;
      pnlASchedule.Visible := False;
      pnlModuleSetting.Visible := False;
      pnlMailSetting.Visible := False;
      pnlRSetting.Visible := true;
    end;

  end;

end;

procedure TFSetting.tvTaskManagerClick(Sender: TObject);
var
  selectText: string;
begin
  if tvTaskManager.Selected <> nil then
  begin
    selectText := tvTaskManager.Selected.Text;

    if SameText(selectText, 'Automatic Schedule') then
    begin
      pnlASchedule.Visible := true;
      pnlErrorSetting.Visible := False;
      pnlMailSetting.Visible := False;
      pnlModuleSetting.Visible := False;

      {***Disable Tool Automatic Schedule block***}
      chklstDays.Enabled := False;
      rgChoose.Enabled := False;
      dtpSStartDate.Enabled := False;
      dtpSTime.Enabled := False;
      {---Disable Tool Automatic Schedule block---}
    end
    else
    begin
      pnlErrorSetting.Visible := False;
      pnlASchedule.Visible := False;
      pnlMailSetting.Visible := False;
      pnlModuleSetting.Visible := False;
      pnlRSetting.Visible := true;
    end;

  end;

end;

end.

