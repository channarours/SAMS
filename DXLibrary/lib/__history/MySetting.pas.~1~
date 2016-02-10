unit MySetting;

interface
uses
  System.Generics.Collections,System.Classes,System.JSON,System.SysUtils,Vcl.Dialogs;
type
  {Email Setting }
  {Server}
  TServer = class
    private
      host:String;
      port:Word;
      secure:Boolean;
      primary:Boolean;
    protected
    public
      function Gethost(): String;
      function Getport(): Word;
      function Getsecure(): Boolean;
      function Getprimary(): Boolean;
      procedure Sethost(const Value: String);
      procedure Setport(const Value: Word);
      procedure Setsecure(const Value: Boolean);
      procedure Setprimary(const Value: Boolean);
    published
  end;
  {Mail Account}
  TMailAccount=class
    private
      username:String;
      password:string;
    protected
    public
      function Getusername(): String;
      function Getpassword(): string;
      procedure Setusername(const Value: String);
      procedure Setpassword(const Value: string);
    published
  end;
  TEmailSetting = class
    private
      Serverlist : TObjectList<TServer>;
      Account : TMailAccount;
    protected
    public
      constructor Create;
      procedure addServer(host:string;port:Word;Secure:Boolean;Primary:Boolean);
      function getServerList:TObjectList<TServer>;
      procedure addAccount(username:string;password:string);
      function getAccount:TMailAccount;

    published
  end;
  {Schedule Setting}
  TTaskType = (onSchedule,onLogOn,onStartUp);
  TScheduleType = (Undefine,oneTime,onDaily,onWeekly);
  TTask = class
    private
      id:Integer;
      name:String;
      ttype:String;
      tschedule:string;
      fileURL:String;
      sDate:String;
      sTime:string;
      Query:string;
      ModuleName:TStringList;
      enable : Boolean;
    protected
    public
      constructor create;
      function GetTaskid():Integer;
      function Getname(): String;
      function Getttype(): String;
      function Gettschedule:string;
      function GetfileURL():String;
      function GetsDate(): String;
      function GetsTime(): string;
      function GetQuery(): string;
      function GetModuleNameList():TStringList;
      function GetEnable:Boolean;
      procedure Setid(const Value:Integer);
      procedure Setname(const Value: String);
      procedure SetfileURL(const Value:String);
      procedure Setttype(const Value: TTaskType;const Value1:TScheduleType);
      procedure Settschedule(const value:string);
      procedure SetsDate(const Value: String);
      procedure SetsTime(const Value: string);
      procedure AddModuleName(const Value:string);
      procedure SetEnable(const Value:Boolean);
    published
  end;
  TScheduleSetting = class
    private
      taskList : TObjectList<TTask>;
    protected
    public
      constructor Create;
      procedure addTask(const id:integer; const name:string; const taskType:TTaskType; const scheduleType:TScheduleType;const date:string = ''; const time:string = '' ;const fileExecute:string = '');
      function getTask:TObjectList<TTask>;
    published
  end;
  { Module Setting }
  TModuleSetting = class
    private
      moduleDir:String;
      extension:String;
      thread:Byte;
    protected
    public
      function GetmoduleDir(): String;
      function Getextension(): String;
      function Getthread(): Byte;
      procedure SetmoduleDir(const Value: String);
      procedure Setextension(const Value: String);
      procedure Setthread(const Value: Byte);
    published
  end;
  { TSetting }
  TSetting= class
    private
      moduleSetting:TModuleSetting;
      emailSetting:TEmailSetting;
      scheduleSetting:TScheduleSetting;
    protected
    public
      constructor create;
      function getModuleSetting:TModuleSetting;
      function getEmailSetting:TEmailSetting;
      function getScheduleSetting:TScheduleSetting;
    published
  end;
  TUserType = (Admin,Normal,Developer);
  TModuleInfo = class
    private
      id  : Integer;
      name:string;
      types:string;
      service:string;
      code:string;
      param:String;
    protected
    public
      function Getid(): Integer;
      function Getname(): string;
      function Gettypes(): string;
      function Getservice(): string;
      function Getcode(): string;
      function Getparam(): String;
      procedure Setid(const Value: Integer);
      procedure Setname(const Value: string);
      procedure Settypes(const Value: string);
      procedure Setservice(const Value: string);
      procedure Setcode(const Value: string);
      procedure Setparam(const Value: String);
    published
  end;
  TModuleList = class
    private
      moduleList : TObjectList<TModuleInfo>;
    protected
    public
      constructor create;
      procedure addModuleInfo(const id:Integer;const name:string;const types:String;const service:String;const code:String;const param:String);
      function getModuleInfo:TObjectList<TModuleInfo>;
    published
  end;
  TUser = class
    private
      uid:Integer;
      name:String;
      pass:string;
      uType:TUserType;
      // administrator and user profile
      setting:TSetting;
      modules:TModuleList;
    protected
      function Getuid():integer;
      function Getname(): String;
      function Getpass(): string;

      procedure Setuid(const Value:Integer);
      procedure Setname(const Value: String);
      procedure Setpass(const Value: string);

    public
      property userid: Integer read uid write uid;
      property UserName: string read name write name;
      property Password: string read pass write pass;
      function GetuType(): TUserType;
      procedure SetuType(const Value: TUserType);
      constructor Create;
      function getSetting:TSetting;
      function getModuleList:TModuleList;
    published
  end;
  TJsonUtility = class
    private
      User : TUser;
    protected
    public
      constructor create;
      function toJson(const User:TUser):String;
      function fromJson(const json:string):TUser;
    published
  end;
  implementation
  { TModuleInfo }
