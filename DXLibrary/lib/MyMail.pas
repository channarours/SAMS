{*******************************************************}
{    SMTP Client                                        }
{    Copyright (C) 2016 3rd Scraping Group (HRD Center) }
{    Member :                                           }
{             Mr. Sun VicheyChetra                      }
{             Mr. Ke Pisal                              }
{             Mr. Rours Channa                          }
{             Miss. Meng Liling                         }
{*******************************************************}

unit MyMail;

interface
  uses
  IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdMessage,IdEMailAddress,IdAttachment,
  IdAttachmentFile;
  type
    IMail = interface ['{ABEE4250-F5FB-4C07-B107-90A12CC1D2E7}']
      // ------------------------------------------------------//
      procedure connect(username:String;password:string);
      function isAuthentication():Boolean;
      procedure setServer(host:string);
      procedure setPort(port:Word);
      procedure setTLS(true:Boolean);
      procedure disconnect();

      // ------------------------------------------------------//
      procedure setFrom(name:string;email:String);
      procedure setReception(name:string;email:String);
      procedure send(subject:string;body:String);overload;
      procedure send(subject:string;body:string;fileURL:string);overload;
    end;
    // Mail Server Block
    TGmail = class(TInterfacedObject,IMail)

      private
        server:TIdSMTP;
        IOSSLHandler:TIdSSLIOHandlerSocketOpenSSL;
        msg:TIdMessage;
        Address:TIdEMailAddressItem;
        Attachment:TIdAttachment;
      public
        constructor create();
        procedure connect(username:String;password:string);
        function isAuthentication():Boolean;
        procedure setServer(host:string);
        procedure setPort(port:Word);
        procedure setTLS(true:Boolean);
        procedure disconnect();
        procedure setFrom(name:string;email:String);
        procedure setReception(name:string;email:String);
        procedure send(subject:string;body:String);overload;
        procedure send(subject:string;body:string;fileURL:string);overload;
    end;
    TYahoo = class (TInterfacedObject,IMail)
      private
        server:TIdSMTP;
        IOSSLHandler:TIdSSLIOHandlerSocketOpenSSL;
        msg:TIdMessage;
        Address:TIdEMailAddressItem;
        Attachment:TIdAttachment;
      public
        constructor create();
        procedure connect(username:String;password:string);
        function isAuthentication():Boolean;
        procedure setServer(host:string);
        procedure setPort(port:Word);
        procedure setTLS(true:Boolean);
        procedure disconnect();
        procedure setFrom(name:string;email:String);
        procedure setReception(name:string;email:String);
        procedure send(subject:string;body:String);overload;
        procedure send(subject:string;body:string;fileURL:string);overload;
    end;
    THotMail = class(TInterfacedObject,IMail)
    private
        server:TIdSMTP;
        IOSSLHandler:TIdSSLIOHandlerSocketOpenSSL;
        msg:TIdMessage;
        Address:TIdEMailAddressItem;
        Attachment:TIdAttachment;
      public
        constructor create();
        procedure connect(username:String;password:string);
        function isAuthentication():Boolean;
        procedure setServer(host:string);
        procedure setPort(port:Word);
        procedure setTLS(true:Boolean);
        procedure disconnect();
        procedure setFrom(name:string;email:String);
        procedure setReception(name:string;email:String);
        procedure send(subject:string;body:String);overload;
        procedure send(subject:string;body:string;fileURL:string);overload;
    end;
    TCustom = class (TInterfacedObject,IMail)
      private
        server:TIdSMTP;
        IOSSLHandler:TIdSSLIOHandlerSocketOpenSSL;
        msg:TIdMessage;
        Address:TIdEMailAddressItem;
        Attachment:TIdAttachment;
      public
        constructor create();
        procedure connect(username:String;password:string);
        function isAuthentication():Boolean;
        procedure setServer(host:string);
        procedure setPort(port:Word);
        procedure setTLS(true:Boolean);
        procedure disconnect();
        procedure setFrom(name:string;email:String);
        procedure setReception(name:string;email:String);
        procedure send(subject:string;body:String);overload;
        procedure send(subject:string;body:string;fileURL:string);overload;
    end;
