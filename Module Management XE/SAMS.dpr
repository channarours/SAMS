program SAMS;

uses
  Vcl.Forms,
  FormMain in 'FormMain.pas' {MainForm},
  FormParam in 'FormParam.pas' {Param},
  Vcl.Themes,
  Vcl.Styles,
  //MySeed in 'MySeed.pas',
  FormSetting in 'FormSetting.pas' {Setting};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Semi-Automatic Module Scraping Monitoring System';
  TStyleManager.TrySetStyle('Turquoise Gray');
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TParam, Param);
  Application.CreateForm(TSetting, Setting);
  Application.Run;

end.
