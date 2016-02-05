unit drawprogressU;

interface

uses
  SysUtils, Classes, Windows, Graphics;

procedure DrawProgress(Canvas: TCanvas; dr: TRect; Pos: Single;Max : Integer; Color: TColor;const txtBar: String;Font: TFont);

implementation

function Blend(Color1, Color2: TColor; Value: Byte): TColor;
var
  i: LongInt;
  r1, g1, b1, r2, g2, b2: Byte;
begin
  Value := Round(2.56 * Value);
  i := ColorToRGB(Color2);
  r1 := Byte(i);
  g1 := Byte(i shr 8);
  b1 := Byte(i shr 16);
  i := ColorToRGB(Color1);
  r2 := Byte(i);
  g2 := Byte(i shr 8);
  b2 := Byte(i shr 16);
  r1 := Byte((Value * (r2 - r1)) shr 8 + r1);
  g1 := Byte((Value * (g2 - g1)) shr 8 + g1);
  b1 := Byte((Value * (b2 - b1)) shr 8 + b1);
  Result := (b1 shl 16) + (g1 shl 8) + r1;
end;

procedure SmoothGradient(Canvas: TCanvas; const ARect: TRect; const c1: TColor;
  const Gray: boolean);
type
  PRGB = ^TRGB;

  TRGB = record
    b, g, r: Byte;
  end;

  PRGBArray = ^TRGBArray;
  TRGBArray = array [0 .. 65565] of TRGB;
var
  rc1, gc1, bc1, rc2, gc2, bc2, rc3, gc3, bc3, rc4, gc4, bc4: integer;
  x, y, w, h: integer;
  i, w1, w2, h1, sp, sm: integer;
  Row: PRGBArray;
  C, AC: TRGB;
  slMain, slSize, slPtr: integer;
  Color, tc: integer;
  Profil: array of TRGB;
  r, g, b: integer;
  bmp: TBitmap;
begin
  if ((ARect.Right - ARect.Left) - 1 <= 0) or
    ((ARect.Bottom - ARect.Top) - 1 <= 1) then
    Exit;
  bmp := TBitmap.Create;
  bmp.PixelFormat := pf24Bit;
  bmp.Width := (ARect.Right - ARect.Left) - 1;
  bmp.Height := (ARect.Bottom - ARect.Top) - 1;
  h := bmp.Height;
  w := bmp.Width;
  SetLength(Profil, h);
  Color := ColorToRGB(c1);
  if Gray then
  begin
    rc1 := 253;
    gc1 := 253;
    bc1 := 253;
    rc2 := 218;
    gc2 := 218;
    bc2 := 218;
    rc3 := 160;
    gc3 := 160;
    bc3 := 160;
    rc4 := 213;
    gc4 := 213;
    bc4 := 213;
  end
  else
  begin
    tc := Blend(Color, clWhite, 5);
    rc1 := Byte(tc);
    gc1 := Byte(tc shr 8);
    bc1 := Byte(tc shr 16);
    tc := Blend(Color, clWhite, 50);
    rc2 := Byte(tc);
    gc2 := Byte(tc shr 8);
    bc2 := Byte(tc shr 16);
    tc := Blend(Color, clBlack, 60);
    rc3 := Byte(tc);
    gc3 := Byte(tc shr 8);
    bc3 := Byte(tc shr 16);
    tc := Blend(Color, clBlack, 80);
    rc4 := Byte(tc);
    gc4 := Byte(tc shr 8);
    bc4 := Byte(tc shr 16);
  end;
  sp := Trunc(h / 2.5);
  y := sp;
  for i := 0 to y - 1 do
  begin
    C.r := Byte(rc1 + (((rc2 - rc1) * (i)) div y));
    C.g := Byte(gc1 + (((gc2 - gc1) * (i)) div y));
    C.b := Byte(bc1 + (((bc2 - bc1) * (i)) div y));
    Profil[i] := C;
  end;
  for i := y to h - 1 do
  begin
    C.r := Byte(rc3 + (((rc4 - rc3) * (i)) div h));
    C.g := Byte(gc3 + (((gc4 - gc3) * (i)) div h));
    C.b := Byte(bc3 + (((bc4 - bc3) * (i)) div h));
    Profil[i] := C;
  end;
  if Gray then
  begin
    rc1 := 200;
    gc1 := 200;
    bc1 := 200;
    rc2 := 253;
    gc2 := 253;
    bc2 := 253;
  end
  else
  begin
    tc := Blend(Color, clBlack, 50);
    rc1 := Byte(tc);
    gc1 := Byte(tc shr 8);
    bc1 := Byte(tc shr 16);
    tc := Blend(Color, clWhite, 50);
    rc2 := Byte(tc);
    gc2 := Byte(tc shr 8);
    bc2 := Byte(tc shr 16);
  end;
  w1 := w - 1;
  w := (w shr 1) + (w and 1);
  slMain := integer(bmp.ScanLine[0]);
  slSize := integer(bmp.ScanLine[1]) - slMain;
  h1 := h shr 1;
  w2 := 25;
  for x := 0 to w - 1 do
  begin
    if x < w2 then
    begin
      C.b := Byte(bc1 + (((bc2 - bc1) * x) div w2));
      C.g := Byte(gc1 + (((gc2 - gc1) * x) div w2));
      C.r := Byte(rc1 + (((rc2 - rc1) * x) div w2));
    end
    else
    begin
      C.b := bc2;
      C.g := gc2;
      C.r := rc2;
    end;
    slPtr := slMain;
    for y := 0 to h - 1 do
    begin
      Row := PRGBArray(slPtr);
      r := Profil[y].r;
      g := Profil[y].g;
      b := Profil[y].b;
      if (x = 0) or ((y < sp) or (y = h - 1)) then
      begin
        if x = 0 then
          sm := 3
        else
          sm := 2;
        Row[x].r := Byte((C.r - r) shr sm + r);
        Row[x].g := Byte((C.g - g) shr sm + g);
        Row[x].b := Byte((C.b - b) shr sm + b);
      end
      else
      begin
        Row[x].r := Byte((C.r - r) div 2 + r);
        Row[x].g := Byte((C.g - g) div 2 + g);
        Row[x].b := Byte((C.b - b) div 2 + b);
      end;
      if (x < (w1 - x)) then
        Row[w1 - x] := Row[x];
      slPtr := slPtr + slSize;
    end;
  end;
  Profil := nil;
  Canvas.Draw(ARect.Left, ARect.Top, bmp);
  FreeAndNil(bmp);
