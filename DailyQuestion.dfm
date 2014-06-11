object FormQuest: TFormQuest
  Left = 0
  Top = 0
  Caption = #1060#1072#1081#1083' DailyData'
  ClientHeight = 51
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Locate: TButton
    Left = 16
    Top = 8
    Width = 115
    Height = 33
    Caption = #1059#1082#1072#1079#1072#1090#1100' '#1092#1072#1081#1083' *.inp'
    TabOrder = 0
    OnClick = LocateClick
  end
  object Old: TButton
    Left = 152
    Top = 8
    Width = 115
    Height = 33
    Caption = #1054#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1072#1088#1099#1081
    TabOrder = 1
    OnClick = OldClick
  end
end
