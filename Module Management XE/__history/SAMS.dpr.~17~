program SAMS;

uses
  Vcl.Forms,
  FormMain in 'FormMain.pas' {MainForm},
  FormParam in 'FormParam.pas' {Param},
  Vcl.Themes,
  Vcl.Styles,
  FormSetting in 'FormSetting.pas' {SSetting},
  FormModuleInfo in 'FormModuleInfo.pas' {frmModuleInfo},
  MyObject,MySetting,MyMail,uUtilitise;

{$R *.res}

begin
  Application.Initialize;
  // Transfer file to Object
  sUserTemp := TUser.Create;
  myemail:=TCustom.create;;
  myUtilitise:= TUtilitise.Create;
  myJsoun:= TJsonUtility.create;
  getData;
  //-----------------------------------------------------
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Semi-Automatic Module Scraping Monitoring System';
  TStyleManager.TrySetStyle('Turquoise Gray');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TParam, Param);
  Application.CreateForm(TFSetting, SSetting);
  Application.CreateForm(TfrmModuleInfo, frmModuleInfo);
  Application.Run;

end.
