object Setting: TSetting
  Left = 0
  Top = 0
  Caption = 'Setting'
  ClientHeight = 461
  ClientWidth = 784
  Color = clBtnFace
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 800
  Constraints.MinHeight = 500
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ctgrypnlgrpSetting: TCategoryPanelGroup
    Left = 0
    Top = 0
    Height = 461
    VertScrollBar.Tracking = True
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    TabOrder = 0
    object ctgrypnl2: TCategoryPanel
      Top = 225
      Height = 234
      Caption = 'Task Manager'
      TabOrder = 0
      object tvTaskManager: TTreeView
        Left = 0
        Top = 0
        Width = 196
        Height = 208
        Align = alClient
        Indent = 19
        RowSelect = True
        TabOrder = 0
        OnClick = tvTaskManagerClick
        Items.NodeData = {
          0301000000420000000000000000000000FFFFFFFFFFFFFFFF00000000000000
          000000000001124100750074006F006D00610074006900630020005300630068
          006500640075006C006500}
      end
    end
    object ctgrypnlGeneral: TCategoryPanel
      Top = 0
      Height = 225
      Caption = 'General'
      TabOrder = 1
      object tvGeneral: TTreeView
        Left = 0
        Top = 0
        Width = 196
        Height = 199
        Align = alClient
        Indent = 19
        TabOrder = 0
        OnClick = tvGeneralClick
        Items.NodeData = {
          0304000000360000000000000000000000FFFFFFFFFFFFFFFF00000000000000
          0000000000010C55007300650072002000530065007400740069006E0067003A
          0000000000000000000000FFFFFFFFFFFFFFFF00000000000000000000000001
          0E4D006F00640075006C0065002000530065007400740069006E006700380000
          000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000010D45
          00720072006F0072002000530065007400740069006E00670036000000000000
          0000000000FFFFFFFFFFFFFFFF000000000000000000000000010C4D00610069
          006C002000530065007400740069006E006700}
      end
    end
  end
  object pnlRSetting: TPanel
    Left = 200
    Top = 0
    Width = 584
    Height = 461
    Align = alClient
    TabOrder = 1
    object pnlMailSetting: TPanel
      Left = 1
      Top = 1
      Width = 582
      Height = 459
      Align = alClient
      TabOrder = 3
      object pnlTEmailSetting: TPanel
        Left = 1
        Top = 1
        Width = 580
        Height = 272
        Align = alTop
        TabOrder = 0
        object grpMailSetting: TGroupBox
          AlignWithMargins = True
          Left = 26
          Top = 26
          Width = 528
          Height = 235
          Margins.Left = 25
          Margins.Top = 25
          Margins.Right = 25
          Margins.Bottom = 10
          Align = alClient
          Caption = ' Configuration :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object lblserver: TLabel
            Left = 48
            Top = 30
            Width = 47
            Height = 16
            Caption = 'Server :'
          end
          object lblserverpost: TLabel
            Left = 67
            Top = 60
            Width = 28
            Height = 16
            Caption = 'Port:'
          end
          object lblEncryptSSL: TLabel
            Left = 221
            Top = 61
            Width = 58
            Height = 16
            Caption = 'TLS/SSL :'
          end
          object edtMailServer: TEdit
            Left = 101
            Top = 27
            Width = 356
            Height = 24
            TabOrder = 0
            TextHint = 'Input smtp server ...'
          end
          object edtServerPort: TEdit
            Left = 101
            Top = 56
            Width = 118
            Height = 24
            TabOrder = 1
            TextHint = 'port number'
          end
          object cbbSSL: TComboBox
            Left = 289
            Top = 57
            Width = 96
            Height = 24
            TabOrder = 2
          end
          object grpMailUserPass: TGroupBox
            AlignWithMargins = True
            Left = 27
            Top = 114
            Width = 474
            Height = 109
            Margins.Left = 25
            Margins.Top = 5
            Margins.Right = 25
            Margins.Bottom = 10
            Align = alBottom
            Caption = ' Information :'
            TabOrder = 3
            object lblPassword: TLabel
              Left = 76
              Top = 49
              Width = 64
              Height = 16
              Caption = 'Password :'
            end
            object lblUsername: TLabel
              Left = 73
              Top = 21
              Width = 67
              Height = 16
              Caption = 'Username :'
            end
            object btnMailSave: TButton
              Left = 283
              Top = 77
              Width = 75
              Height = 25
              Caption = 'Apply'
              TabOrder = 0
            end
            object btnConnect: TButton
              Left = 146
              Top = 77
              Width = 75
              Height = 25
              Caption = 'Connect'
              TabOrder = 1
            end
            object edtUsername: TEdit
              Left = 146
              Top = 19
              Width = 211
              Height = 24
              TabOrder = 2
              TextHint = 'enter username'
            end
            object edtPassword: TEdit
              Left = 146
              Top = 47
              Width = 211
              Height = 24
              PasswordChar = '*'
              TabOrder = 3
              TextHint = 'enter password'
            end
          end
          object btnServerSave: TButton
            Left = 246
            Top = 88
            Width = 66
            Height = 25
            Caption = 'Save'
            TabOrder = 4
          end
          object btnCancel: TButton
            Left = 318
            Top = 87
            Width = 66
            Height = 25
            Caption = 'Cancel'
            TabOrder = 5
          end
        end
      end
    end
    object pnlErrorSetting: TPanel
      Left = 1
      Top = 1
      Width = 582
      Height = 459
      Align = alClient
      TabOrder = 1
      object pnlErrorTop: TPanel
        Left = 1
        Top = 1
        Width = 580
        Height = 158
        Align = alTop
        TabOrder = 0
        object grpErrorKey: TGroupBox
          AlignWithMargins = True
          Left = 16
          Top = 16
          Width = 548
          Height = 126
          Margins.Left = 15
          Margins.Top = 15
          Margins.Right = 15
          Margins.Bottom = 15
          Align = alClient
          Caption = ' Setting :'
          TabOrder = 0
          object lblKeycode: TLabel
            Left = 80
            Top = 23
            Width = 32
            Height = 13
            Caption = 'Code :'
          end
          object lblDefinition: TLabel
            Left = 60
            Top = 47
            Width = 52
            Height = 13
            Caption = 'Definition :'
          end
          object edtkeycode: TEdit
            Left = 117
            Top = 15
            Width = 316
            Height = 21
            Alignment = taCenter
            AutoSelect = False
            AutoSize = False
            BevelInner = bvNone
            BevelOuter = bvNone
            TabOrder = 0
          end
          object mmoKeyDefinition: TMemo
            Left = 118
            Top = 41
            Width = 315
            Height = 75
            TabOrder = 1
          end
        end
      end
      object pnlErrorButtom: TPanel
        Left = 1
        Top = 159
        Width = 580
        Height = 299
        Align = alClient
        TabOrder = 1
        object lvErrorKeys: TListView
          AlignWithMargins = True
          Left = 11
          Top = 33
          Width = 558
          Height = 255
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alClient
          Columns = <
            item
              Caption = 'ID'
            end
            item
              Caption = 'Key Code'
            end
            item
              Caption = 'Definition'
            end>
          TabOrder = 0
          ViewStyle = vsReport
        end
        object pnlErrorKeyTButtom: TPanel
          Left = 1
          Top = 1
          Width = 578
          Height = 32
          Align = alTop
          BevelOuter = bvNone
          Padding.Right = 10
          TabOrder = 1
          object lblSearchkey: TLabel
            Left = 10
            Top = 8
            Width = 39
            Height = 16
            Caption = 'Enter :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object srchErrorKey: TSearchBox
            Left = 63
            Top = 3
            Width = 209
            Height = 25
            AutoSelect = False
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TextHint = 'Enter Key code ...'
            ButtonWidth = 25
          end
          object btnView: TButton
            AlignWithMargins = True
            Left = 493
            Top = 2
            Width = 75
            Height = 28
            Margins.Top = 2
            Margins.Right = 0
            Margins.Bottom = 2
            Align = alRight
            Caption = 'View'
            TabOrder = 1
          end
          object btnDelete: TButton
            AlignWithMargins = True
            Left = 415
            Top = 2
            Width = 75
            Height = 28
            Margins.Top = 2
            Margins.Right = 0
            Margins.Bottom = 2
            Align = alRight
            Caption = 'Delete'
            TabOrder = 2
          end
          object btnSave: TButton
            AlignWithMargins = True
            Left = 337
            Top = 2
            Width = 75
            Height = 28
            Margins.Top = 2
            Margins.Right = 0
            Margins.Bottom = 2
            Align = alRight
            Caption = 'Save'
            TabOrder = 3
          end
        end
      end
    end
    object pnlASchedule: TPanel
      Left = 1
      Top = 1
      Width = 582
      Height = 459
      Align = alClient
      TabOrder = 0
      object pnlASTop: TPanel
        Left = 1
        Top = 1
        Width = 580
        Height = 232
        Align = alTop
        TabOrder = 0
        object grpAStop: TGroupBox
          AlignWithMargins = True
          Left = 26
          Top = 11
          Width = 528
          Height = 212
          Margins.Left = 25
          Margins.Top = 10
          Margins.Right = 25
          Margins.Bottom = 8
          Align = alClient
          Caption = ' Schedule Setting : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object lblBegintask: TLabel
            Left = 16
            Top = 24
            Width = 104
            Height = 16
            Caption = 'Begin to the task :'
          end
          object lblStart: TLabel
            Left = 269
            Top = 24
            Width = 37
            Height = 16
            Caption = 'Start :'
          end
          object lblMailTo: TLabel
            Left = 258
            Top = 54
            Width = 47
            Height = 16
            Caption = 'Mail to :'
          end
          object cbbtaskType: TComboBox
            Left = 126
            Top = 21
            Width = 130
            Height = 24
            TabOrder = 0
            Items.Strings = (
              'On a Schedule'
              'At Log on'
              'At Start up')
          end
          object dtpSStartDate: TDateTimePicker
            Left = 312
            Top = 21
            Width = 105
            Height = 24
            Date = 42400.694158958340000000
            Time = 42400.694158958340000000
            TabOrder = 1
          end
          object dtpSTime: TDateTimePicker
            Left = 419
            Top = 21
            Width = 96
            Height = 24
            Date = 42400.694774618050000000
            Format = 'hh:mm:ss'
            Time = 42400.694774618050000000
            DateMode = dmUpDown
            TabOrder = 2
          end
          object rgChoose: TRadioGroup
            Left = 18
            Top = 51
            Width = 102
            Height = 126
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Items.Strings = (
              'One time'
              'Daily'
              'Weekly')
            ParentFont = False
            TabOrder = 3
          end
          object chklstDays: TCheckListBox
            Left = 126
            Top = 51
            Width = 130
            Height = 126
            Items.Strings = (
              'Monday'
              'Tuesday'
              'Wednesday'
              'Thursday'
              'Friday'
              'Saturday'
              'Sunday')
            TabOrder = 4
          end
          object edtadminMail: TEdit
            Left = 305
            Top = 51
            Width = 210
            Height = 24
            TabOrder = 5
          end
          object btnRemove: TButton
            Left = 161
            Top = 181
            Width = 95
            Height = 25
            Caption = 'Remove'
            TabOrder = 6
          end
          object btnOk: TButton
            Left = 305
            Top = 181
            Width = 96
            Height = 25
            Caption = 'OK'
            TabOrder = 7
          end
          object btnCancle: TButton
            Left = 430
            Top = 181
            Width = 85
            Height = 25
            Caption = 'Cancel'
            TabOrder = 8
          end
          object mmoMailBody: TMemo
            Left = 305
            Top = 81
            Width = 210
            Height = 96
            TabOrder = 9
          end
        end
      end
      object pnlASButtom: TPanel
        Left = 1
        Top = 226
        Width = 580
        Height = 232
        Align = alBottom
        TabOrder = 1
      end
    end
    object pnlModuleSetting: TPanel
      Left = 1
      Top = 1
      Width = 582
      Height = 459
      Align = alClient
      TabOrder = 2
      object pnlTModuleSetting: TPanel
        Left = 1
        Top = 1
        Width = 580
        Height = 188
        Align = alTop
        TabOrder = 0
        object grpTModuleSetting: TGroupBox
          AlignWithMargins = True
          Left = 26
          Top = 26
          Width = 528
          Height = 136
          Margins.Left = 25
          Margins.Top = 25
          Margins.Right = 25
          Margins.Bottom = 25
          Align = alClient
          Caption = ' Setting : '
          TabOrder = 0
          object lblModuleDir: TLabel
            Left = 18
            Top = 32
            Width = 93
            Height = 16
            Caption = 'Folder location :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblModuleExtension: TLabel
            Left = 48
            Top = 65
            Width = 63
            Height = 16
            Caption = 'Extension :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblModuleThread: TLabel
            Left = 173
            Top = 65
            Width = 110
            Height = 16
            Caption = 'Number of thread :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object edtModuleDirs: TEdit
            Left = 117
            Top = 27
            Width = 332
            Height = 25
            AutoSelect = False
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '../module/'
          end
          object btnModuleDirs: TButton
            Left = 447
            Top = 27
            Width = 34
            Height = 25
            Caption = ' ...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object edtModuleExtension: TEdit
            Left = 117
            Top = 57
            Width = 50
            Height = 25
            Alignment = taCenter
            AutoSelect = False
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = 'kha'
          end
          object cbbModuleThread: TComboBox
            Left = 289
            Top = 58
            Width = 49
            Height = 24
            DropDownCount = 4
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = '1'
            Items.Strings = (
              '1'
              '2'
              '4'
              '6'
              '8'
              '10')
          end
          object btnModuleSettingOk: TButton
            Left = 347
            Top = 87
            Width = 75
            Height = 25
            Caption = 'OK'
            TabOrder = 4
          end
          object btnModuleSettingCancle: TButton
            Left = 423
            Top = 87
            Width = 75
            Height = 25
            Caption = 'Cancel'
            TabOrder = 5
          end
        end
      end
      object pnlBModuleSetting: TPanel
        Left = 1
        Top = 189
        Width = 580
        Height = 269
        Align = alClient
        TabOrder = 1
      end
    end
  end
end
