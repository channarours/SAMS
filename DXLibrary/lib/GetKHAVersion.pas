unit GetKHAVersion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TKHAVersionData = record
    CompanyName, FileDescription, FileVersion, InternalName, LegalCopyright, LegalTrademarks, OriginalFileName, ProductName, ProductVersion, Comments, PrivateBuild, SpecialBuild: string;
  end;

const
  Def_LegalCopyright = 'copyright@ksign';
  Def_CompanyName = 'ksign Co., ltd';

function _GetKHAFileData(const FileName: string): TKHAVersionData;

function _GetFileVersion(const FileName: string): string;

function _CheckKHAFileFormat(const FileName: string): Boolean;
function FileVersion(const FileName: TFileName): string;

implementation

// Pisal
function FileVersion(const FileName: TFileName): String;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
begin
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
          Result := Format('v%d.%d.%d build %d', [
            HiWord(dwFileVersionMS), //Major
            LoWord(dwFileVersionMS), //Minor
            HiWord(dwFileVersionLS), //Release
            LoWord(dwFileVersionLS)]); //Build
  finally
    FreeMem(PVerInfo, VerInfoSize);
  end;
end;

//

function _GetKHAFileData(const FileName: string): TKHAVersionData;
type
  PLandCodepage = ^TLandCodepage;

  TLandCodepage = record
    wLanguage, wCodePage: word;
  end;
var
  dummy, len: cardinal;
  buf, pntr: pointer;
  lang: string;
begin
  len := GetFileVersionInfoSize(PChar(FileName), dummy);
    if len = 0 then
      RaiseLastOSError;
    GetMem(buf, len);
    try
      if not GetFileVersionInfo(PChar(FileName), 0, len, buf) then
        RaiseLastOSError;

      if not VerQueryValue(buf, '\VarFileInfo\Translation\', pntr, len) then
        RaiseLastOSError;

      lang := Format('%.4x%.4x', [PLandCodepage(pntr)^.wLanguage, PLandCodepage(pntr)^.wCodePage]);

      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\CompanyName'), pntr, len){ and (@len <> nil)} then
        result.CompanyName := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\FileDescription'), pntr, len){ and (@len <> nil)} then
        result.FileDescription := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\FileVersion'), pntr, len){ and (@len <> nil)} then
        result.FileVersion := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\InternalName'), pntr, len){ and (@len <> nil)} then
        result.InternalName := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\LegalCopyright'), pntr, len){ and (@len <> nil)} then
        result.LegalCopyright := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\LegalTrademarks'), pntr, len){ and (@len <> nil)} then
        result.LegalTrademarks := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\OriginalFileName'), pntr, len){ and (@len <> nil)} then
        result.OriginalFileName := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\ProductName'), pntr, len){ and (@len <> nil)} then
        result.ProductName := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\ProductVersion'), pntr, len){ and (@len <> nil)} then
        result.ProductVersion := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\Comments'), pntr, len){ and (@len <> nil)} then
        result.Comments := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\PrivateBuild'), pntr, len){ and (@len <> nil)} then
        result.PrivateBuild := PChar(pntr);
      if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\SpecialBuild'), pntr, len){ and (@len <> nil)} then
        result.SpecialBuild := PChar(pntr);
    finally
      FreeMem(buf);
    end;


end;


function _GetFileVersion(const FileName: string): string;
begin
  result := '';
  if not FileExists(FileName) then
    result := 'null'
  else
    //Result := _GetKHAFileData(FileName).FileVersion;
    Result:=FileVersion(FileName);
end;

function _CheckKHAFileFormat(const FileName: string): Boolean;
var
  fInfo: TKHAVersionData;
begin
  fInfo := _GetKHAFileData(FileName);
  if (CompareStr(fInfo.CompanyName, Def_CompanyName) = 0) and (CompareStr(fInfo.LegalCopyright, Def_LegalCopyright) = 0) then
    Result := True
  else
    Result := False;
end;

end.
 
