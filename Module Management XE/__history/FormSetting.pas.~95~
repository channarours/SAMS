unit FormSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.CheckLst, System.Actions, Vcl.ActnList, Vcl.WinXCtrls,uUtilitise
  ,uTaskSchedule,MyMail,MySetting,Vcl.FileCtrl,uMethod;

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
    lvErrorKeys: TListView;
    pnlErrorKeyTButtom: TPanel;
    srchErrorKey: TSearchBox;
    lblSearchkey: TLabel;
    btnView: TButton;
    btnDelete: TButton;
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
    btnMailSave: TButton;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  SSetting: TFSetting;
  myUtilitise:TUtilitise;
  mySchedule : TSchedule;
  myUser:TUser;
  myJsoun:TJsonUtility;

  AppPath : String;
  AppFullPath : string;

  rgOption:String;
  dtpDatePick:String;
  dtpTimePick:String;
  dayPick : String;
  QueryTask:String;
implementation

{$R *.dfm}
const
  TaskTitle = 'SAMS'; // Task Title, use to apply task schedule setting

procedure TFSetting.btnCancleClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFSetting.btnModuleDirsClick(Sender: TObject);
var
  SELDIRHELP :Integer;
  Dir :string;
  FileList:TStringList;
  name:String;
  i : integer;