function TModuleInfo.Getid(): Integer;
begin
  Result:=Self.id;
end;
function TModuleInfo.Getname(): string;
begin
  Result:=Self.name;
end;
function TModuleInfo.Gettypes(): string;
begin
  Result:=Self.types;
end;
function TModuleInfo.Getservice(): string;
begin
  Result:=Self.service;
end;
function TModuleInfo.Getcode(): string;
begin
  Result:=Self.code;
end;
function TModuleInfo.Getparam(): String;
begin
  Result:=Self.param;
end;
procedure TModuleInfo.Setid(const Value: Integer);
begin
  Self.id:=Value;
end;
procedure TModuleInfo.Setname(const Value: string);
begin
  Self.name:=Value;
end;
procedure TModuleInfo.Settypes(const Value: string);
begin
  Self.types:=Value;
end;
procedure TModuleInfo.Setservice(const Value: string);
begin
  Self.service:=Value;
end;
procedure TModuleInfo.Setcode(const Value: string);
begin
  Self.code:=Value;
end;
procedure TModuleInfo.Setparam(const Value: String);
begin
  Self.param:=Value;
end;
  { TUser }
function TUser.Getuid():Integer;
begin
  Result := Self.uid;
end;
constructor TUser.Create;
begin
  Self.setting := TSetting.create;
  Self.modules := TModuleList.create;
end;

function TUser.getModuleList: TModuleList;
begin
Result := modules;
end;

function TUser.Getname(): String;
begin
  Result:=Self.name;
end;
function TUser.Getpass(): string;
begin
  Result:=Self.pass;
end;
function TUser.getSetting: TSetting;
begin
Result := Self.setting;
end;

procedure TUser.Setuid(const Value: Integer);
begin
  Self.uid := Value;
end;
procedure TUser.Setname(const Value: String);
begin
  Self.name:=Value;
end;
procedure TUser.Setpass(const Value: string);
begin
  Self.pass:=Value;
end;
function TUser.GetuType(): TUserType;
begin
  Result:=Self.uType;
end;
procedure TUser.SetuType(const Value: TUserType);
begin
  Self.uType:=Value;
  case Value of
    Admin: setting := TSetting.create ;
    Normal: TSetting.create ;
    Developer: ;
  end;
end;

{ TTask }
procedure TTask.AddModuleName(const Value: string);
begin
  ModuleName.Add(value);
end;

constructor TTask.create;
begin
  ModuleName := TStringList.Create;