end;

procedure DrawProgress(Canvas: TCanvas; dr: TRect; Pos: Single;Max : Integer; Color: TColor;const txtBar: String;Font: TFont);
const
  FPercentage=true;
var
  r: TRect;
  TempBmp: TBitmap;
  C: TColor;
  TxtRect: TRect;
  TxtFont: TFont;
  S: String;

begin
  TempBmp := TBitmap.Create;
  C := Blend(clWhite, clSilver, 50);



  With TempBmp do
  begin
    PixelFormat := pf24Bit;
    Width := dr.Right - dr.Left;
    Height := dr.Bottom - dr.Top;
    Canvas.Brush.Style := bsSolid;
    Canvas.Pen.Color := $00A0A0A0;
    r := Rect(0, 0, Width, Height);
    Canvas.Rectangle(r);
    Canvas.Pen.Color := clSilver;
    Canvas.MoveTo(1, 0);
    Canvas.LineTo(r.Right- 1, r.Top);
    Canvas.Pixels[r.Left, r.Top] := C;
    Canvas.Pixels[r.Left, r.Bottom - 1] := C;
    Canvas.Pixels[r.Right - 1, r.Top] := C;
    Canvas.Pixels[r.Right - 1, r.Bottom - 1] := C;
  end;

  r.Left := 1;
  r.Top := 1;
  SmoothGradient(TempBmp.Canvas, r, Color, True);
  r.Right := Round((dr.Right - dr.Left) / Max * Pos);
  if r.Right > 0 then SmoothGradient(TempBmp.Canvas, r, Color, False);
  TempBmp.Canvas.Brush.Style := bsSolid;
  TxtRect := dr;

  TxtFont := TFont.Create;
  try
    TxtFont.Assign(Font);
    TxtFont.Height := TxtRect.Bottom - TxtRect.Top;
  finally
  TxtFont.Free;
  end;
  Canvas.CopyMode := cmSrcCopy;
  Canvas.Draw(TxtRect.Left, TxtRect.Top, TempBmp);
  S := Format('%s %.1f%%', [txtBar, pos]);
  DrawText(Canvas.Handle,PChar(s), -1, TxtRect, DT_SINGLELINE or DT_CENTER or
      DT_VCENTER or DT_END_ELLIPSIS or DT_NOPREFIX);
  TempBmp.Free;
end;

end.
