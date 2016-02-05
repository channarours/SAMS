unit uYahooMail;

interface
function sendMail(FromAdd:string;AddRecipient:string;Subject:string;Body:string;YahooID:string;Password:string;filename:String):Boolean;
implementation
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,EASendMailObjLib_TLB;

function sendMail(FromAdd:string;AddRecipient:string;Subject:string;Body:string;YahooID:string;Password:string;filename:String):Boolean;
var
  oSmtp : TMail;
begin
  oSmtp := TMail.Create(Application);
  oSmtp.LicenseCode := 'TryIt';

  // Your Yahoo email address              (FromAdd,AddRecipient,Subject,Body,YahooID,Password)
  oSmtp.FromAddr := FromAdd;

  // Add recipient email address
  oSmtp.AddRecipientEx( AddRecipient, 0);

  // Set email subject
  oSmtp.Subject := Subject;

  // Set email body
  oSmtp.BodyText := Body;

  // Set File to Attachment
  // Add attachment from local disk
  
  if Length(filename)<>0 then
  begin
  If oSmtp.AddAttachment(filename) <> 0 Then
    ShowMessage( 'Failed to add attachment with error: ' +
    oSmtp.GetLastErrDescription());
  end;
  // Yahoo SMTP server address
  oSmtp.ServerAddr := 'smtp.mail.yahoo.com';

  // Because yahoo deploys SMTP server on 465 port with direct SSL connection.
  // So we should change the port to 465.
  oSmtp.ServerPort := 465;
    
  // detect SSL/TLS automatically
  oSmtp.SSL_init();

  // For example: your email is "myid@yahoo.com", then the user should be "myid@yahoo.com"
  oSmtp.UserName := YahooID;
  oSmtp.Password := Password;

  //ShowMessage( 'start to send email ...' );

  if oSmtp.SendMail() = 0 then
    Result:=True

  else
    Result:=False;
end;
end.
