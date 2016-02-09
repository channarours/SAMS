unit uTaskSchedule;

interface
uses shellAPI,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, CommCtrl,uUtilitise,uMethod;
Type
  TSchedule = Class
    public
      function AddTask(Query:WideString):Boolean;
      function RemoveTask(TaskTitle:WideString):Boolean;
      function ModifyTask(Query:WideString):Boolean;
      function TaskExist(TaskTitle:WideString):Boolean;
      function AutoStartup(Exafile:String;ExaName:String;Auto:Boolean):Boolean;
      function RemoveStartup(ExaName:String):Boolean;
  End;
implementation

{ TSchedule}
var
  TaskCompleted:byte;
  uUlitity:TUtilitise;
  err:String;
function TSchedule.AddTask(Query: WideString): Boolean;
begin
   TaskCompleted:=ShellExecute(0,'runas','SchTasks',StringToOleStr(Query),nil,SW_HIDE);
   if TaskCompleted > 32 then
   Result:=True
   else
   begin
     Result:=False;
   end;
end;

function TSchedule.AutoStartup(Exafile, ExaName: String;
  Auto: Boolean): Boolean;
begin
  uUlitity.SetAutoStart_REG(Exafile,ExaName,Auto);
end;

function TSchedule.ModifyTask(Query:WideString): Boolean;
begin
      TaskCompleted:=ShellExecute(0,'runas','SchTasks',StringToOleStr(Query),nil,SW_HIDE);
   if TaskCompleted > 32 then
   Result:=True;
end;

function TSchedule.RemoveStartup(ExaName: String): Boolean;
begin
  uUlitity.RemoveEntryFromRegistry(ExaName);
end;

function TSchedule.RemoveTask(TaskTitle: WideString): Boolean;
begin
  TaskCompleted:= ShellExecute(0,'runas','SchTasks',StringToOleStr(' /Delete /TN "'+TaskTitle+'" /f'),nil,SW_HIDE);
  if TaskCompleted > 32 then
   result:=true
   else   Result:=false;
end;

function TSchedule.TaskExist(TaskTitle: WideString): Boolean;
begin
     TaskCompleted:=ShellExecute(0,'runas','SchTasks',StringToOleStr('/Query /TN "'+TaskTitle+'" /f'),nil,SW_HIDE);
   if TaskCompleted > 32 then
   result:=true
   else   Result:=false;
end;

end.
