object InitialGraph: TInitialGraph
  Left = 0
  Top = 0
  Caption = #1043#1088#1072#1092#1080#1082' '#1085#1072#1095#1072#1083#1100#1085#1099#1093' '#1091#1089#1083#1086#1074#1080#1081
  ClientHeight = 416
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelChart: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 416
    Align = alLeft
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'PanelChart'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 8
    object ChartTemp: TChart
      Left = 0
      Top = 0
      Width = 569
      Height = 210
      Legend.Visible = False
      Title.Text.Strings = (
        'Temp')
      BottomAxis.LabelsFormat.TextAlignment = taCenter
      DepthAxis.LabelsFormat.TextAlignment = taCenter
      DepthTopAxis.LabelsFormat.TextAlignment = taCenter
      LeftAxis.LabelsFormat.TextAlignment = taCenter
      RightAxis.LabelsFormat.TextAlignment = taCenter
      TopAxis.LabelsFormat.TextAlignment = taCenter
      View3D = False
      Zoom.Pen.Mode = pmNotXor
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: TLineSeries
        Marks.Visible = False
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object ChartPrec: TChart
      Left = 0
      Top = 208
      Width = 569
      Height = 208
      Legend.Visible = False
      Title.Text.Strings = (
        'Prec')
      BottomAxis.LabelsFormat.TextAlignment = taCenter
      DepthAxis.LabelsFormat.TextAlignment = taCenter
      DepthTopAxis.LabelsFormat.TextAlignment = taCenter
      LeftAxis.LabelsFormat.TextAlignment = taCenter
      RightAxis.LabelsFormat.TextAlignment = taCenter
      TopAxis.LabelsFormat.TextAlignment = taCenter
      View3D = False
      Zoom.Pen.Mode = pmNotXor
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series2: TLineSeries
        Marks.Visible = False
        Brush.BackColor = clDefault
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
  object PanelControls: TPanel
    Left = 566
    Top = 0
    Width = 137
    Height = 416
    Align = alRight
    Alignment = taLeftJustify
    BevelEdges = []
    Caption = 'PanelControls'
    ShowCaption = False
    TabOrder = 1
    ExplicitHeight = 408
    object ButtonResize: TButton
      Left = 32
      Top = 336
      Width = 75
      Height = 25
      Caption = 'Resize'
      TabOrder = 0
      Visible = False
      OnClick = ButtonResizeClick
    end
    object GroupBoxPeriod: TGroupBox
      Left = 9
      Top = 0
      Width = 120
      Height = 113
      Caption = #1055#1077#1088#1080#1086#1076
      TabOrder = 1
      object LabelFrom: TLabel
        Left = 9
        Top = 16
        Width = 11
        Height = 13
        Caption = #1057':'
      end
      object LabelTo: TLabel
        Left = 9
        Top = 62
        Width = 17
        Height = 13
        Caption = #1055#1086':'
      end
      object ComboBoxFrom: TComboBox
        Left = 16
        Top = 35
        Width = 101
        Height = 21
        TabOrder = 0
        OnChange = ComboBoxFromChange
      end
      object ComboBoxTo: TComboBox
        Left = 16
        Top = 81
        Width = 101
        Height = 21
        TabOrder = 1
        OnChange = ComboBoxToChange
      end
    end
    object ButtonData: TButton
      Left = 32
      Top = 300
      Width = 75
      Height = 25
      Caption = #1044#1072#1085#1085#1099#1077
      TabOrder = 2
      Visible = False
      OnClick = ButtonDataClick
    end
    object SGData: TStringGrid
      Left = 24
      Top = 160
      Width = 320
      Height = 120
      ColCount = 6
      TabOrder = 3
      Visible = False
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object ButtonDate: TButton
      Left = 32
      Top = 376
      Width = 75
      Height = 25
      Caption = #1044#1072#1090#1072
      TabOrder = 4
      Visible = False
      OnClick = ButtonDateClick
    end
  end
end
