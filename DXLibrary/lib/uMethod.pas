unit uMethod;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, IniFiles, Math;
function DeleteLineBreaks(const S: string): string;
function uSaveFile(const aFileName, aFileData: String): Boolean;

function ByteType(const S: string; Index: Integer): TMbcsByteType;

function GenKeyForCase(CaseValue: string; const RandomKey: Word = 0): Cardinal;

function IfThenStr(const aCondition: Boolean; const aTrue, aFalse: string): string;
function IfThenInt(const aCondition: Boolean; const aTrue, aFalse: Integer): Integer;
function GetPasswordChar(const aStr: string): string;

function StrFindStr(const aString, aPrefix: string; const aSurfix: string = ''): string;
function StrPaserParam(const aParamStr: string; var aParam: string; const aDelimiter: string = ','): string;

function IsDigit(const aStr: string): Boolean;
function IsCurrency(const aStr: string): Boolean;
function SizeAs(const aStr: string; const aMin: Integer; const aMax: Integer = 0): Boolean;

function ChrLength(const aStr: string): Integer;
function ChrCopy(const aStr: string; const aIndex, aCount: Integer): string;
function MultiCopy(const aStr: string; const aIndex, aCount: Integer): string;

function RightStr(const aStr: string; const aCount: Integer): string;
function StrPos(const aSubStr, aStr: string; const aIndex: Integer = 1; const aCaseSensitive: Boolean = True): Integer;
function StrCrop(const aStr: string; const aIndex, aCount: Integer): string;
function StrReplace(const aStr, aOldStr, aNewStr: string): string;
function StrGrab(const aStr, aPrefix, aSurfix: string; const aIndex: Integer = 1; const aCaseSensitive: Boolean = True): string;
function __StrGrab(const aStr, aPrefix, aSurfix: string; const aIndex: Integer; const aCaseSensitive: Boolean; var aResult: string): Boolean;
function StrTrim(const aStr: string): string;
function RemoveSpace(const aStr: string): String;

function URLEncode(const aStr: string; Ignore: Boolean = True): string;

function _UpperCase(const aString: string): string;
function _LowerCase(const S: string): string;

function _StrGrab(const aStr, aPrefix, aSurfix: string; aIndex: Integer = 1): string;
function _StrGrabCaseIgnore(const aStr: string; aPrefix, aSurfix: string; const aIndex: Integer = 1): string;

function StrMatch(aMask, aTarget: string; aCaseSensitive: Boolean = True): Boolean;
function GetChar(const aLength: Integer; const aChar: Char = ' '): string;

function SingleToLead(AStr: WideString): string;
function Trim(const S: string): string;
function StrPas(const Str: PChar): string;

function XecureEscape(const aStr: string): string;
function EscapeUrl(AStr: string): string;
function EscapeUrlEx(AStr: string): string;
function EscapeUrl_Ex2(AStr: string): string;
function EscapeUrl_Ex3(AStr: string): string;
function EscapeUrl_Ex4(AStr: string): string;
function EscapeUrl_Ex5(AStr: string): string;
function HalfToFull(aStr: String): String;
function LeadToSingle(AStr: string): string;
function EscapeString(AStr: string): string;
//function UnicodeToUri(AStr: string): string;

function FillStringBack(Source: string; Size: Integer; FillChar: Char): string;
function FillStringFront(Source: string; Size: Integer; FillChar: Char): string;
implementation

function DeleteLineBreaks(const S: string): string;
 var
    Source, SourceEnd: PChar;
 begin
    Source := Pointer(S) ;
    SourceEnd := Source + Length(S) ;
    while Source < SourceEnd do
    begin
      case Source^ of
        #10: Source^ := #32;
        #13: Source^ := #32;
      end;
      Inc(Source) ;
    end;
    Result := S;
End;

function uSaveFile(const aFileName, aFileData: String): Boolean;
var
  mInFile: TextFile;
  mFile: String;
