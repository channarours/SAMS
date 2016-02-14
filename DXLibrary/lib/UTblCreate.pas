unit UTblCreate;

interface

 // Create class with key Type
uses SysUtils;
type
  TStringArray= array of String;
  TDrawTable = class
  private
    {coding private block here}
    {private variable for encapulation}
     strHeader:array[0..10] of string;

     myFile:TextFile;

  public
    {coding public block here}
    {public method or contructor}
    constructor create();
    procedure drawColumn(s : array of string);
    procedure drawTopLine(s:array of string);
    procedure initTbl();
    procedure drawRow(colNo,colDate,colMcode,colMVersion,colMStatus,colMResult:string);
    procedure saveToFile();
    procedure setFilePath(Path:String);

  end;

  var
  i,j:integer;
  tbl:string='';
  str:array of string;
  tfilename:String;
implementation

    {implementation block code from interface block}
procedure TDrawTable.setFilePath(Path:String);
begin
   tfilename:=Path;
end;
    // To draw all columns in a row
constructor TDrawTable.create();
begin
  //
  strHeader[0]:='0';
  //AssignFile(myFile,tfilename);

end;

procedure TDrawTable.drawColumn(s : array of string);
 begin
  // to Draw |             |
  for j:=0 to 5 do
  begin
    tbl:=tbl+'|';//write('|');
    for i:=0 to Length(strHeader[j])+4 do
    begin
      tbl:=tbl+' ';//Write(' ');
    end;

  end;
    tbl:=tbl+'|';//write('|');
    tbl:=tbl+#13#10;//writeln;
  // to Draw |     text|
    tbl:=tbl+'|';//write('|');
  for j:=0 to 5 do
  begin
    //write('|');
    for i:=0 to (Length(strHeader[j])+4)-length(s[j]) do
    begin
      tbl:=tbl+' ';
    end;
    tbl:=tbl+s[j];//:(Length(strHeader[j])+5);//write(s[j]:(Length(strHeader[j])+5));
    tbl:=tbl+'|';//write('|');
  end;
    tbl:=tbl+#13#10;//writeln;
  // to Draw bottom line __________________________
  for j:=0 to 5 do
  begin
    for i:=0 to Length(strHeader[j])+5 do
    begin
      tbl:=tbl+'-';//Write(chr(196));
    end;
  end;
  tbl:=tbl+#13#10;//Writeln;
 end;

 // To draw top line of table _______________________
 procedure TDrawTable.drawTopLine(s:array of string);
 begin
  for j:=0 to 5 do
  begin
    for i:=0 to Length(s[j])+5 do
    begin
      tbl:=tbl+'-';//chr(196);//'-';//Write(chr(196));
    end;
  end;
    tbl:=tbl+#13#10;;//writeln;
 end;

 // init the Header for Table
 procedure TDrawTable.initTbl();
 begin
   strHeader[0]:='No';
   strHeader[1]:='Date                ';
   strHeader[2]:='Module code';
   strHeader[3]:='Module version';
   strHeader[4]:='Module status   ';
   strHeader[5]:='Module result';

   drawTopLine(strHeader);
   drawColumn(strHeader);
 end;

 procedure TDrawTable.saveToFile();
 begin
   
   AssignFile(myFile,tfilename);
   //Reset(myFile);
   {if FileExists(tfilename) then
    Rewrite(myFile)
   else}
    Rewrite(myFile);

   Writeln(myFile,tbl);

   CloseFile(myFile);
 end;

 procedure TDrawTable.drawRow(colNo,colDate,colMcode,colMVersion,colMStatus,colMResult:string);
 begin
  SetLength(str,6);
  str[0]:=colNo;
  str[1]:=colDate;
  str[2]:=colMCode;
  str[3]:=colMVersion;
  str[4]:=colMStatus;
  str[5]:=colMResult;
  drawColumn(str);
 end;

end.
