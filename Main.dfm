object MainForm: TMainForm
  Left = 523
  Top = 268
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Snow Interface'
  ClientHeight = 223
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PrintScale = poNone
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnRun: TButton
    Left = 72
    Top = 183
    Width = 129
    Height = 34
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1089#1095#1077#1090
    TabOrder = 0
    OnClick = btnRunClick
  end
  object grpControlPar: TGroupBox
    Left = 8
    Top = 9
    Width = 273
    Height = 168
    Caption = #1059#1087#1088#1072#1074#1083#1103#1102#1097#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 1
    object lblNumOfDays: TLabel
      Left = 40
      Top = 20
      Width = 86
      Height = 13
      Caption = #1055#1077#1088#1080#1086#1076' '#1088#1072#1089#1095#1077#1090#1072':'
    end
    object lbTSforInp: TLabel
      Left = 10
      Top = 68
      Width = 115
      Height = 13
      Caption = #1064#1072#1075' '#1074#1093#1086#1076#1085#1099#1093' '#1076#1072#1085#1085#1099#1093':'
    end
    object lblTSforCalc: TLabel
      Left = 15
      Top = 44
      Width = 111
      Height = 13
      Caption = #1064#1072#1075' '#1080#1085#1090#1077#1075#1088#1080#1088#1086#1074#1072#1085#1080#1103':'
    end
    object lblTSforInpVal: TLabel
      Left = 130
      Top = 68
      Width = 4
      Height = 13
      Caption = '-'
    end
    object lblNumofDaysVal: TLabel
      Left = 130
      Top = 20
      Width = 4
      Height = 13
      Caption = '-'
    end
    object lblTSforCalcVal: TLabel
      Left = 130
      Top = 44
      Width = 4
      Height = 13
      Caption = '-'
    end
    object btnRedContr: TButton
      Left = 72
      Top = 120
      Width = 97
      Height = 32
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = btnRedContrClick
    end
  end
  object grpModelPar: TGroupBox
    Left = 287
    Top = 8
    Width = 273
    Height = 169
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1077#1083#1080
    TabOrder = 2
    object lblULMAX: TLabel
      Left = 6
      Top = 77
      Width = 175
      Height = 13
      Caption = #1042#1086#1076#1086#1089#1076#1077#1088#1078#1080#1074#1072#1102#1097#1072#1103' '#1089#1087#1086#1089#1086#1073#1085#1086#1089#1090#1100':'
    end
    object lblGMELT: TLabel
      Left = 51
      Top = 20
      Width = 130
      Height = 13
      Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1089#1090#1072#1080#1074#1072#1085#1080#1103':'
    end
    object lblELEV0: TLabel
      Left = 66
      Top = 96
      Width = 115
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072' '#1084#1077#1090#1077#1086#1089#1090#1072#1085#1094#1080#1080':'
    end
    object lblRNEW: TLabel
      Left = 32
      Top = 39
      Width = 149
      Height = 13
      Caption = #1055#1083#1086#1090#1085#1086#1089#1090#1100' '#1074#1099#1087#1072#1074#1096#1077#1075#1086' '#1089#1085#1077#1075#1072':'
    end
    object lblESN: TLabel
      Left = 72
      Top = 58
      Width = 109
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' '#1080#1089#1087#1072#1088#1077#1085#1080#1103':'
    end
    object lblGMELTVal: TLabel
      Left = 187
      Top = 20
      Width = 4
      Height = 13
      Caption = '-'
    end
    object lblELEV0val: TLabel
      Left = 187
      Top = 96
      Width = 4
      Height = 13
      Caption = '-'
    end
    object lblESNval: TLabel
      Left = 187
      Top = 58
      Width = 4
      Height = 13
      Caption = '-'
    end
    object lblRNEWval: TLabel
      Left = 187
      Top = 39
      Width = 4
      Height = 13
      Caption = '-'
    end
    object lblULMAXval: TLabel
      Left = 187
      Top = 77
      Width = 4
      Height = 13
      Caption = '-'
    end
    object btnRedModel: TButton
      Left = 96
      Top = 121
      Width = 97
      Height = 32
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = btnRedModelClick
    end
  end
  object btnGraph: TButton
    Left = 367
    Top = 183
    Width = 129
    Height = 34
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' ('#1075#1088#1072#1092#1080#1082')'
    TabOrder = 3
    OnClick = btnGraphClick
  end
  object btnReload: TButton
    Left = 224
    Top = 280
    Width = 75
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 4
    Visible = False
    OnClick = btnReloadClick
  end
  object btnInitial: TButton
    Left = 207
    Top = 183
    Width = 154
    Height = 34
    Caption = #1042#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' ('#1075#1088#1072#1092#1080#1082')'
    TabOrder = 5
    OnClick = btnInitialClick
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 280
    object File1: TMenuItem
      Caption = #1060#1072#1081#1083
      object SnowdatOpenMenuBtn: TMenuItem
        Caption = #1042#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      end
      object InitialOpenMenuBtn: TMenuItem
        Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103
        OnClick = InitialOpenMenuBtnClick
      end
      object N3: TMenuItem
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        object ParamOpenMenuBtn: TMenuItem
          Caption = 'param'
          OnClick = ParamOpenMenuBtnClick
        end
        object Datas1OpenMenuBtn: TMenuItem
          Caption = 'datas1'
          OnClick = Datas1OpenMenuBtnClick
        end
        object ZonesOpenMenuBtn: TMenuItem
          Caption = 'zones'
          OnClick = ZonesOpenMenuBtnClick
        end
      end
      object Rez1OpenMenuBtn: TMenuItem
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1088#1072#1089#1095#1077#1090#1086#1074
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object ExitMenuBtn: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = ExitMenuBtnClick
      end
    end
    object Edit1: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      object DailyEditMenuBtn: TMenuItem
        Caption = #1042#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
        OnClick = DailyEditMenuBtnClick
      end
      object InitConEditMenuBtn: TMenuItem
        Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103
        OnClick = InitConEditMenuBtnClick
      end
    end
  end
  object dlgOpenInitCon: TOpenDialog
    Left = 48
    Top = 280
  end
  object dlgOpenParam: TOpenDialog
    Left = 112
    Top = 280
  end
  object dlgOpenDatas: TOpenDialog
    Left = 144
    Top = 280
  end
  object dlgOpenZones: TOpenDialog
    Left = 80
    Top = 280
  end
  object dlgOpenDaily: TOpenDialog
    Left = 176
    Top = 280
  end
end