begin
  Result := False;
  try
    if not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Logs\') then
      if not CreateDir(ExtractFilePath(ParamStr(0)) + 'Logs\') then ;
    mFile := ExtractFilePath(ParamStr(0)) + 'Logs\' + aFileName;
    //if aUseDateTime then mFile := ChangeFileExt(mFile, '_' + FormatDateTime('YYYYMMDD-hhnnss-zzz', Now)) + ExtractFileExt(mFile);
    AssignFile(mInFile, mFile);
    {$I-}
    if not FileExists(mFile) then Rewrite(mInFile) else Append(mInFile);
    {$I+}
    if IOResult = 0 then begin
      Writeln(mInFile, aFileData);
      CloseFile(mInFile);
    end;
  except
    Exit;
  end;
  Result := True;
end;


function ByteTypeTest(P: PChar; Index: Integer): TMbcsByteType;
var
  I: Integer;
begin
  Result := mbSingleByte;

  if (P = nil) or (P[Index] = #$0) then Exit;
  if (Index = 0) then begin
    if P[0] in LeadBytes then Result := mbLeadByte;
  end else begin
    I := Index - 1;
    while (I >= 0) and (P[I] in LeadBytes) do Dec(I);
    if ((Index - I) mod 2) = 0 then begin
      Result := mbTrailByte;
    end
    else if P[Index] in LeadBytes then begin
      Result := mbLeadByte;
     end;
  end;
end;


function ByteType(const S: string; Index: Integer): TMbcsByteType;
begin
  Result := mbSingleByte;
  if SysLocale.FarEast then begin
    Result := ByteTypeTest(PChar(S), Index-1);
  end;
end;


function GenKeyForCase(CaseValue: string; const RandomKey: Word = 0): Cardinal;
var
 I, Ln: Cardinal;
begin
 Result := 0;

 Ln := Length(CaseValue);
 if Ln < 1 then Exit;
 for I := 1 to Ln
   do Result := Result + ((Ord(CaseValue[I]) xor (Randomkey * I))) shl ((I and 3) shl 3);

 Result := Result + 1;
end;


function IfThenStr(const aCondition: Boolean; const aTrue, aFalse: string): string;
begin
  Result := '';

  if aCondition then Result := aTrue else Result := aFalse;
end;


function IfThenInt(const aCondition: Boolean; const aTrue, aFalse: Integer): Integer;
begin
  if aCondition then Result := aTrue else Result := aFalse;
end;


function GetPasswordChar(const aStr: string): string;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to Length(aStr) do Result := Result + '*';
end;


function __StrToInt(const aStr: string): Integer;
var
  i: Integer;
begin
  Val(aStr, Result, i);
end;


function _BoolToStr(const aValue: Boolean): string;
begin
  if aValue then Result := 'True' else Result := 'False';
end;


function _BoolToInt(const aValue: Boolean): Integer;
begin
  if aValue then Result := 1 else Result := 0;
end;


function RightStr(const aStr: string; const aCount: Integer): string;
begin
  Result := Copy(aStr, Length(aStr) + 1 - aCount, aCount);
end;


function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I, X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then begin
    Result := Pos(SubStr, S);
  end else begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do begin
      if S[I] = SubStr[1] then begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do begin
          Inc(X);
        end;
        if (X = LenSubStr) then begin
          Result := I;
          Exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;


function _StrPos(const aSubStr, aStr: string; const aIndex: Integer): Integer;
var
  i, j: Integer;
  ResultTemp: Boolean;
begin
  j := 1;
  ResultTemp := False;

  for i := 1 to aIndex do begin
    j := j + (Integer(j <> 1) * Length(aSubStr));
    j := StrUtils.PosEx(aSubStr, aStr, j);
    if (not ResultTemp) and (j > 0) then ResultTemp := True;
  end;

  if ResultTemp then Result := j else Result := 0;
end;


function StrPos(const aSubStr, aStr: string; const aIndex: Integer; const aCaseSensitive: Boolean): Integer;
begin
  if aCaseSensitive then
    Result := _StrPos(aSubStr, aStr, aIndex)
  else
    Result := _StrPos(_LowerCase(aSubStr), _LowerCase(aStr), aIndex)
end;


function StrCrop(const aStr: string; const aIndex, aCount: Integer): string;
var
  Temp, TempRes: string;
  Reverse: Boolean;
  Index, Count, Len: Integer;
begin
  Result := '';
  Temp := aStr;

  Index := aIndex - 1;
  Count := aCount;
  Reverse := Count < 0;
  Len := Length(Temp);
  if Reverse then begin
    Index := -Index;
    Count := -Count;
  end;

  TempRes := Copy(Temp, 1 + (Len - Count) * Integer(Reverse) + Index, Count);

  if Length(TempRes) > 0 then Result := TempRes;
end;


function StrReplace(const aStr, aOldStr, aNewStr: string): string;
var
  Temp, TempRes: string;
  aOldStrLength, i: Integer;
begin
  Result := '';
  Temp := aStr;
  aOldStrLength := Length(aOldStr);

  while Temp <> '' do begin
    i := Pos(aOldStr, Temp);
    if i = 0 then Break;
    Result := Result + Copy(Temp, 1, i - 1) + aNewStr;
    Delete(Temp, 1, i + aOldStrLength - 1);
  end;

  if Temp <> '' then Result := Result + Temp;
end;


function __StrGrab(const aStr, aPrefix, aSurfix: string; const aIndex: Integer; const aCaseSensitive: Boolean; var aResult: string): Boolean;
var
  Temp: PChar;
  i, PrefixInt, SurfixInt: Integer;
begin
  Result  := False;
  aResult := '';
  Temp := PChar(aStr);

  if aPrefix <> '' then begin
    for i := 1 to aIndex do begin
      PrefixInt := Pos(aPrefix, Temp);
      if PrefixInt < 1 then Exit;
      Temp := @Temp[PrefixInt + Length(aPrefix) - 1];
    end;
  end;

  if aSurfix <> '' then begin
    SurfixInt := Pos(aSurfix, Temp);
  end else begin
    SurfixInt := Length(Temp) + 1;
  end;
  if SurfixInt < 1 then Exit;
  Result := True;

  SetString(aResult, Temp, SurfixInt - 1);
end;

function _StrGrabCaseIgnore(const aStr: string; aPrefix, aSurfix: string; const aIndex: Integer = 1): string;
var
  LowerCaseStr: string;
  Temp, Temp2: PChar;
  i, PrefixInt, SurfixInt: Integer;
begin
  Result := '';
  LowerCaseStr := _LowerCase(aStr);
  aPrefix := _LowerCase(aPrefix);
  aSurfix := _LowerCase(aSurfix);
  if Length(LowerCaseStr) = 0 then Exit; 
  Temp := PChar(LowerCaseStr);
  Temp2 := PChar(aStr);

  if aPrefix <> '' then begin
    for i := 1 to aIndex do begin
      PrefixInt := Pos(aPrefix, Temp);
      if PrefixInt < 1 then Exit;
      if (Length(aPrefix) + PrefixInt) > Length(Temp) then Exit;
      Temp := @Temp[PrefixInt + Length(aPrefix) - 1];
      Temp2 := @Temp2[PrefixInt + Length(aPrefix) - 1];
    end;
  end;

  if aSurfix <> '' then begin
    SurfixInt := Pos(aSurfix, Temp);
  end else begin
    SurfixInt := Length(Temp) + 1;
  end;
  
  if SurfixInt < 1 then Exit;

  SetString(Result, Temp2, SurfixInt - 1);
end;
{
function _StrGrab(const aStr, aPrefix, aSurfix: string; aIndex: Integer = 1): string;
var
  Temp: PChar;
  i, PrefixInt, SurfixInt: Integer;
begin
  Result := '';
  if aIndex < 1 then Exit;
  if Length(aStr) = 0 then Exit;
  Temp := PChar(aStr);

  if aPrefix <> '' then begin
    for i := 1 to aIndex do begin
      PrefixInt := Pos(aPrefix, Temp);
      if PrefixInt < 1 then Exit;
      if (Length(aPrefix) + PrefixInt) > Length(Temp) then Exit;
      Temp := @Temp[PrefixInt + Length(aPrefix) - 1];
    end;
  end;

  if aSurfix <> '' then begin
    SurfixInt := Pos(aSurfix, Temp);
  end else begin
    SurfixInt := Length(Temp) + 1;
  end;

  if SurfixInt < 1 then Exit;

  SetString(Result, Temp, SurfixInt - 1);
end;
}
function _StrGrab(const aStr, aPrefix, aSurfix: string; aIndex: Integer = 1): string;
var
  Temp: PChar;
  i, PrefixInt, SurfixInt: Integer;
begin
  Result := '';
  if aIndex < 1 then Exit;
  if Length(aStr) = 0 then Exit;
  Temp := PChar(aStr);

  if aPrefix <> '' then begin
    for i := 1 to aIndex do begin
      PrefixInt := Pos(aPrefix, Temp);
      if PrefixInt < 1 then Exit;
      if (Length(aPrefix) + PrefixInt) > Length(Temp) then Exit;
      Temp := @Temp[PrefixInt + Length(aPrefix) - 1];
    end;
  end;

  if aSurfix <> '' then begin
    SurfixInt := Pos(aSurfix, Temp);
  end else begin
    SurfixInt := Length(Temp) + 1;
  end;

  if SurfixInt < 1 then Exit;

  SetString(Result, Temp, SurfixInt - 1);
end;

function StrGrab(const aStr, aPrefix, aSurfix: string; const aIndex: Integer = 1; const aCaseSensitive: Boolean = True): string;
begin
  if aCaseSensitive then
    Result := _StrGrab(aStr, aPrefix, aSurfix, aIndex)
  else
    Result := _StrGrabCaseIgnore(aStr, aPrefix, aSurfix, aIndex);
    // Result := _StrGrab(_LowerCase(aStr), _LowerCase(aPrefix), _LowerCase(aSurfix), aIndex)
end;


function StrTrim(const aStr: string): string;
var
  Temp, TempRes: string;
  i, Len: Integer;
begin
  Result := '';
  Temp := aStr;

  Len := Length(Temp);
  i := 1;
  while (i <= Len) and (Temp[i] <= ' ') do Inc(i);
  if i > Len then begin
    TempRes := ''
  end else begin
    while Temp[Len] <= ' ' do Dec(Len);
    TempRes := Copy(Temp, i, Len - i + 1);
  end;

  if Length(TempRes) > 0 then Result := TempRes;
end;


function StrFindStr(const aString, aPrefix, aSurfix: string): string;
var
  StrLength, PrefixPos, SurfixPos: Integer;
begin
  Result := '';
  
  PrefixPos := Pos(aPrefix, aString) - Integer(aPrefix = '');
  if Boolean(PrefixPos) then begin
    StrLength := Length(aString);
    Result := Copy(aString, PrefixPos + Length(aPrefix), StrLength);
    SurfixPos := Pos(aSurfix, Result) - Integer(aSurfix = '');
    Result := Copy(Result, 1, SurfixPos - 1 + Integer(SurfixPos < 0) * (StrLength + 2));
  end;
end;


function StrPaserParam(const aParamStr: string; var aParam: string; const aDelimiter: string): string;
var
  DelimiterPos: Integer;
begin
  Result := '';

  DelimiterPos := Pos(aDelimiter, aParamStr);
  if Boolean(DelimiterPos) then begin
    aParam := Copy(aParamStr, 1, DelimiterPos - 1);
    Result := Copy(aParamStr, DelimiterPos + 1, Length(aParamStr));
  end else begin
    aParam := aParamStr;
    Result := '';
  end;
end;


function IsDigit(const aStr: string): Boolean;
var
  i: Integer;
begin
  if aStr = '' then begin
    Result := False;
    Exit;
  end;

  for i := 1 to Length(aStr) do
    if not (aStr[i] in ['0'..'9']) then Break;
  Result := i = Length(aStr) + 1;
end;


function IsCurrency(const aStr: string): Boolean;
var
  i: Integer;
  PosMinus, CountPeriod: Integer;
begin
  if aStr = '' then begin
    Result := False;
    Exit;
  end;

  PosMinus := 0;
  CountPeriod := 0;
  for i := 1 to Length(aStr) do begin
    if not (aStr[i] in ['0'..'9', '.', '-']) then Break;
    if aStr[i] = '-' then PosMinus := i;
    if aStr[i] = '.' then Inc(CountPeriod);
  end;
  Result := (i = Length(aStr) + 1) and Boolean(PosMinus < 2) and Boolean(CountPeriod < 2);
end;


function SizeAs(const aStr: string; const aMin: Integer; const aMax: Integer = 0): Boolean;
begin
  Result := (Length(aStr) >= aMin) and ((Length(aStr) <= aMax) or not Boolean(aMax));
end;


function ChrLength(const aStr: string): Integer;
var
  i: Integer;
begin
  i := 1;
  Result := 0;

  while i <= Length(aStr) do begin
    case ByteType(aStr, i) of
      mbSingleByte: Result := Result + 1;
      mbLeadByte  : ;
      mbTrailByte : Result := Result + 1;
    end;
    i := i + 1;
  end;
end;


function ChrCopy(const aStr: string; const aIndex, aCount: Integer): string;
var
  i, CopyLength, StartLoc: Integer;
begin
  i := 1;
  Result := '';
  StartLoc := 0;
  CopyLength := 0;

  if ChrLength(aStr) < aIndex then Exit;

  while i <= Length(aStr) do begin
    case ByteType(aStr, i) of
      mbSingleByte: begin
        StartLoc := StartLoc + 1;
        if aIndex >= StartLoc then begin
          CopyLength := CopyLength + 1;
          Result := Result + aStr[i];
        end;
      end;
      mbLeadByte: begin
        if aIndex >= StartLoc then begin
          Result := Result + aStr[i];
        end;
      end;
      mbTrailByte: begin
        StartLoc := StartLoc + 1;
        if aIndex >= StartLoc then begin
          CopyLength := CopyLength + 1;
          Result := Result + aStr[i];
        end;
      end;
    end;

    if CopyLength = aCount then Break;
    i := i + 1;
  end;
end;


function MultiCopy(const aStr: string; const aIndex, aCount: Integer): string;
var
  i, CopyLength: Integer;
begin
  Result := '';
  CopyLength := 0;

  if Length(aStr) < aIndex then Exit;
  if ByteType(aStr, aIndex) = mbTrailByte then i := aIndex - 1 else i := aIndex;

  while i <= Length(aStr) do begin
    case ByteType(aStr, i) of
      mbSingleByte: begin
        CopyLength := CopyLength + 1;
        if CopyLength > aCount then break;
        Result := Result + aStr[i];
      end;
      mbLeadByte: begin
        CopyLength := CopyLength + 1;
        if CopyLength = aCount then begin
          if i = aCount then break;
          Result := Result + aStr[i] + aStr[i + 1];
          CopyLength := CopyLength + 1;
        end else begin
          Result := Result + aStr[i];
        end;
      end;
      mbTrailByte: begin
        CopyLength := CopyLength + 1;
        Result := Result + aStr[i];
      end;
    end;
    if CopyLength >= aCount then Break;
    i := i + 1;
  end;
end;


function URLEncode(const aStr: string; Ignore: Boolean = True): string;
  function AscToHex(const Value: Char): string;
  var
    HiNibble, LoNibble: Integer;
  begin
    Result := '';
    HiNibble := Cardinal(Value) div 16;
    LoNibble := Cardinal(Value) mod 16;
    if HiNibble > 9 then
      Result := Result  + Chr((Ord('A') + HiNibble - 10))
    else
      Result := Result  + Chr((Ord('0') + HiNibble));

    if LoNibble > 9 then
      Result := Result  + Chr((Ord('A') + LoNibble - 10))
    else
      Result := Result  + Chr((Ord('0') + LoNibble));
  end;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to Length(aStr) do begin
    case aStr[i] of
      // reserved char
      '$', {'&',} '+', ',', '/', ':', ';', {'=',} '?', '@': Result := Result + '%' + AscToHex(aStr[i]);
      // unsafety char
      ' ', '"', '<', '>', '#', '%', '{', '}', '|', '^', '~', '[', ']', '`': Result := Result + '%' + AscToHex(aStr[i]);
      // 기존에 누락되어있던 문자에 대한 처리
      '&', '=', '', '_', '(', ')', '-', '''': if not Ignore then Result := Result + '%' + AscToHex(aStr[i]);
      // non ascii char
//      #255..#128: Result := Result + '%' + AscToHex(aStr[i]);
      else
        Result := Result + aStr[i];
    end;
  end;
end;


function _UpperCase(const aString: string): string;
var
  i: Integer;
begin
  Result := aString;
  for i := 1 to Length(aString) do
    if (aString[i] >= 'a') and (aString[i] <= 'z') then
      Result[i] := Chr(Ord(aString[i]) - 32)
    else
      Result[i] := aString[i];
end;


function _LowerCase(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'A') and (Ch <= 'Z') then Inc(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;


function GetChar(const aLength: Integer; const aChar: Char): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to aLength do Result := Result + aChar;
end;

procedure InitPlatformId;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
    with OSVersionInfo do begin
      Win32Platform := dwPlatformId;
      Win32MajorVersion := dwMajorVersion;
      Win32MinorVersion := dwMinorVersion;
      if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
        Win32BuildNumber := dwBuildNumber and $FFFF
      else
        Win32BuildNumber := dwBuildNumber;
      Win32CSDVersion := szCSDVersion;
    end;
end;

function StrToIntDef(const S: string; Default: Integer): Integer;
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then Result := Default;
end;

function LCIDToCodePage(ALcid: LCID): Integer;
var
  Buffer: array[0..6] of Char;
begin
  GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, SizeOf(Buffer));
  Result := StrToIntDef(Buffer, GetACP);
end;


procedure InitSysLocale;
var
  DefaultLCID: LCID;
  DefaultLangID: LANGID;
  AnsiCPInfo: TCPInfo;
  I: Integer;
  BufferA: array[128..255] of Char;
  BufferW: array[128..256] of Word;
  PCharA: PChar;

  procedure InitLeadBytes;
  var
    I: Integer;
    J: Byte;
  begin
    GetCPInfo(LCIDToCodePage(SysLocale.DefaultLCID), AnsiCPInfo);
    with AnsiCPInfo do begin
      I := 0;
      while (I < MAX_LEADBYTES) and ((LeadByte[I] or LeadByte[I + 1]) <> 0) do begin
        for J := LeadByte[I] to LeadByte[I + 1] do
        {$IF CompilerVersion >= 20}
          Include(LeadBytes, AnsiChar(J));
        {$ELSE}
          Include(LeadBytes, Char(J));
        {$IFEND}
        Inc(I, 2);
      end;
    end;
  end;

  function IsWesternGroup: Boolean;
  type
    TLangGroup = $00..$1D;
    TLangGroups = set of TLangGroup;
  const
    lgNeutral = TLangGroup($00);
    lgDanish = TLangGroup($06);
    lgDutch = TLangGroup($13);
    lgEnglish  = TLangGroup($09);
    lgFinnish = TLangGroup($0B);
    lgFrench = TLangGroup($0C);
    lgGerman = TLangGroup($07);
    lgItalian  = TLangGroup($10);
    lgNorwegian = TLangGroup($14);
    lgPortuguese = TLangGroup($16);
    lgSpanish  = TLangGroup($0A);
    lgSwedish  = TLangGroup($1D);

    WesternGroups: TLangGroups = [
      lgNeutral,
      lgDanish,
      lgDutch,
      lgEnglish,
      lgFinnish,
      lgFrench,
      lgGerman,
      lgItalian,
      lgNorwegian,
      lgPortuguese,
      lgSpanish,
      lgSwedish
    ];
  begin
    Result := SysLocale.PriLangID in WesternGroups;
  end;

begin
  { Set default to English (US). }
  SysLocale.DefaultLCID := $0409;
  SysLocale.PriLangID := LANG_ENGLISH;
  SysLocale.SubLangID := SUBLANG_ENGLISH_US;

  DefaultLCID := GetThreadLocale;
  if DefaultLCID <> 0 then SysLocale.DefaultLCID := DefaultLCID;

  DefaultLangID := Word(DefaultLCID);
  if DefaultLangID <> 0 then begin
    SysLocale.PriLangID := DefaultLangID and $3ff;
    SysLocale.SubLangID := DefaultLangID shr 10;
  end;

  LeadBytes := [];
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
    if IsWesternGroup then begin
      SysLocale.MiddleEast := False;
      SysLocale.FarEast    := False;
    end else begin
      { Far East (aka MBCS)? - }
      InitLeadBytes;
      SysLocale.FarEast := LeadBytes <> [];
      if SysLocale.FarEast then begin
        SysLocale.MiddleEast := False;
        Exit;
      end;

      { Middle East? }
      for I := Low(BufferA) to High(BufferA) do BufferA[I] := Char(I);
      PCharA := @BufferA; { not null terminated: include length in GetStringTypeExA call }
      GetStringTypeEx(SysLocale.DefaultLCID, CT_CTYPE2, PCharA, High(BufferA) - Low(BufferA) + 1, BufferW);
      for I := Low(BufferA) to High(BufferA) do begin
        SysLocale.MiddleEast := BufferW[I] = C2_RIGHTTOLEFT;
        if SysLocale.MiddleEast then Exit;
      end;
    end;
  end else begin
    SysLocale.MiddleEast := GetSystemMetrics(SM_MIDEASTENABLED) <> 0;
    SysLocale.FarEast    := GetSystemMetrics(SM_DBCSENABLED) <> 0;
    if SysLocale.FarEast then InitLeadBytes;
  end;
end;


function StrMatch(aMask, aTarget: string; aCaseSensitive: Boolean): Boolean;
var
  J, nTmp, MaskIndex, TargetIndex, QuestionCount: Integer;
  AfterStar: Boolean;
begin
  Result := False;

  if Length(aMask) = 0 then Exit;
  if Length(aTarget) = 0 then Exit;

  if not aCaseSensitive then begin
    aMask := _LowerCase(aMask);
    aTarget := _LowerCase(aTarget);
  end;
  AfterStar := false;
  TargetIndex := 1;
  MaskIndex := 1;
  QuestionCount := 0;
  while true do begin
    if (MaskIndex > Length(aMask)) then
      Break
    else if (TargetIndex > Length(aTarget)) then begin
      if (aMask[MaskIndex] = '*')  then begin
        Inc(MaskIndex);
        Continue;
      end;
      Exit;
    end;
    case aMask[MaskIndex] of
    '?': Inc(QuestionCount); // '?'
    '*': AfterStar := True;
    else
      //이전 문자가 *  이다. 걍..지금 찾는 문자가 있는지.
      if (QuestionCount  = 0) and (AfterStar) then begin
        AfterStar := False;
        nTmp :=  -1;
        for J:= TargetIndex to  Length(aTarget) -1 do begin
          if (aMask[MaskIndex] = aTarget[J]) then begin
            if (QuestionCount > 0)  then Exit;
            nTmp := J;
          end else if (nTmp <> -1 ) then
            Break;
        end;
        if (nTmp = -1) then Exit;
        TargetIndex  :=  nTmp + 1;
      end else begin
        if (QuestionCount > 0 ) then begin
          Dec(QuestionCount);
          Inc(TargetIndex);
          Continue;
        end else if (aMask[MaskIndex] <>  aTarget[TargetIndex]) then
          Exit
        else
          Inc(TargetIndex);
      end;
    end;
    Inc(MaskIndex);
  end;
  Result := not ((QuestionCount > 0) or (not AfterStar and (TargetIndex < Length(aTarget)))) ;
end;

function EscapeUrl(AStr: string): string;
var
  i: integer;
  ch: char;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    ch := AStr[i];
    case ch of
      ' ': Result := Result + '%20';
      '%': Result := Result + '%25';
      '&': Result := Result + '%26';
      '+': Result := Result + '%2B';
      '=': Result := Result + '%3D';
      '?': Result := Result + '%3F';
    else
      Result := Result + ch;
    end;
  end;
end;

function EscapeUrlEx(AStr: string): string;
var
  i: integer;
  ch: char;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    ch := AStr[i];
    case ch of
      ' ': Result := Result + '%20';
      '%': Result := Result + '%25';
      '&': Result := Result + '%26';
      '+': Result := Result + '%2B';
      '=': Result := Result + '%3D';
      '?': Result := Result + '%3F';
      '/': Result := Result + '%2F';
      ';': Result := Result + '%3B';
    else
      Result := Result + ch;
    end;
  end;
end;

function EscapeString(AStr: string): string;
begin
  Result := '';
  Result := StringReplace(AStr,'&','\&',[rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result,'''','\''',[rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result,'"','\"',[rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result,':','\:',[rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result,'  ','',[rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result,#13,' ',[rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result,#14,' ',[rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result,'amp;','',[rfReplaceAll, rfIgnoreCase]);
end;

{
function EscapeString(AStr: string): string;
var
  i: integer;
  ch: char;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    ch := AStr[i];
    case ch of
      '&': Result := Result + '&amp;';
      ' ': Result := Result + '&nbsp;';
      '"': Result := Result + '&quot;';
      '/': Result := Result + '#13#10';
      ' ': Result := Result + 'http://';
      ' ': Result := Result + 'https://';
    else
      Result := Result + ch;
    end;
  end;
end;
}

function EscapeUrl_Ex2(AStr: string): string;
var
  i: integer;
  ch: char;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    ch := AStr[i];
    case ch of
      ' ': Result := Result + '+';
      #10: Result := Result + '%0D%0A';
      '%': Result := Result + '%25';
      '&': Result := Result + '%26';
      '+': Result := Result + '%2B';
      '=': Result := Result + '%3D';
      '?': Result := Result + '%3F';
      ';': Result := Result + '%38';
      '/': Result := Result + '%2F';
    else
      Result := Result + ch;
    end;
  end;
end;

function EscapeUrl_Ex3(AStr: string): string;
var
  i: integer;
  ch: char;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    ch := AStr[i];
    case ch of
      ' ': Result := Result + '%20';
      '%': Result := Result + '%25';
      '&': Result := Result + '%26';
      '+': Result := Result + '%2B';
      '=': Result := Result + '%3D';
      '?': Result := Result + '%3F';
      '<': Result := Result + '%3C';
      '>': Result := Result + '%3E';
      '/': Result := Result + '%2F';
      '"': Result := Result + '%22';
      ':': Result := Result + '%3A';
    else
      Result := Result + ch;
    end;
  end;
end;

function EscapeUrl_Ex4(AStr: string): string;
var
  i: integer;
  ch: char;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    ch := AStr[i];
    case ch of
      ' ': Result := Result + '%20';
      '&': Result := Result + '%26';
      '=': Result := Result + '%3D';
      '?': Result := Result + '%3F';
      '<': Result := Result + '%3C';
      '>': Result := Result + '%3E';
      '/': Result := Result + '%2F';
      '"': Result := Result + '%22';
      ':': Result := Result + '%3A';
    else
      Result := Result + ch;
    end;
  end;
end;

function EscapeUrl_Ex5(AStr: string): string;
var
  i: integer;
  ch: char;
begin
  Result := '';
  for i := 1 to Length(AStr) do
  begin
    ch := AStr[i];
    case ch of
      ' ': Result := Result + '+';
      #10: Result := Result + '%0D%0A';
      '%': Result := Result + '%25';
      '&': Result := Result + '%26';
      '+': Result := Result + '%2B';
      '=': Result := Result + '%3D';
      '?': Result := Result + '%3F';
      ';': Result := Result + '%38';
    else
      Result := Result + ch;
    end;
  end;
end;






function HalfToFull(aStr: String): String;
var
  i : Integer;
  S2 : String;
  n1, n2 : Integer;
begin
  i := 1;
  S2 := '';
  while i <= Length(aStr) do begin
    if Ord(aStr[i]) > 127 then begin
      S2 := S2 + aStr[i] + aStr[i+1];
      Inc(i);
    end else if Ord(aStr[i]) <= 32 then begin
      S2 := S2 + ' ';
    end else begin
      n1 := $a380 + Ord(aStr[i]);
      S2 := S2 + Char(n1 shr 8) + Char(n1 and $00ff);
    end;

    Inc(i);
  end;
  Result := S2;
end;

//전각문자 -> 반각문자

function LeadToSingle(AStr: string): string;
var
  S: string;
  SS: string;
  SAsc: string;
  Asc1: integer;
  Asc2: integer;
  i: Integer;
begin
  Result := '';
  SS := '';
  SAsc := '';
  Asc1 := 0;
  S := AStr;

  for i := 1 to Length(S) do
  begin
    //반각문자는 변환하지 않는다.
    if ByteType(S, i) = mbSingleByte then
    begin
      Result := Result + S[i];
    end
      //전각문자 시작 바이트의 ASCII 코드를 얻는 루틴
    else if ByteType(S, i) = mbLeadByte then
    begin
      SAsc := IntToStr(Ord(S[i]));
      Asc1 := Ord(S[i]);
    end
      //전각문자 마지막 바이트의 ASCII 코드를 얻는 루틴
    else if ByteType(S, i) = mbTrailByte then
    begin
      SAsc := SAsc + IntToStr(Ord(S[i]));
      Asc2 := Ord(S[i]);

      // 전각 영숫자, 특수문자 처리 루틴
      if (StrToInt(SAsc) >= 163161) and
        (StrToInt(SAsc) <= 163253) then
      begin
        SS := Chr(StrToInt(SAsc) - 163128);
        Result := Result + SS;
      end
      else
        // 전각 한글 처리 루틴
      begin
        Result := Result + Chr(Asc1) + Chr(Asc2);
      end;
      SAsc := '';
    end;
  end;
end;
(*
function SingleToLead(AStr: string): string;
var
  i: integer;
begin
  Result := '';

  for i := 1 to Length(AStr) do begin
    case AStr[i] of
      'a', 'A': Result := Result + 'Ａ';
      'b', 'B': Result := Result + 'Ｂ';
      'c', 'C': Result := Result + 'Ｃ';
      'd', 'D': Result := Result + 'Ｄ';
      'e', 'E': Result := Result + 'Ｅ';
      'f', 'F': Result := Result + 'Ｆ';
      'g', 'G': Result := Result + 'Ｇ';
      'h', 'H': Result := Result + 'Ｈ';
      'i', 'I': Result := Result + 'Ｉ';
      'j', 'J': Result := Result + 'Ｊ';
      'k', 'K': Result := Result + 'Ｋ';
      'l', 'L': Result := Result + 'Ｌ';
      'm', 'M': Result := Result + 'Ｍ';
      'n', 'N': Result := Result + 'Ｎ';
      'o', 'O': Result := Result + 'Ｏ';
      'p', 'P': Result := Result + 'Ｐ';
      'q', 'Q': Result := Result + 'Ｑ';
      'r', 'R': Result := Result + 'Ｒ';
      's', 'S': Result := Result + 'Ｓ';
      't', 'T': Result := Result + 'Ｔ';
      'u', 'U': Result := Result + 'Ｕ';
      'v', 'V': Result := Result + 'Ｖ';
      'w', 'W': Result := Result + 'Ｗ';
      'x', 'X': Result := Result + 'Ｘ';
      'y', 'Y': Result := Result + 'Ｙ';
      'z', 'Z': Result := Result + 'Ｚ';
      ' '     : Result := Result + '　';
      '0'     : Result := Result + '０';
      '1'     : Result := Result + '１';
      '2'     : Result := Result + '２';
      '3'     : Result := Result + '３';
      '4'     : Result := Result + '４';
      '5'     : Result := Result + '５';
      '6'     : Result := Result + '６';
      '7'     : Result := Result + '７';
      '8'     : Result := Result + '８';
      '9'     : Result := Result + '９';
      '('     : Result := Result + '（';
      ')'     : Result := Result + '）';
      '~'     : Result := Result + '～';
      '`'     : Result := Result + '｀';
      '!'     : Result := Result + '！';
      '@'     : Result := Result + '＠';
      '#'     : Result := Result + '＃';
      '$'     : Result := Result + '＄';
      '%'     : Result := Result + '％';
      '^'     : Result := Result + '＾';
      '&'     : Result := Result + '＆';
      '*'     : Result := Result + '＊';
      '_'     : Result := Result + '＿';
      '-'     : Result := Result + '－';
      '+'     : Result := Result + '＋';
      '='     : Result := Result + '＝';
      '{'     : Result := Result + '｛';
      '['     : Result := Result + '［';
      '}'     : Result := Result + '｝';
      ']'     : Result := Result + '］';
      '|'     : Result := Result + '｜';
      '\'     : Result := Result + '￦';
      ':'     : Result := Result + '：';
      ';'     : Result := Result + '；';
      '"'     : Result := Result + '＂';
      ''''    : Result := Result + '＇';
      '<'     : Result := Result + '＜';
      ','     : Result := Result + '，';
      '>'     : Result := Result + '＞';
      '.'     : Result := Result + '．';
      '?'     : Result := Result + '？';
      '/'     : Result := Result + '／';
      else      Result := Result + AStr[i];
    end;
  end;
end;
*)
{ TFastGrab }

function SingleToLead(AStr: WideString): string;
var
  x_2byteChar: WideChar;
  c: WideChar;
  i: Integer;
begin
  //x_2byteChar := '　' //("%uFFFC");
  Result := '';
  for i := 1 to Length(AStr) do begin
    c := AStr[i];
    if Ord(c) in [32..126] then begin
      if not (c = #32) then x_2byteChar := WideChar(Ord(c) + 65248);
    end else x_2byteChar := c;
    if c = #32 then Result := Result + '　'
    else Result := Result + x_2byteChar;
  end;
end;


function Trim(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I > L then Result := '' else
  begin
    while S[L] <= ' ' do Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

function StrPas(const Str: PChar): string;
begin
  Result := Str;
end;

function XecureEscape(const aStr: string): string;
var
  i: Integer;
begin
  Result := '';

  if Length(aStr) < 1 then Exit;

  for i := 1 to Length(aStr) do begin
    case aStr[i] of
      ' ': Result := Result + '%20';
      '%': Result := Result + '%25';
      '&': Result := Result + '%26';
      '+': Result := Result + '%2B';
      '=': Result := Result + '%3D';
      '?': Result := Result + '%3F';
      else Result := Result + aStr[i];
    end;
  end;
end;
(*
function EraseComment(const aStr: string): string;
var
  StrTemp: string;
  StrList: TStringList;
  i: Integer;
begin
  Result := aStr;
  while True do begin
    StrTemp := StrGrab(Result, '/*', '*/');
    if StrTemp <> '' then begin
      Result := StrReplace(Result, '/*' + StrTemp + '*/', '');
    end else Break;
  end;

  StrList := TStringList.Create;
  try
    StrList.Text := Result;
    for i := 0 to StrList.Count - 1 do begin
      // Assertion('StrList:[%s]', [Trim(StrList.Strings[i])], True);
      if Pos('//', Trim(StrList.Strings[i])) = 1 then StrList.Strings[i] := '';
    end;
    Result := StrList.Text;
  finally
    if Assigned(StrList) then begin
      StrList.Free;
      StrList := nil;
    end;
  end;
end;
*)


function RemoveSpace(const aStr: string): String;
var
  sResult : String;
  sChar1, sChar2 : String;
  i : Integer;
begin
  sResult := '';

  if pos(' ', aStr) > 0 then
  begin
    for i := 1 to Length(aStr) do
    begin
      if i = 1 then sChar1 := ''
      else          sChar1 := aStr[i - 1];

      sChar2 := aStr[i];

      if (sChar1 = ' ') and (sChar2 = ' ') then Continue;

      sResult := sResult + sChar2;
    end;
  end
  else
  begin
    sResult := aStr;
  end;

  Result := sResult;
end;

//입력된 문자열이 지정된 길이보다 작다면 문자열 뒤에 입력된 char를 채우는 함수
function FillStringBack(Source: string; Size: Integer; FillChar: Char): string;
var
  i, len : Integer;
begin
  Result := '';
  len := Length(Source);

  if Size > len then
  begin
    Result := Source;
    for i := 1 to Size - len do
    begin
      Result := Result + string(FillChar);
    end;
  end else
    Result := Source;
end;

//입력된 문자열이 지정된 길이보다 작다면 문자열 앞에 입력된 char를 채우는 함수
function FillStringFront(Source: string; Size: Integer; FillChar: Char): string;
var
  i, len : Integer;
begin
  Result := '';
  len := Length(Source);

  if Size > len then
  begin
    for i := 1 to Size - len do
    begin
      Result := Result + string(FillChar);
    end;

    Result := Result + Source;
  end else
    Result := Source;
end;


end.