end;

function TTask.GetEnable: Boolean;
begin
  Result := enable;
end;

function TTask.GetfileURL: String;
begin
  Result := Self.fileURL;
end;

function TTask.GetTaskid: Integer;
begin
  Result := Self.id;
end;

function TTask.GetModuleNameList: TStringList;
begin
  Result := Self.ModuleName;
end;

function TTask.Getname(): String;
begin
  Result:=Self.name;
end;
function TTask.Gettschedule: string;
begin
Result := Self.tschedule;
end;

function TTask.Getttype(): String;
begin
  Result:=Self.ttype;
end;
function TTask.GetsDate(): String;
begin
  Result:=Self.sDate;
end;
function TTask.GetsTime(): string;
begin
  Result:=Self.sTime;
end;
function TTask.GetQuery(): string;
begin

  Result:=Self.Query;
end;
procedure TTask.SetEnable(const Value: Boolean);
begin
  Self.enable := Value;
end;

procedure TTask.SetfileURL(const Value: String);
begin
     Self.fileURL := Value;
end;

procedure TTask.Setid(const Value: Integer);
begin
  Self.id := Value;
end;

procedure TTask.Setname(const Value: String);
begin
  Self.name:=Value;
end;
procedure TTask.Settschedule(const value: string);
begin
   Self.tschedule := value;
end;

procedure TTask.Setttype(const Value: TTaskType;const Value1 : TScheduleType);
begin
  case Value of
    onSchedule:
              begin
                 case Value1 of
                   Undefine: Settschedule('undefine');
                   oneTime:
                          begin
                            Query := '/Create /SC ONCE /TN "'+name+'" /TR "'+fileURL+'" /ST '+stime+' /f';
                            Settschedule('oneTime');
                          end;
                   onDaily:
                          begin
                            Query := '/Create /SC DAILY /TN "'+name+'" /TR "'+fileURL+'" /ST '+stime+' /f';
                            Settschedule('onDaily');
                          end;
                   onWeekly:
                          begin
                            Query := '/Create /SC WEEKLY  /D '+ sDate + '/TN "'+name+'" /TR "'+fileURL+'" /ST '+stime+' /f';
                            Settschedule('onWeekly');
                          end;
                 end;
                 ttype := 'onSchedule';
              end;

    onLogOn:
              begin
                  Query := '/Create /SC ONLOGON /TN "'+name+'" /TR "'+fileURL+'" /ST '+stime+' /f';
                  ttype := 'onLogon';
                  Settschedule('undefine');
              end;
    onStartUp:
              begin
                  Query := '';
                  ttype := 'onStartup';
                  Settschedule('undefine');
              end;

  end;

end;
procedure TTask.SetsDate(const Value: String);
begin
  Self.sDate:=Value;
end;
procedure TTask.SetsTime(const Value: string);
begin
  Self.sTime:=Value;
end;

 { Implmentation Email Setting }

 {Server}
function TServer.Gethost(): String;
begin
  Result:=Self.host;
end;
function TServer.Getport(): Word;
begin
  Result:=Self.port;
end;
function TServer.Getsecure(): Boolean;
begin
  Result:=Self.secure;
end;
function TServer.Getprimary(): Boolean;
begin
  Result:=Self.primary;
end;
procedure TServer.Sethost(const Value: String);
begin
  Self.host:=Value;
end;
procedure TServer.Setport(const Value: Word);
begin
  Self.port:=Value;
end;
procedure TServer.Setsecure(const Value: Boolean);
begin
  Self.secure:=Value;
end;
procedure TServer.Setprimary(const Value: Boolean);
begin
  Self.primary:=Value;
end;

  {Mail Account}
function TMailAccount.Getusername(): String;
begin
  Result:=Self.username;
end;
function TMailAccount.Getpassword(): string;
begin
  Result:=Self.password;
end;
procedure TMailAccount.Setusername(const Value: String);
begin
  Self.username:=Value;
end;
procedure TMailAccount.Setpassword(const Value: string);
begin
  Self.password:=Value;
end;


