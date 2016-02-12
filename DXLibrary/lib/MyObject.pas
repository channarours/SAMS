unit MyObject;

interface
uses
  MySetting,MyMail,uUtilitise,System.SysUtils;

const
  fileCore = '../data/core.txt';
  fileLog = '../data/log/';
var
  sUserTemp:TUser;
  myemail: IMail;
  myUtilitise: TUtilitise;
  myJsoun: TJsonUtility;
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
  try
    begin
       sUserTemp := myJsoun.fromJson(myUtilitise.ReadFile(fileCore));
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
