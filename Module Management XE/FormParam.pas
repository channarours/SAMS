unit FormParam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MySeed, uMethod;

type
  TParam = class(TForm)
    lbl1: TLabel;
    edtParam1: TEdit;
    Param2: TLabel;
    edtParam2: TEdit;
    lbl2: TLabel;
    edtParam3: TEdit;
    lbl3: TLabel;
    edtParam4: TEdit;
    lbl4: TLabel;
    edtParam5: TEdit;
    lbl5: TLabel;
    edtParam6: TEdit;
    lbl6: TLabel;
    edtParam7: TEdit;
    lbl7: TLabel;
    edtParam8: TEdit;
    lbl8: TLabel;
    edtParam9: TEdit;
    lbl9: TLabel;
    edtParam10: TEdit;
    lbl10: TLabel;
    edtParam11: TEdit;
    lbl11: TLabel;
    edtParam12: TEdit;
    lbl12: TLabel;
    edtParam13: TEdit;
    lbl13: TLabel;
    edtParam14: TEdit;
    lbl14: TLabel;
    edtParam15: TEdit;
    lbl15: TLabel;
    edtParam16: TEdit;
    lbl16: TLabel;
    edtParam17: TEdit;
    lbl17: TLabel;
    edtParam18: TEdit;
    lbl18: TLabel;
    edtParam19: TEdit;
    lbl19: TLabel;
    edtParam20: TEdit;
    btnOK: TButton;
    btnCancle: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancleClick(Sender: TObject);
  private
    { Private declarations }
  public
    function GetParam(const mParam: String): String;
  end;

var
  Param: TParam;

implementation

{$R *.dfm}

procedure TParam.btnCancleClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TParam.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

function TParam.GetParam(const mParam: String): String;
var
  aParam: String;
begin
  if mParam <> '' then
  begin
    aParam := seedDcpFromSHA256('mParam', mParam);
    edtParam1.Text := StrGrab(aParam, 'Param1=', 'Param');
    edtParam2.Text := StrGrab(aParam, 'Param2=', 'Param');
    edtParam3.Text := StrGrab(aParam, 'Param3=', 'Param');
    edtParam4.Text := StrGrab(aParam, 'Param4=', 'Param');
    edtParam5.Text := StrGrab(aParam, 'Param5=', 'Param');
    edtParam6.Text := StrGrab(aParam, 'Param6=', 'Param');
    edtParam7.Text := StrGrab(aParam, 'Param7=', 'Param');
    edtParam8.Text := StrGrab(aParam, 'Param8=', 'Param');
    edtParam9.Text := StrGrab(aParam, 'Param9=', 'Param');
    edtParam10.Text := StrGrab(aParam, 'Param10=', 'Param');
    edtParam11.Text := StrGrab(aParam, 'Param11=', 'Param');
    edtParam12.Text := StrGrab(aParam, 'Param12=', 'Param');
    edtParam13.Text := StrGrab(aParam, 'Param13=', 'Param');
    edtParam14.Text := StrGrab(aParam, 'Param14=', 'Param');
    edtParam15.Text := StrGrab(aParam, 'Param15=', 'Param');
    edtParam16.Text := StrGrab(aParam, 'Param16=', 'Param');
    edtParam17.Text := StrGrab(aParam, 'Param17=', 'Param');
    edtParam18.Text := StrGrab(aParam, 'Param18=', 'Param');
    edtParam19.Text := StrGrab(aParam, 'Param19=', 'Param');
    edtParam20.Text := StrGrab(aParam, 'Param20=', 'Param');
  end;
  if Self.ShowModal = mrOk then
  begin
    aParam := 'Param1=' + trim(edtParam1.Text) + 'Param2=' +
      trim(edtParam2.Text) + 'Param3=' + trim(edtParam3.Text) + 'Param4=' +
      trim(edtParam4.Text) + 'Param5=' + trim(edtParam5.Text) + 'Param6=' +
      trim(edtParam6.Text) + 'Param7=' + trim(edtParam7.Text) + 'Param8=' +
      trim(edtParam8.Text) + 'Param9=' + trim(edtParam9.Text) + 'Param10=' +
      trim(edtParam10.Text) + 'Param11=' + trim(edtParam11.Text) + 'Param12=' +
      trim(edtParam12.Text) + 'Param13=' + trim(edtParam13.Text) + 'Param14=' +
      trim(edtParam14.Text) + 'Param15=' + trim(edtParam15.Text) + 'Param16=' +
      trim(edtParam16.Text) + 'Param17=' + trim(edtParam17.Text) + 'Param18=' +
      trim(edtParam18.Text) + 'Param19=' + trim(edtParam19.Text) + 'Param20=' +
      trim(edtParam20.Text) + 'Param';
    Result := SeedEncToSHA256('mParam', aParam);
  end
  else
    Result := mParam;
end;

end.