begin
  Dir := GetCurrentDir;
  SELDIRHELP := 1000;
  if Vcl.FileCtrl.SelectDirectory(Dir,[sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
  begin
    edtModuleDirs.Text := Dir;
    FileList := TStringList.Create;
    // insert file information to lvModulelist
    FileList := myUtilitise.FindFile(Dir,edtModuleExtension.Text);
    for i := 0 to FileList.Count - 1 do
      begin
        with lvmoduleSetting.Items.Add do
          begin
            name    := StrGrab(FileList.Strings[i],'','.');
            Caption := IntToStr(i+1);
            SubItems.Add(name);
            SubItems.Add(myUtilitise.FileVersion(Dir+'\'+FileList.Strings[i]));
          end;
      end;

  end;

end;

procedure TFSetting.btnOkClick(Sender: TObject);
var
buttonSelected :Integer;
str:String;
begin
  case cbbtaskType.ItemIndex of
    0 : begin // on schedule
      case rgChoose.ItemIndex of
        0 : begin // One Time
          QueryTask:='/Create /SC '+rgOption+' /TN "'+TaskTitle+'" /TR "'+AppFullPath+'" /ST '+dtpTimePick+' /f';
        end;
        1 : begin // on Daily
          QueryTask:='/Create /SC '+rgOption+' /TN "'+TaskTitle+'" /TR "'+AppFullPath+'" /ST '+dtpTimePick+' /f';
        end;
        2 : begin // on Weekly
          QueryTask:='/Create /SC '+rgOption+' /D '+dayPick+' /TN "'+TaskTitle+'" /TR "'+AppFullPath+'" /ST '+dtpTimePick+' /f';
        end;
      end;
    end;
    1 : begin // on logon
      QueryTask:='/Create /SC '+cbbtaskType.Items[cbbtaskType.ItemIndex]+' /TN "'+TaskTitle+'" /TR "'+AppFullPath+'" /f';
    end;
    2 : begin // on start
      myUtilitise.SetAutoStart_REG(AppFullPath,TaskTitle,true);
    end;
  end;
  if cbbtaskType.ItemIndex <> 2 then
  begin
    buttonSelected := messagedlg('Task Updated : '+cbbtaskType.Items[cbbtaskType.ItemIndex],mtWarning, mbOKCancel, 0);
    if buttonSelected = mrOK then
    begin
      myUser:=TUser.Create;
      with myUser.getSetting.getEmailSetting do
      begin
        addAccount('Home','Home');
      end;

      with myUser.getSetting.getScheduleSetting do
      begin
        addTask(1,'Pisal',TTaskType.onSchedule,TScheduleType.oneTime,dtpDatePick,dtpTimePick,AppFullPath);

      end;
      myJsoun:=TJsonUtility.create;
      str:=myJsoun.toJson(myUser);
      myUtilitise.CreateFile('test.txt',str);
      mySchedule.AddTask(QueryTask);
    end;
  end;
end;

procedure TFSetting.btnRemoveClick(Sender: TObject);
var
  buttonSelected :Integer;
begin

  buttonSelected := messagedlg('Task Remove',mtWarning, mbOKCancel, 0);
      if buttonSelected = mrOK then
        begin
          mySchedule.RemoveTask(TaskTitle);
          myUtilitise.RemoveEntryFromRegistry(TaskTitle);
        end;
end;

procedure TFSetting.cbbtaskTypeChange(Sender: TObject);
var
  itemTitle:String;
  itemIndex:Byte;
begin
  itemTitle:= cbbtaskType.Items[cbbtaskType.ItemIndex];
  itemIndex:= cbbtaskType.ItemIndex;
  if itemIndex = 0 then
  begin
  {***Enable Tool Automatic Schedule block***}
  chklstDays.Enabled:=False;
  rgChoose.Enabled:=True;
  dtpSStartDate.Enabled:=False;
  dtpSTime.Enabled:=False;
  {---Enable Tool Automatic Schedule block---}
  end;

end;

procedure TFSetting.chklstDaysClick(Sender: TObject);
begin
  dayPick:=myUtilitise.GetValueCheckListBox(chklstDays);
end;

procedure TFSetting.dtpSStartDateChange(Sender: TObject);
begin
  dtpDatePick:=DateToStr(dtpSStartDate.Date);
end;

procedure TFSetting.dtpSTimeChange(Sender: TObject);
begin
  dtpTimePick:=TimeToStr(dtpSTime.time);
end;

procedure TFSetting.FormCreate(Sender: TObject);
var
  lvX: Integer;
begin
  lvX := lvErrorKeys.Width;
  lvErrorKeys.Columns[0].Width := Round((lvX * 10) / 100);
  lvErrorKeys.Columns[1].Width := Round((lvX * 30) / 100);
  lvErrorKeys.Columns[2].Width := Round((lvX * 59) / 100);
  lvErrorKeys.Refresh;
  pnlRSetting.Visible := true;
  pnlErrorSetting.Visible := False;
  pnlASchedule.Visible := False;
  pnlMailSetting.Visible := False;
  pnlModuleSetting.Visible := False;

  AppPath:=ExtractFilePath(Application.ExeName);
  AppFullPath:=Application.ExeName;
end;

procedure TFSetting.rgChooseClick(Sender: TObject);
var index:Byte;
begin
      index:=rgChoose.ItemIndex;
  if  index= 2 then // weekly option
  begin
      rgOption:='WEEKLY';
      chklstDays.Enabled:=True;
      dtpSStartDate.Enabled:=False;
      dtpSTime.Enabled:=True;
  end
  else
  if index= 1 then // Daily Option
  begin
      rgOption:='DAILY';
      chklstDays.Enabled:=False;
      dtpSStartDate.Enabled:=False;
      dtpSTime.Enabled:=True;
  end
  else if index = 0 then
  begin
      rgOption:='ONCE';
      chklstDays.Enabled:=False;
      dtpSStartDate.Enabled:=True;
      dtpSTime.Enabled:=True;
  end;
end;



procedure TFSetting.tvGeneralClick(Sender: TObject);
var
  selectText: String;
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
    else if SameText(selectText,'Module Setting') then
      begin
        pnlModuleSetting.Visible := True;
        pnlErrorSetting.Visible := false;
        pnlMailSetting.Visible := False;
        pnlASchedule.Visible := False;
      end
    else if SameText(selectText,'Mail Setting') then
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
  selectText: String;
begin
  if tvTaskManager.Selected <> nil then
  begin
    selectText := tvTaskManager.Selected.Text;

    if SameText(selectText, 'Automatic Schedule') then
    begin
      pnlASchedule.Visible := true;
      pnlErrorSetting.Visible := False;
      pnlMailSetting.Visible := False;
      pnlModuleSetting.Visible:=False;

      {***Disable Tool Automatic Schedule block***}
      chklstDays.Enabled:=False;
      rgChoose.Enabled:=False;
      dtpSStartDate.Enabled:=False;
      dtpSTime.Enabled:=False;
      {---Disable Tool Automatic Schedule block---}

    end
    else
    begin
      pnlErrorSetting.Visible := False;
      pnlASchedule.Visible := False;
      pnlMailSetting.Visible := False;
      pnlModuleSetting.Visible:=False;
      pnlRSetting.Visible := true;
    end;

  end;

end;

end.

