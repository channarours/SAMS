unit MySeed;

interface

uses
  DCPCrypt2, DCPrc4, DCPMD5, DCPSha256;
function SeedEncToSHA256(key: string; word: string): String;
function seedDcpFromSHA256(key: string; word: string): string;

implementation

function SeedEncToSHA256(key: string; word: string): String;
var
  cipher: TDCP_rc4;
begin
  cipher := TDCP_rc4.Create(nil);
  cipher.InitStr(key, TDCP_sha256);
  Result := cipher.EncryptString(word);
  cipher.Burn;
  cipher.Free;
end;

function seedDcpFromSHA256(key: string; word: string): String;
var
  cipher: TDCP_rc4;
begin
  cipher := TDCP_rc4.Create(nil);
  cipher.InitStr(key, TDCP_sha256);
  Result := cipher.DecryptString(word);
  cipher.Burn;
  cipher.Free;
end;

end.