{ TEmailSetting }

procedure TEmailSetting.addAccount(username, password: string);
begin
  Account.Setusername(username);
  Account.Setpassword(password);
end;

procedure TEmailSetting.addServer(host: string; port: Word; Secure,
  Primary: Boolean);
var
  server : TServer;
begin
  server := TServer.Create;
  server.host := host;
  server.port := port;
  server.secure := Secure;
  server.primary := Primary;

  Self.Serverlist.Add(server);
end;

constructor TEmailSetting.Create;
begin
  serverList := TObjectList<TServer>.Create;
  Account := TMailAccount.Create;
end;

function TEmailSetting.getAccount: TMailAccount;
begin
  Result := Account;
end;

function TEmailSetting.getServerList: TObjectList<TServer>;
begin
  Result := Self.Serverlist;
end;

{ TScheduleSetting }


procedure TScheduleSetting.addTask(const id: integer; const name: string;
  const taskType: TTaskType; const scheduleType: TScheduleType; const date,
  time, fileExecute: string);
var
  taskWork:TTask;
begin
  taskWork := TTask.create;
  taskWork.Setid(id);
  taskWork.Setname(name);
  taskWork.Setttype(taskType,scheduleType);
  taskWork.SetsDate(date);
  taskWork.SetsTime(time);
  taskWork.SetfileURL(fileExecute);
  taskList.Add(taskWork);
end;

constructor TScheduleSetting.Create;
begin
  taskList := TObjectList<TTask>.Create;
end;

function TScheduleSetting.getTask: TObjectList<TTask>;
begin
   Result := Self.taskList;
end;

{ TModuleSetting}
function TModuleSetting.GetmoduleDir(): String;
begin
  Result:=Self.moduleDir;
end;
function TModuleSetting.Getextension(): String;
begin
  Result:=Self.extension;
end;
function TModuleSetting.Getthread(): Byte;
begin
  Result:=Self.thread;
end;
procedure TModuleSetting.SetmoduleDir(const Value: String);
begin
  Self.moduleDir:=Value;
end;
procedure TModuleSetting.Setextension(const Value: String);
begin
  Self.extension:=Value;
end;
procedure TModuleSetting.Setthread(const Value: Byte);
begin
  Self.thread:=Value;
end;
{ TSetting }

constructor TSetting.create;
begin
  moduleSetting := TModuleSetting.Create;
  emailSetting := TEmailSetting.Create;
  scheduleSetting := TScheduleSetting.Create;
end;

function TSetting.getEmailSetting: TEmailSetting;
begin
  Result := Self.emailSetting;
end;

function TSetting.getModuleSetting: TModuleSetting;
begin
  Result := Self.moduleSetting;
end;

function TSetting.getScheduleSetting: TScheduleSetting;
begin
  Result := Self.scheduleSetting;
end;

{ TJsonUtility }

constructor TJsonUtility.create;
begin
  User := TUser.Create;
end;

function TJsonUtility.fromJson(const json: string): TUser;
var
  UserJson:TJSONObject;
  Setting:TJSONObject;
  ModuleSetting:TJSONObject;
  EmailSetting:TJSONObject;
  servers:TJSONArray;
  server:TJSONObject;
  jaccount:TJSONObject;
  ScheduleSetting:TJSONObject;
  tasks : TJSONArray;
  task:TJSONObject;
  moduleList:TJSONArray;
  module:TJSONObject;
  temp,temp1:String;
  i:Integer;
