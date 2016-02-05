{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
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
