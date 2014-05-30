object ContParam: TContParam
  Left = 676
  Top = 364
  BorderStyle = bsSingle
  Caption = #1059#1087#1088#1072#1074#1083#1103#1102#1097#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
  ClientHeight = 139
  ClientWidth = 378
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
  object lblNumOfDays: TLabel
    Left = 72
    Top = 12
    Width = 82
    Height = 13
    Caption = #1055#1077#1088#1080#1086#1076' '#1088#1072#1089#1095#1077#1090#1072
  end
  object lbTSforCalc: TLabel
    Left = 47
    Top = 36
    Width = 107
    Height = 13
    Caption = #1064#1072#1075' '#1080#1085#1090#1077#1075#1088#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object lbTSforInp: TLabel
    Left = 42
    Top = 60
    Width = 111
    Height = 13
    Caption = #1064#1072#1075' '#1074#1093#1086#1076#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
  end
  object lbDays: TLabel
    Left = 289
    Top = 12
    Width = 21
    Height = 13
    Caption = #1089#1091#1090'.'
  end
  object lbDays2: TLabel
    Left = 288
    Top = 60
    Width = 21
    Height = 13
    Caption = #1089#1091#1090'.'
  end
  object lblSec: TLabel
    Left = 288
    Top = 36
    Width = 21
    Height = 13
    Caption = #1089#1077#1082'.'
  end
  object edtN: TEdit
    Left = 160
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtTAU: TEdit
    Left = 160
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtDUR: TEdit
    Left = 160
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object btOK: TButton
    Left = 94
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = btOKClick
  end
  object btnCancel: TButton
    Left = 184
    Top = 96
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = btnCancelClick
  end
end