begin
  UserJson := TJSONObject.Create;
  UserJson.Parse(BytesOf(json),0);

    // Check User Type { Get key value from json (obj.Get(key).JsonValue as TJsonString).value

  if SameText(((UserJson.Get('type').JsonValue as TJSONString).Value),'Admin')
     or SameText(((UserJson.Get('type').JsonValue as TJSONString).Value),'Normal')
  then
    begin
       Setting := TJSONObject.Create;
       ModuleSetting := TJSONObject.Create;
       EmailSetting := TJSONObject.Create;
       ScheduleSetting := TJSONObject.Create;
       Setting := TJSONObject(UserJson.Get('Setting').JsonValue);
       ModuleSetting := TJSONObject(Setting.Get('ModuleSetting').JsonValue);
       EmailSetting := TJSONObject(Setting.Get('EmailSetting').JsonValue);
       ScheduleSetting := TJSONObject(Setting.Get('ScheduleSetting').JsonValue);

       // Module Setting to TUser
       with User.getSetting.moduleSetting do
       begin
         SetmoduleDir((ModuleSetting.Get('folder').JsonValue as TJsonString).Value);
         Setextension((ModuleSetting.Get('extension').JsonValue as TJsonString).Value);
         Setthread(StrToInt((ModuleSetting.Get('thread').JsonValue as TJSONString).Value));
       end;

      // Email Setting to TUser
       servers := TJSONArray(EmailSetting.Get('server').JsonValue);
       with User.getSetting.emailSetting do
       begin
        for i := 0 to servers.Count - 1 do
        begin
          server := TJSONObject(servers.Get(i));
          addServer(
                    (server.Get('host').JsonValue as TJSONString).Value,
                    (StrToInt((server.Get('port').JsonValue as TJSONString).Value)),
                    (StrToBool((server.Get('secure').JsonValue as TJSONString).Value)),
                    (StrToBool((server.Get('primary').JsonValue as TJSONString).Value))
                   );
        end;

          jaccount := TJSONObject(EmailSetting.Get('account').JsonValue);
          addAccount(
                    (jaccount.Get('username').JsonValue as TJSONString).Value,
                    (jaccount.Get('password').JsonValue as TJSONString).Value
                     );
       end;
       tasks := TJSONArray(ScheduleSetting.Get('task').JsonValue);
       // Schedule Setting to TUser
        with User.getSetting.scheduleSetting do
        begin
          for i := 0 to tasks.Count - 1 do
            begin
              task := TJSONObject(tasks.Get(i));
              // Check task type
              temp := (task.Get('type').JsonValue as TJSONString).Value;
              // onschedule
              if SameText(temp,'onSchedule') then
              begin
                  temp1 := (task.Get('schedule').JsonValue as TJSONString).Value;
                  // check schedule type
                  if SameText(temp1,'undefine') then
                  begin
                    addTask(
                           (StrToInt((task.Get('id').JsonValue as TJSONString).Value)),
                           (task.Get('name').JsonValue as TJsonString).Value,
                            TTaskType.onSchedule,
                            TScheduleType.Undefine,
                           (task.Get('date').JsonValue as TJsonString).Value,
                           (task.Get('time').JsonValue as TJsonString).Value,
                           (task.Get('execute').JsonValue as TJSONString).Value
                            );
                  end
                  else
                    if SameText(temp1,'oneTime') then
                    begin
                          addTask(
                           (StrToInt((task.Get('id').JsonValue as TJSONString).Value)),
                           (task.Get('name').JsonValue as TJsonString).Value,
                            TTaskType.onSchedule,
                            TScheduleType.oneTime,
                           (task.Get('date').JsonValue as TJsonString).Value,
                           (task.Get('time').JsonValue as TJsonString).Value,
                           (task.Get('execute').JsonValue as TJSONString).Value
                            );
                    end
                    else
                      if SameText(temp1,'onDaily') then
                      begin
                          addTask(
                           (StrToInt((task.Get('id').JsonValue as TJSONString).Value)),
                           (task.Get('name').JsonValue as TJsonString).Value,
                            TTaskType.onSchedule,
                            TScheduleType.onDaily,
                           (task.Get('date').JsonValue as TJsonString).Value,
                           (task.Get('time').JsonValue as TJsonString).Value,
                           (task.Get('execute').JsonValue as TJSONString).Value
                            );
                      end
                      else
                        if SameText(temp1,'onWeekly') then
                        begin
                          addTask(
                           (StrToInt((task.Get('id').JsonValue as TJSONString).Value)),
                           (task.Get('name').JsonValue as TJsonString).Value,
                            TTaskType.onSchedule,
                            TScheduleType.onWeekly,
                           (task.Get('date').JsonValue as TJsonString).Value,
                           (task.Get('time').JsonValue as TJsonString).Value,
                           (task.Get('execute').JsonValue as TJSONString).Value
                            );
                        end;
              end
              else
                // Check task type = onLogon
                if SameText(temp,'onLogon') then
                begin
                  addTask(
                           (StrToInt((task.Get('id').JsonValue as TJSONString).Value)),
                           (task.Get('name').JsonValue as TJsonString).Value,
                            TTaskType.onLogOn,
                            TScheduleType.Undefine,
                           (task.Get('date').JsonValue as TJsonString).Value,
                           (task.Get('time').JsonValue as TJsonString).Value,
                           (task.Get('execute').JsonValue as TJSONString).Value
                            );
                end
                else
                  // Check task type = onStartup
                  if SameText(temp,'onStartup') then
                  begin
                    addTask(
                           (StrToInt((task.Get('id').JsonValue as TJSONString).Value)),
                           (task.Get('name').JsonValue as TJsonString).Value,
                            TTaskType.onStartUp,
                            TScheduleType.Undefine,
                           (task.Get('date').JsonValue as TJsonString).Value,
                           (task.Get('time').JsonValue as TJsonString).Value,
                           (task.Get('execute').JsonValue as TJSONString).Value
                            );
                  end;
            end;
        end;

        moduleList := TJSONArray.Create;
        moduleList := TJSONArray(UserJson.Get('module').JsonValue);
        for i := 0 to moduleList.Count - 1 do
          begin
            module := TJSONObject(moduleList.Get(i));
            with User.getModuleList do
            begin
              addModuleInfo(
                           (StrToInt((module.Get('id').JsonValue as TJsonString).Value)),
                           (module.Get('name').JsonValue as TJSONString).Value,
                           (module.Get('type').JsonValue as TJSONString).Value,
                           (module.Get('service').JsonValue as TJSONString).Value,
                           (module.Get('code').JsonValue as TJSONString).Value,
                           (module.Get('param').JsonValue as TJSONString).Value
                           );
            end;
          end;
    end;
  Result := User;
