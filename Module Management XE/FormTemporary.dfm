object frmTemporary: TfrmTemporary
  Left = 0
  Top = 0
  Caption = 'Temporary Module'
  ClientHeight = 436
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TCode: TLabel
    Left = 13
    Top = 21
    Width = 41
    Height = 13
    Caption = 'Module :'
  end
  object TLParam: TLabel
    Left = 17
    Top = 51
    Width = 37
    Height = 13
    Caption = 'Param :'
  end
  object edtCode: TEdit
    Left = 60
    Top = 18
    Width = 293
    Height = 21
    TabOrder = 0
    OnDblClick = edtCodeDblClick
  end
  object edtParam: TEdit
    Left = 60
    Top = 48
    Width = 293
    Height = 21
    TabOrder = 1
    OnDblClick = edtParamDblClick
  end
  object lvTMList: TListView
    Left = 8
    Top = 109
    Width = 363
    Height = 139
    Columns = <
      item
        Caption = 'No'
      end
      item
        Caption = 'Name'
      end
      item
        Caption = 'Status'
      end
      item
        Caption = 'Path'
      end
      item
        Caption = 'Param'
      end>
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnSelectItem = lvTMListSelectItem
  end
  object mmoTM: TMemo
    Left = 8
    Top = 285
    Width = 363
    Height = 137
    Lines.Strings = (
      'mmoTM')
    TabOrder = 3
  end
  object btnStart: TButton
    Left = 278
    Top = 254
    Width = 93
    Height = 25
    Caption = 'Start'
    TabOrder = 4
    OnClick = btnStartClick
  end
  object btnTMAdd: TButton
    Left = 278
    Top = 78
    Width = 93
    Height = 25
    Caption = 'Add'
    TabOrder = 5
    OnClick = btnTMAddClick
  end
end