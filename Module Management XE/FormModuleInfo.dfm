object frmModuleInfo: TfrmModuleInfo
  Left = 0
  Top = 0
  ClientHeight = 201
  ClientWidth = 359
  Color = clBtnFace
  Constraints.MaxHeight = 240
  Constraints.MaxWidth = 375
  Constraints.MinHeight = 240
  Constraints.MinWidth = 375
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object lblName: TLabel
    Left = 29
    Top = 19
    Width = 42
    Height = 16
    Caption = 'Name :'
  end
  object lblType: TLabel
    Left = 34
    Top = 49
    Width = 37
    Height = 16
    Caption = 'Type :'
  end
  object lblService: TLabel
    Left = 16
    Top = 79
    Width = 55
    Height = 16
    Caption = 'Service : '
  end
  object lblCode: TLabel
    Left = 33
    Top = 109
    Width = 38
    Height = 16
    Caption = 'Code :'
  end
  object lblParam: TLabel
    Left = 25
    Top = 139
    Width = 46
    Height = 16
    Caption = 'Param :'
  end
  object edtName: TEdit
    Left = 81
    Top = 16
    Width = 249
    Height = 24
    TabOrder = 0
  end
  object edtType: TEdit
    Left = 81
    Top = 46
    Width = 249
    Height = 24
    TabOrder = 1
  end
  object edtService: TEdit
    Left = 81
    Top = 76
    Width = 249
    Height = 24
    TabOrder = 2
  end
  object edtCode: TEdit
    Left = 81
    Top = 106
    Width = 249
    Height = 24
    TabOrder = 3
  end
  object edtParam: TEdit
    Left = 81
    Top = 136
    Width = 249
    Height = 24
    TabOrder = 4
    OnClick = edtParamClick
  end
  object btnSave: TButton
    Left = 174
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 255
    Top = 167
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 6
  end
end