implementation
uses
  Vcl.Dialogs,System.SysUtils;

  { TGmail }

procedure TGmail.connect(username, password: string);
begin
  server.Username := username;
  server.Password := password;
  try
     server.Connect;
     server.ConnectTimeout := 2000;
  except
    on E : Exception do
      ShowMessage(E.Message);
    end;

end;

constructor TGmail.create;
begin
  server := TIdSMTP.Create(nil);
  IOSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  server.IOHandler := IOSSLHandler;
  server.AuthType := satDefault;
  msg := TIdMessage.Create(nil);
end;

procedure TGmail.disconnect;
begin
  server.Disconnect(true);
end;

function TGmail.isAuthentication: Boolean;
begin
  try
  if server.Authenticate then
    begin
      ShowMessage('Server has connected !');
      Result := True;
      Exit;
    end
  except
    on E:Exception do
    begin
      ShowMessage('Username and password are not accepted.');
      ShowMessage(e.Message);
    end;
  end;
  Result := false;
end;


procedure TGmail.send(subject, body: String);
begin
  msg.Subject := subject;
  msg.Body.Add(body);
  server.Send(msg);
end;

procedure TGmail.send(subject, body, fileURL: string);
begin
  msg.Subject := subject;
  msg.Body.Add(body);
  Attachment := TIdAttachmentFile.Create(msg.MessageParts,fileURL);
  server.Send(msg);
end;

procedure TGmail.setFrom(name, email: String);
begin
   msg.From.Text := email;
   msg.From.Name := name;
end;

procedure TGmail.setPort(port: Word);
begin
    server.Port := port;
end;

procedure TGmail.setReception(name, email: String);
begin
    Address := msg.Recipients.Add;
    Address.Address := email;
    Address.Name := name;
end;

procedure TGmail.setServer(host: string);
begin
  server.Host := host;
end;


procedure TGmail.setTLS(true: Boolean);
begin
    if true then
      server.UseTLS := utUseRequireTLS
    else
      server.UseTLS := utNoTLSSupport;
end;

{ TYahoo }

procedure TYahoo.connect(username, password: string);
begin
  server.Username := username;
  server.Password := password;
  try
     server.Connect;
     server.ConnectTimeout := 2000;
  except
    on E : Exception do
      ShowMessage(E.Message);
    end;
end;

constructor TYahoo.create;
begin
  server := TIdSMTP.Create(nil);
  IOSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  server.IOHandler := IOSSLHandler;
  server.AuthType := satDefault;
  msg := TIdMessage.Create(nil);
end;

procedure TYahoo.disconnect;
begin
   server.Disconnect(true);
end;

function TYahoo.isAuthentication: Boolean;
begin
try
  if server.Authenticate then
    begin
      ShowMessage('Server has connected !');
      Result := True;
      Exit;
    end
  except
    on E:Exception do
    begin
      ShowMessage('Username and password are not accepted.');
    end;
  end;
  Result := false;
end;

procedure TYahoo.send(subject, body: String);
begin
  msg.Subject := subject;
  msg.Body.Add(body);
  server.Send(msg);
end;

procedure TYahoo.send(subject, body, fileURL: string);
begin

  msg.Subject := subject;
  msg.Body.Add(body);
  Attachment := TIdAttachmentFile.Create(msg.MessageParts,fileURL);
  server.Send(msg);
end;

procedure TYahoo.setFrom(name, email: String);
begin
  msg.From.Text := email;
  msg.From.Name := name;
end;

procedure TYahoo.setPort(port: Word);
begin
   server.Port := port;
end;

procedure TYahoo.setReception(name, email: String);
begin
    Address := msg.Recipients.Add;
    Address.Address := email;
    Address.Name := name;
end;

procedure TYahoo.setServer(host: string);
begin
  server.Host := host;
end;