end;

function TJsonUtility.toJson(const User: TUser):String;
var
  UserJson:TJSONObject;
  ModuleJsonList:TJSONArray;
  Module:TJSONObject;
  SettingJson:TJSONObject;
  ModuleSetting:TJSONObject;
  EmailSetting:TJSONObject;
  ServerList:TJSONArray;
  Server:TJSONObject;
  MailAccount:TJSONObject;
  ScheduleSetting:TJSONObject;
  taskList : TJSONArray;
  task:TJSONObject;
  i:Integer;
begin
  UserJson := TJSONObject.Create;
    UserJson.AddPair(TJSONPair.Create(TJSONString.Create('id'),TJSONString.Create(IntToStr(User.Getuid))));
    UserJson.AddPair(TJSONPair.Create(TJSONString.Create('username'),TJSONString.Create(User.Getname)));
    UserJson.AddPair(TJSONPair.Create(TJSONString.Create('password'),TJSONString.Create(User.Getpass)));
    case User.GetuType of
      Admin: UserJson.AddPair('type','Admin');
      Developer:UserJson.AddPair('type','Developer');
      Normal:UserJson.AddPair('type','Normal');
    end;
    // Admin and Normal Profile Setting
    if (User.GetuType = TUserType.Admin) or (User.GetuType = TUserType.Normal) then
    begin
      SettingJson := TJSONObject.Create;

      { Module Setting }
      ModuleSetting := TJSONObject.Create;
      ModuleSetting.AddPair(TJSONPair.Create(TJSONString.Create('folder'),TJSONString.Create(User.getSetting.moduleSetting.GetmoduleDir)));
      ModuleSetting.AddPair(TJSONPair.Create(TJSONString.Create('extension'),TJSONString.Create(User.getSetting.moduleSetting.Getextension)));
      ModuleSetting.AddPair(TJSONPair.Create(TJSONString.Create('thread'),TJSONString.Create(IntToStr(User.getSetting.moduleSetting.Getthread))));
      SettingJson.AddPair('ModuleSetting',ModuleSetting);
      { Email Setting }
      EmailSetting := TJSONObject.Create;
      ServerList   := TJSONArray.Create;
      for i := 0 to User.getSetting.emailSetting.Serverlist.Count - 1 do
        begin
          Server := TJSONObject.Create;
          Server.AddPair('host',User.getSetting.emailSetting.Serverlist.Items[i].Gethost);
          Server.AddPair('port',IntToStr(User.getSetting.emailSetting.Serverlist.Items[i].Getport));
          Server.AddPair('secure',BoolToStr(User.getSetting.emailSetting.Serverlist.Items[i].Getsecure));
          Server.AddPair('primary',BoolToStr(User.getSetting.emailSetting.Serverlist.Items[i].Getprimary));
          ServerList.Add(server);
        end;

      MailAccount := TJSONObject.Create;
      //MailAccount.AddPair('username',User.getSetting.emailSetting.Account.Getusername);
      MailAccount.AddPair(TJSONPair.Create(TJSONString.Create('username'),TJSONString.Create(User.getSetting.emailSetting.Account.Getusername)));
      //MailAccount.AddPair('password',User.getSetting.emailSetting.Account.Getpassword);
      MailAccount.AddPair(TJSONPair.Create(TJSONString.Create('password'),TJSONString.Create(User.getSetting.emailSetting.Account.Getpassword)));
      EmailSetting.AddPair('server',ServerList);
      EmailSetting.AddPair('account',MailAccount);
      SettingJson.AddPair('EmailSetting',EmailSetting);

      { Schedule Setting };
      ScheduleSetting := TJSONObject.Create;
      taskList        := TJSONArray.Create;
      for i := 0 to User.getSetting.scheduleSetting.taskList.Count - 1 do
        begin
          task        := TJSONObject.Create;
          with User.getSetting.scheduleSetting.taskList.Items[i] do
          begin
            task.AddPair('id',IntToStr(GetTaskid));
            task.AddPair('name',Getname);
            task.AddPair('type',Getttype);
            task.AddPair('schedule',Gettschedule);
            task.AddPair('date',GetsDate);
            task.AddPair('time',GetsTime);
            task.AddPair('module',GetModuleNameList.Text);
            task.AddPair('execute',GetfileURL);
            task.AddPair('enable',BoolToStr(GetEnable));
            taskList.AddElement(task);
          end;
        end;
      ScheduleSetting.AddPair('task',taskList);
      SettingJson.AddPair('ScheduleSetting',ScheduleSetting);
    end;
     UserJson.AddPair('Setting',SettingJson);

     { Module Information }
      ModuleJsonList := TJSONArray.Create;
      for i := 0 to User.getModuleList.getModuleInfo.Count - 1 do
      begin
        Module := TJSONObject.Create;
        with user.getModuleList.getModuleInfo.Items[i] do
        begin
          Module.AddPair('id',IntToStr(Getid));
          Module.AddPair('name',Getname);
          Module.AddPair('type',Gettypes);
          Module.AddPair('service',Getservice);
          Module.AddPair('code',Getcode);
          Module.AddPair('param',Getparam);
          ModuleJsonList.AddElement(Module);
        end;
      end;
      UserJson.AddPair('module',ModuleJsonList);
  Result := UserJson.ToJSON;
end;

{ TModuleList }

procedure TModuleList.addModuleInfo(const id: Integer; const name, types,
  service, code, param: String);
var
  module:TModuleInfo;
begin
  module := TModuleInfo.Create;
  module.Setid(id);
  module.Setname(name);
  module.Settypes(types);
  module.Setservice(service);
  module.Setcode(code);
  module.Setparam(param);

  moduleList.Add(module);

end;

constructor TModuleList.create;
begin
  moduleList := TObjectList<TModuleInfo>.Create;
end;

function TModuleList.getModuleInfo: TObjectList<TModuleInfo>;
begin
  Result := moduleList;
end;

end.
