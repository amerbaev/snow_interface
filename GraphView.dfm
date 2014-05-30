object Graph: TGraph
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  Caption = #1043#1088#1072#1092#1080#1082
  ClientHeight = 418
  ClientWidth = 714
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelControls: TPanel
    Left = 581
    Top = 0
    Width = 137
    Height = 418
    Align = alLeft
    Alignment = taLeftJustify
    TabOrder = 0
    ExplicitLeft = 610
    ExplicitHeight = 442
    object Период: TGroupBox
      Left = 6
      Top = 0
      Width = 123
      Height = 105
      Caption = #1055#1077#1088#1080#1086#1076
      TabOrder = 0
      object LFrom: TLabel
        Left = 3
        Top = 21
        Width = 11
        Height = 13
        Caption = #1057':'
      end
      object LTo: TLabel
        Left = 3
        Top = 62
        Width = 17
        Height = 13
        Caption = #1055#1086':'
      end
      object CBFrom: TComboBox
        Left = 15
        Top = 35
        Width = 105
        Height = 21
        TabOrder = 0
        OnChange = CBFromChange
      end
      object CBTo: TComboBox
        Left = 15
        Top = 81
        Width = 105
        Height = 21
        TabOrder = 1
        OnChange = CBToChange
      end
    end
    object DataButton: TButton
      Left = 32
      Top = 288
      Width = 75
      Height = 25
      Caption = #1044#1072#1085#1085#1099#1077
      TabOrder = 1
      Visible = False
      OnClick = DataButtonClick
    end
    object SGRez: TStringGrid
      Left = -4
      Top = 316
      Width = 45
      Height = 37
      ColCount = 6
      TabOrder = 2
      Visible = False
      ColWidths = (
        64
        64
        64
        64
        64
        64)
    end
    object ButtonSWE: TButton
      Left = 32
      Top = 111
      Width = 75
      Height = 25
      Caption = 'SWE'
      TabOrder = 3
      OnClick = ButtonSWEClick
    end
    object ButtonDepth: TButton
      Left = 32
      Top = 142
      Width = 75
      Height = 25
      Caption = 'Depth'
      TabOrder = 4
      OnClick = ButtonDepthClick
    end
    object SGDepth: TStringGrid
      Left = 6
      Top = 367
      Width = 67
      Height = 32
      TabOrder = 5
      Visible = False
    end
    object SGSWE: TStringGrid
      Left = 47
      Top = 319
      Width = 64
      Height = 47
      TabOrder = 6
      Visible = False
    end
    object ButtonDate: TButton
      Left = 32
      Top = 264
      Width = 75
      Height = 25
      Caption = #1044#1072#1090#1072
      TabOrder = 7
      Visible = False
      OnClick = ButtonDateClick
    end
    object ButtonResize: TButton
      Left = 32
      Top = 248
      Width = 75
      Height = 25
      Caption = 'Resize'
      TabOrder = 8
      OnClick = ButtonResizeClick
    end
  end
  object PanelChart: TPanel
    Left = 0
    Top = 0
    Width = 581
    Height = 418
    Align = alLeft
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'PanelChart'
    TabOrder = 1
    ExplicitWidth = 610
    ExplicitHeight = 442
    DesignSize = (
      581
      418)
    object TChartMelt: TChart
      Left = 0
      Top = 286
      Width = 581
      Height = 132
      Legend.Visible = False
      Title.Text.Strings = (
        'Melt')
      BottomAxis.LabelsFormat.TextAlignment = taCenter
      DepthAxis.LabelsFormat.TextAlignment = taCenter
      DepthTopAxis.LabelsFormat.TextAlignment = taCenter
      LeftAxis.LabelsFormat.TextAlignment = taCenter
      RightAxis.LabelsFormat.TextAlignment = taCenter
      TopAxis.LabelsFormat.TextAlignment = taCenter
      View3D = False
      View3DOptions.Orthogonal = False
      Zoom.Pen.Mode = pmNotXor
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 310
      ExplicitWidth = 610
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series3: TLineSeries
        Marks.Visible = False
        Title = 'Graph'
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
    object TChartDepth: TChart
      Left = 0
      Top = 193
      Width = 590
      Height = 130
      Border.Width = 0
      Legend.LegendStyle = lsSeries
      Legend.Visible = False
      Title.Text.Strings = (
        'Depth')
      AxisBehind = False
      BottomAxis.Axis.SmallSpace = 1
      BottomAxis.LabelsFormat.TextAlignment = taCenter
      BottomAxis.LabelStyle = talText
      DepthAxis.LabelsFormat.TextAlignment = taCenter
      DepthTopAxis.LabelsFormat.TextAlignment = taCenter
      LeftAxis.LabelsFormat.TextAlignment = taCenter
      RightAxis.LabelsFormat.TextAlignment = taCenter
      Shadow.Visible = False
      TopAxis.LabelsFormat.TextAlignment = taCenter
      View3D = False
      View3DOptions.Orthogonal = False
      Zoom.Pen.Mode = pmNotXor
      BevelOuter = bvNone
      TabOrder = 1
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 619
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series2: TLineSeries
        Marks.Visible = False
        Title = 'Graph'
        Brush.BackColor = clDefault
        Pointer.Brush.Gradient.EndColor = 10708548
        Pointer.Gradient.EndColor = 10708548
        Pointer.InflateMargins = True
        Pointer.Style = psRectangle
        Pointer.Visible = False
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object TChartSWE: TChart
      Left = 0
      Top = 0
      Width = 584
      Height = 187
      Legend.Visible = False
      Title.Text.Strings = (
        'SWE')
      BottomAxis.LabelsFormat.TextAlignment = taCenter
      DepthAxis.LabelsFormat.TextAlignment = taCenter
      DepthTopAxis.LabelsFormat.TextAlignment = taCenter
      LeftAxis.LabelsFormat.TextAlignment = taCenter
      RightAxis.LabelsFormat.TextAlignment = taCenter
      TopAxis.LabelsFormat.TextAlignment = taCenter
      View3D = False
      Zoom.Pen.Mode = pmNotXor
      BevelOuter = bvNone
      TabOrder = 2
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 613
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 7
      object Series1: TLineSeries
        Marks.Visible = False
        Title = 'Graph'
        Brush.BackColor = clDefault
        LinePen.SmallSpace = 1
        Pointer.Brush.Gradient.EndColor = 6724095
        Pointer.Gradient.EndColor = 6724095
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
  object ODSWE: TOpenDialog
    Left = 643
    Top = 184
  end
  object ODDepth: TOpenDialog
    Left = 691
    Top = 216
  end
end
