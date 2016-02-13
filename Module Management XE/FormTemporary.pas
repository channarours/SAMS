unit FormTemporary;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,uMethod,FormParam,MySeed,System.Generics.Collections;
type
  TtempModule = class
    mName:string;
    mKeycode:String;
    mResult:String;
    mStep:string;
  end;
  TtempModuleList = class
    modules:TObjectList<TtempModule>;
    constructor Create;
    procedure addModuleList(const mName:string);
    function  getModuleList:TObjectList<TtempModule>;
  end;
  TfrmTemporary = class(TForm)
    TCode: TLabel;
    TLParam: TLabel;
    edtCode: TEdit;
    edtParam: TEdit;
    lvTMList: TListView;
    mmoTM: TMemo;
    btnStart: TButton;
    btnTMAdd: TButton;
    procedure edtCodeDblClick(Sender: TObject);
    procedure edtParamDblClick(Sender: TObject);
    procedure btnTMAddClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure lvTMListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  modules : TtempModuleList;
  procedure _ExecuteAndWait(const aCommander: string);
    { Public declarations }
  end;
var
  frmTemporary: TfrmTemporary;
implementation
{$R *.dfm}
var
 aparam:TParam;
 tTitle:String;
 tIndex:Integer;
function capResult(esResult:string):String;
var
  i: Integer;
  temp:String;
begin
  temp:='';
  i := 1;
  while (True) do
  begin
    if i < 20 then
    begin
    temp :=temp + StrGrab(esResult, 'Result' + IntToStr(i) + '=', 'Result',i);
    end else break;
    inc(i);
  end;
  result:=temp;
end;

procedure TfrmTemporary.btnStartClick(Sender: TObject);
var
i:integer;
aParam:String;
mExecute:String;
begin
  modules := TtempModuleList.Create;
  if lvTMList.Items.Count > 0 then
  begin
    for i := 0 to lvTMList.Items.Count - 1 do
    begin
        modules.addModuleList(lvTMList.Items.Item[i].SubItems[0]);
        aParam := lvTMList.Items.Item[i].SubItems[3];
        aParam := seedDcpFromSHA256('mParam',aParam);
        mExecute := lvTMList.Items.Item[i].SubItems[2];
        mExecute := mExecute + ' "' + aParam + '"';
        _ExecuteAndWait(mExecute);
        //ShowMessage(mExecute);
    end;
  end;
end;

procedure TfrmTemporary.btnTMAddClick(Sender: TObject);
begin
  Inc(tIndex);
  with lvTMList.Items.add do
  begin
     Caption:=IntToStr(tIndex);
     SubItems.Add(edtCode.Text);
     SubItems.Add('');
     SubItems.Add(tTitle);
     SubItems.Add(edtParam.Text);
  end;
  edtCode.Clear;
  edtParam.Clear;

end;

procedure TfrmTemporary.edtCodeDblClick(Sender: TObject);
var
  openDialog : topendialog;    // Open dialog variable
  name:String;
begin
  // Create the open dialog object - assign to our open dialog variable
  openDialog := TOpenDialog.Create(self);

  // Set up the starting directory to be the current one
  openDialog.InitialDir := GetCurrentDir;

  openDialog.Filter :='Delphi Module|*.kha';

  // Display the open file dialog
  if openDialog.Execute then
  begin
    tTitle:=openDialog.FileName;
    name:=extractfilename(openDialog.FileName);

    edtCode.Text:=StrGrab(name,'','.kha');
  end;

  // Free up the dialog
  openDialog.Free;
end;
procedure TfrmTemporary.edtParamDblClick(Sender: TObject);
begin
  aParam := TParam.Create(nil);
  //aParam.ShowModal;
  edtParam.Text := aParam.GetParam(edtParam.Text);
end;
procedure TfrmTemporary.FormCreate(Sender: TObject);
begin
    tIndex:=0;
end;

procedure TfrmTemporary.lvTMListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  index,i:Integer;
  tName:String;
  tResult:String;
begin
  if lvTMList.Selected<>nil then
  begin
    index:=lvTMList.ItemIndex;
    tName:=lvTMList.Items[index].SubItems[0];
    for i := 0 to modules.getModuleList.Count -1 do
    begin
      with modules.getModuleList.Items[i] do
      begin
        if SameText(tName,mName) then
      begin
        tResult:='Name : '+mName+ #13#10
                +'Progress : '+mStep + #13#10
                +'Status : '+StrGrab(mKeycode,'','[')+'<'+StrGrab(mKeycode,':',']')+'>'+#13#10
                +'Result : '+capResult(mResult);
        mmoTM.Lines.Clear;
        mmoTM.Lines.Add(tResult);
      end;

      end;

    end;
  end;

end;

procedure TfrmTemporary._ExecuteAndWait(const aCommander: string);
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
{ TtempModuleList }

procedure TtempModuleList.addModuleList(const mName: string);
var
  module : TtempModule;
begin
  module := TtempModule.Create;
  module.mName := mName;
  modules.Add(module);
end;

constructor TtempModuleList.Create;
begin
   modules := TObjectList<TtempModule>.Create;
end;

function TtempModuleList.getModuleList: TObjectList<TtempModule>;
begin
  Result := modules;
end;
end.

