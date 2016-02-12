unit FormModuleInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,myObject,FormParam;

type
  TfrmModuleInfo = class(TForm)
    lblName: TLabel;
    edtName: TEdit;
    edtType: TEdit;
    lblType: TLabel;
    lblService: TLabel;
    edtService: TEdit;
    edtCode: TEdit;
    lblCode: TLabel;
    edtParam: TEdit;
    lblParam: TLabel;
    btnSave: TButton;
    btnCancel: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtParamClick(Sender: TObject);
  private
    moduleCode: string;
    command: string;
    inUpdate: integer;
        { Private declarations }
  public
    procedure getCommand(const Code: string; const action: string);
    { Public declarations }
  end;

var
  frmModuleInfo: TfrmModuleInfo;

implementation

{$R *.dfm}

procedure TfrmModuleInfo.btnSaveClick(Sender: TObject);
var
  i:Integer;
begin
  if SameText(btnSave.Caption,'Update') then
  begin
    with sUserTemp.getModuleList.getModuleInfo.Items[inUpdate] do
    begin
      Setname(edtName.Text);
      Settypes(edtType.Text);
      Setservice(edtService.Text);
      Setcode(edtCode.Text);
      Setparam(edtParam.Text);
    end;
  end
  else if SameText(btnSave.Caption,'Save') then
  begin
      i := sUserTemp.getModuleList.getModuleInfo.Count;
      sUserTemp.getModuleList.addModuleInfo(i+1,Trim(edtName.Text),Trim(edtType.Text),Trim(edtService.Text),Trim(edtCode.Text),Trim(edtParam.Text));
  end;
  updateData;
  Self.Close;
end;


procedure TfrmModuleInfo.edtParamClick(Sender: TObject);
begin
  edtParam.Text := Param.GetParam(edtParam.Text);
end;

procedure TfrmModuleInfo.FormShow(Sender: TObject);
var
  i:Integer;
begin
  // Update Module block
  edtCode.Enabled := False;
  if SameText(command, 'update') then
  begin
    btnSave.Caption := 'Update';
    with sUserTemp.getModuleList.getModuleInfo do
    begin
      for i := 0 to Count - 1 do
      begin
        if SameText(moduleCode, Items[i].Getcode) then
        begin
          edtName.Text := Items[i].Getname;
          edtType.Text := Items[i].Gettypes;
          edtService.Text := Items[i].Getservice;
          edtCode.Text := moduleCode;
          edtParam.Text := Items[i].Getparam;
          inUpdate := i;
        end;
      end;
    end;
  end
  else
 if SameText(command, 'add') then
  begin
    btnSave.Caption := 'Save';
    edtName.Clear;
    edtType.Clear;
    edtService.Clear;
    edtCode.Text := moduleCode;
    edtParam.Clear;
  end;
end;
procedure TfrmModuleInfo.getCommand(const Code, action: String);
begin
  moduleCode := Code;
  command    := action;
end;

end.
