unit FormSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.CheckLst, System.Actions, Vcl.ActnList, Vcl.WinXCtrls;

type
  TSetting = class(TForm)
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
    lblMailTo: TLabel;
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
    procedure FormCreate(Sender: TObject);
    procedure tvTaskManagerClick(Sender: TObject);
    procedure tvGeneralClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Setting: TSetting;

implementation

{$R *.dfm}

procedure TSetting.FormCreate(Sender: TObject);
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
end;

procedure TSetting.tvGeneralClick(Sender: TObject);
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

procedure TSetting.tvTaskManagerClick(Sender: TObject);
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
