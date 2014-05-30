object ModParam: TModParam
  Left = 540
  Top = 483
  BorderStyle = bsSingle
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1077#1083#1080
  ClientHeight = 175
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblGMELT: TLabel
    Left = 52
    Top = 12
    Width = 126
    Height = 13
    Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1089#1090#1072#1080#1074#1072#1085#1080#1103
  end
  object lbl: TLabel
    Left = 32
    Top = 36
    Width = 145
    Height = 13
    Caption = #1055#1083#1086#1090#1085#1086#1089#1090#1100' '#1074#1099#1087#1072#1074#1096#1077#1075#1086' '#1089#1085#1077#1075#1072
  end
  object lbESN: TLabel
    Left = 72
    Top = 60
    Width = 105
    Height = 13
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088' '#1080#1089#1087#1072#1088#1077#1085#1080#1103
  end
  object lbULMAX: TLabel
    Left = 7
    Top = 84
    Width = 171
    Height = 13
    Caption = #1042#1086#1076#1086#1089#1076#1077#1088#1078#1080#1074#1072#1102#1097#1072#1103' '#1089#1087#1086#1089#1086#1073#1085#1086#1089#1090#1100
  end
  object lblELEV0: TLabel
    Left = 66
    Top = 108
    Width = 111
    Height = 13
    Caption = #1042#1099#1089#1086#1090#1072' '#1084#1077#1090#1077#1086#1089#1090#1072#1085#1094#1080#1080
  end
  object lblGcm: TLabel
    Left = 308
    Top = 36
    Width = 26
    Height = 13
    Caption = #1075'/'#1089#1084'3'
  end
  object lblMeter: TLabel
    Left = 308
    Top = 108
    Width = 6
    Height = 13
    Caption = #1084
  end
  object edtGMELT: TEdit
    Left = 183
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtRNEW: TEdit
    Left = 183
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtESN: TEdit
    Left = 183
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtULMAX: TEdit
    Left = 183
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtELEV0: TEdit
    Left = 184
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object btnOK: TButton
    Left = 88
    Top = 136
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 5
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 176
    Top = 136
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = btnCancelClick
  end
end