procedure TYahoo.setTLS(true: Boolean);
begin
  if true then
      server.UseTLS := utUseRequireTLS
    else
      server.UseTLS := utNoTLSSupport;
end;

{ TCustom }

procedure TCustom.connect(username, password: string);
begin
  server.Username := username;
  server.Password := password;
  try
     server.Connect;
     server.ConnectTimeout := 2000;
  except
    on E : Exception do
      ShowMessage(E.Message);
    end;

end;

constructor TCustom.create;
begin
  server := TIdSMTP.Create(nil);
  IOSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  server.IOHandler := IOSSLHandler;
  server.AuthType := satDefault;
  msg := TIdMessage.Create(nil);

end;

procedure TCustom.disconnect;
begin
  server.Disconnect(true);
end;

function TCustom.isAuthentication: Boolean;
begin
  try
  if server.Authenticate then
    begin
      ShowMessage('Server has connected !');
      Result := True;
      Exit;
    end
  except
    on E:Exception do
    begin
      ShowMessage('Username and password are not accepted.');
    end;
  end;
  Result := false;
end;

procedure TCustom.send(subject, body: String);
begin
  msg.Subject := subject;
  msg.Body.Add(body);
  server.Send(msg);
end;

procedure TCustom.send(subject, body, fileURL: string);
begin
  msg.Subject := subject;
  msg.Body.Add(body);
  Attachment := TIdAttachmentFile.Create(msg.MessageParts,fileURL);
  server.Send(msg);
end;

procedure TCustom.setFrom(name, email: String);
begin
  msg.From.Text := email;
  msg.From.Name := name;
end;

procedure TCustom.setPort(port: Word);
begin
   server.Port := port;
end;

procedure TCustom.setReception(name, email: String);
begin
    Address := msg.Recipients.Add;
    Address.Address := email;
    Address.Name := name;
end;

procedure TCustom.setServer(host: string);
begin
  server.Host := host;
end;

procedure TCustom.setTLS(true: Boolean);
begin
   if true then
      server.UseTLS := utUseRequireTLS
    else
      server.UseTLS := utNoTLSSupport;
end;

{ THotMail }

procedure THotMail.connect(username, password: string);
begin
  server.Username := username;
  server.Password := password;
  try
     server.Connect;
     server.ConnectTimeout := 2000;
  except
    on E : Exception do
      ShowMessage(E.Message);
    end;
end;

constructor THotMail.create;
begin
  server := TIdSMTP.Create(nil);
  IOSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  server.IOHandler := IOSSLHandler;
  server.AuthType := satDefault;
  msg := TIdMessage.Create(nil);
end;

procedure THotMail.disconnect;
begin
  server.Disconnect(true);
end;

function THotMail.isAuthentication: Boolean;
begin
  try
  if server.Authenticate then
    begin
      ShowMessage('Server has connected !');
      Result := True;
      Exit;
    end
  except
    on E:Exception do
    begin
      ShowMessage('Username and password are not accepted.');
    end;
  end;
  Result := false;
end;

procedure THotMail.send(subject, body: String);
begin
  msg.Subject := subject;
  msg.Body.Add(body);
  server.Send(msg);
end;

procedure THotMail.send(subject, body, fileURL: string);
begin
  msg.Subject := subject;
  msg.Body.Add(body);
  Attachment := TIdAttachmentFile.Create(msg.MessageParts,fileURL);
  server.Send(msg);
end;

procedure THotMail.setFrom(name, email: String);
begin
  msg.From.Text := email;
  msg.From.Name := name;
  server.Send(msg);
end;

procedure THotMail.setPort(port: Word);
begin
   server.Port := port;
end;

procedure THotMail.setReception(name, email: String);
begin
    Address := msg.Recipients.Add;
    Address.Address := email;
    Address.Name := name;
end;

procedure THotMail.setServer(host: string);
begin
    server.Host := host;
end;

procedure THotMail.setTLS(true: Boolean);
begin
   if true then
      server.UseTLS := utUseRequireTLS
    else
      server.UseTLS := utNoTLSSupport;
end;
end.