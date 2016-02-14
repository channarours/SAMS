unit MyObject;

interface
uses
  MySetting,MyMail,uUtilitise,System.SysUtils,Vcl.Forms,UTblCreate;

{const
  fileCore = '../data/core.txt';
  fileLog = '../data/log/';}
var
  fileCore:String='data\core.txt';
  fileLog:string='data\';
  FileKey:String= 'data\key.txt';
  FileAbout:String='data\about.txt';
  FileFeatue:String='data\feature.txt';
  FileLogo:String='data\logo.jpeg';
  ModuleLog:string;
  sUserTemp:TUser;
  myemail: IMail;
  myUtilitise: TUtilitise;
  myJsoun: TJsonUtility;
   DTable:TDrawTable;
  str:String;
function updateData:Boolean;
function getData:Boolean;


implementation
uses
  Vcl.Dialogs;
function updateData:Boolean;
var
 temp:String;
begin
  try
    begin
       myUtilitise.CreateFile(fileCore,myJsoun.toJson(sUserTemp));
       Result := True;
       Exit;
    end;
  except on E:Exception  do
    begin
          temp := DateToStr(Now);
           myUtilitise.CreateFile('log-' + temp + '.txt',E.Message);
           ShowMessage('Error Occured!' + #13#10 + 'More information See : log-' + temp + '.txt');
    end;

  end;
  Result := False;
end;
function getData:Boolean;
var
 temp:String;
begin
  fileCore:=ExtractFilePath(Application.ExeName)+fileCore;
  fileLog:=ExtractFilePath(Application.ExeName)+fileLog;
  FileKey:=ExtractFilePath(Application.ExeName)+FileKey;
  FileAbout:=ExtractFilePath(Application.ExeName)+FileAbout;
  FileFeatue:=ExtractFilePath(Application.ExeName)+FileFeatue;
  FileLogo:=ExtractFilePath(Application.ExeName)+FileLogo;
  ModuleLog:=ExtractFileDir(Application.ExeName)+'\ModuleLogs_'+formatdatetime('dd-mm-yy[hh_nn_ss]', Now)+'.log';
  DTable:=TDrawTable.create;
  DTable.initTbl();
  DTable.setFilePath(ModuleLog);
  //ShowMessage(ExtractFilePath(Application.ExeName));
  try
    begin
      temp := myUtilitise.ReadFile(fileCore);
       sUserTemp := myJsoun.fromJson(temp);
       Result := True;
       Exit;
    end;
  except on E:Exception  do
    begin
          temp := DateToStr(Now);
           myUtilitise.CreateFile('log-' + temp + '.txt',E.Message);
           ShowMessage('Error Occured!' + #13#10 + 'More information See : log-' + temp + '.txt');
    end;

  end;
  Result := False;
end;


end.
