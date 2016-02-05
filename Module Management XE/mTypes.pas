unit mTypes;

interface

const

{Parameter Length}

  M_MAXPARAM  = 20;

{Type of Send Data}

  M_SDT_RESULT  : String                           = 'SResult';
  M_SDT_STATUS  : String                           = 'SStatus';
  M_SDT_ERROR   : String                           = 'SError';
  M_SDT_PROGRESS: String                           = 'SProgress';

{Status Process}

  M_STP_ON_START  : String                           = 'Starting';
  M_STP_ON_INIT   : String                           = 'Init';
  M_STP_ON_PARAM  : String                           = 'Param';
  M_STP_ON_LOGIN  : String                           = 'Login';
  M_STP_ON_ENTER  : String                           = 'Enter';
  M_STP_ON_EXCUTE : String                           = 'Excute';
  M_STP_ON_RESULT : String                           = 'Result';
	M_STP_ON_FINAL  : String                           = 'Finally';
  M_STP_ON_END    : String                           = 'End';

{common error code }

// successful
  S_M_OK: HResult                               = HResult(0);          // successfull

// information code
  I_M_RESULT_NOTPRESENT: Integer                = HResult($42110000);  // no result

// system error
  E_M_UNKNOWN: HResult                          = HResult($8000FFFF);  // unkown error   FFFF = 9999
  E_M_FAILTOGETPAGE: HResult                    = HResult($80000200);  // fail connect to webpage error
  E_M_FAILTOINITCOM: HResult                    = HResult($8000E000);  // E = 8
  E_M_RESULT_FAIL: HResult                      = HResult($80002F10);  // result fail error
  E_M_RESULT_VERFY_FAIL: HResult                = HResult($80002F12);  //
  E_M_SESSION_CLOSED: HResult                   = HResult($80002F20);  //
  E_M_SITE_INTERNAL: HResult                    = HResult($80002F30);  //
  E_M_SITE_INVALID: HResult                     = HResult($80002F31);  //

  E_M_USERID_NOTENTER: HResult                  = HResult($80002F32);  // User ID or Password Invalid
  E_M_PASSWORD_NOTENTER: HResult                = HResult($80002F33);

  E_M_CODE_NOTEXIST:HRESULT                     = HResult($80002F34);  // Module not exist
// Set Param
{-----Scient AXX01XX-----}

  {-----Math AXX0101-----}
  MPARAM_AXX0101_1                    =  1;
  MPARAM_AXX0101_USERID               =  2;
  MPARAM_AXX0101_3                    =  3;
  MPARAM_AXX0101_4                    =  4;
  MPARAM_AXX0101_USER_PASSWOED        =  5;
  MPARAM_AXX0101_6                    =  6;
  MPARAM_AXX0101_7                    =  7;
  MPARAM_AXX0101_8                    =  8;

// Set Result
{-----Scient AXX01XX-----}

  {-----Math AXX0101-----}
  MRESULT_AXX0101_ARTICLE_ID                  =  1;
  MRESULT_AXX0101_CATEGORY_CODE               =  2;
  MRESULT_AXX0101_USER_INFO_CODE              =  3;
  MRESULT_AXX0101_ARTICLE_TITLE               =  4;
  MRESULT_AXX0101_ARTICLE_DESCRIPTION         =  5;
  MRESULT_AXX0101_ARTICLE_PATH                =  6;
  MRESULT_AXX0101_ARTICLE_IMAGE               =  7;
  MRESULT_AXX0101_ARTICLE_DATE                =  8;

  //////////////////////////////////////////////////////////////////////////////

type
  TBASEParam = record
    Items: array[0..M_MAXPARAM] of String;
  end;
  {
  TBASEResult = record
    Items: array[0..M_MAXPARAM] of String;
  end;}

var
  BASEParam: TBASEParam;      // parameter structure
  BASEResult: TBASEParam;    // result structure

implementation

uses SysUtils;

end.
