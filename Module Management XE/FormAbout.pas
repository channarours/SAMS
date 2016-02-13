unit FormAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,MyObject,
  Vcl.ExtCtrls,Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, System.ImageList,
  Vcl.ImgList;

type
  TfrmAbout = class(TForm)
    redt1: TRichEdit;
    T1: TLabel;
    T2: TLabel;
    redt2: TRichEdit;
    T3: TLabel;
    T4: TLabel;
    T5: TLabel;
    T6: TLabel;
    T7: TLabel;
    T8: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
var
jp: TJPEGImage;
begin
  frmAbout.Caption:='SAMS '+ myUtilitise.FileVersion(Application.ExeName);
  redt1.PlainText := False;
  redt1.Lines.LoadFromFile(FileAbout);
  redt1.ScrollBars := ssVertical;
  redt2.PlainText := False;
  redt2.Lines.LoadFromFile(FileFeatue);
  redt2.ScrollBars := ssVertical;
end;

end.
