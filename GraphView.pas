unit GraphView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCLTee.TeEngine, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, VclTee.TeeGDIPlus, Vcl.Grids, Vcl.ComCtrls,
  Vcl.StdCtrls, VCLTee.Series, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TGraph = class(TForm)
    TChartDepth: TChart;
    TChartMelt: TChart;
    PanelControls: TPanel;
    PanelChart: TPanel;
    ������: TGroupBox;
    LFrom: TLabel;
    LTo: TLabel;
    CBFrom: TComboBox;
    DataButton: TButton;
    SGRez: TStringGrid;
    CBTo: TComboBox;
    TChartSWE: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    ButtonSWE: TButton;
    ButtonDepth: TButton;
    ODSWE: TOpenDialog;
    ODDepth: TOpenDialog;
    SGDepth: TStringGrid;
    SGSWE: TStringGrid;
    ButtonDate: TButton;
    ButtonResize: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DataButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBFromChange(Sender: TObject);
    procedure CBToChange(Sender: TObject);
    procedure ButtonSWEClick(Sender: TObject);
    procedure ButtonDepthClick(Sender: TObject);
    procedure ButtonDateClick(Sender: TObject);
    procedure ButtonResizeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Graph: TGraph;
  SWEPoints, DepthPoints: TPointSeries;

implementation

{$R *.dfm}

uses Main;

//��������� ����������� ������������ �����������
procedure TGraph.ButtonResizeClick(Sender: TObject);
begin
  PanelChart.Height:=Graph.ClientHeight;
  TChartSWE.Height:=round(Graph.ClientHeight/3);
  TChartDepth.Top:=round(Graph.ClientHeight/3);
  TChartDepth.Height:=round(Graph.ClientHeight/3);
  TChartMelt.Height:=round(Graph.ClientHeight/3);
end;

//���������� ������������ ����������� ��� �������� �����
procedure TGraph.FormCreate(Sender: TObject);
begin
  ButtonResize.Click;
end;

//���������� ������������ ����������� ��� ��������� �������� �����
procedure TGraph.FormResize(Sender: TObject);
begin
  ButtonResize.Click;
end;

//���������� ������������ ����������� ��� ������ ����� � ����� ������
procedure TGraph.FormShow(Sender: TObject);
begin
  ButtonResize.Click;
  DataButton.Click;
end;

// �������� ������ ��������
function ReplaceSpaces(WorkString:string; numofvar: Integer): String;
var
  i, k, space, tab: Integer;
begin
  // ������� ������� � ���� � ������ ������
  while( (WorkString[1]=' ') or (WorkString[1]=#9) ) do
    Delete(WorkString, 1, 1);

  for i:=1 to numofvar-1 do
  begin
    // �������  ��������� ������� ������� ��� ����
    space := Pos(' ', WorkString);
    tab := Pos(#9, WorkString);

    { ���� ������ ������� ������ ���� � ������ ������� ��� ��� �� �������,
    ���������� ��� �������, ����� ������� ���� }
    if ( ( (space < tab) and (space > 0) ) or ( tab = 0 ) )then
      k:=space
    else
      k:=tab;

    // ������� ��� ������� � ����, �������� ������ ������
    while( (WorkString[k+1]=' ') or (WorkString[k+1]=#9) ) do
      Delete(WorkString, k+1, 1);
    WorkString[k]:='_'; { �������� ������ ��� ��������� �� ������ �������������,
                    ����� ����� ��������� ������ ��� ��� �� ��������� �������� }
  end;
  Result:=WorkString;
end;

// ���������� ������� �����������
procedure ReplacePoint(M: TStrings; numofvar: Integer);
var
  i, pointpos: Integer;
begin
  for i:=0 to numofvar-1 do
  { ������ ������� ����������� � ����� �� �������,
  ����� ��������� ���������� �� float }
  begin
    pointpos:=pos('.',M.Strings[i]);
    // ���� ����� � ������, �������� � �� 0,
    if(pointpos=1) then
      M.Strings[i]:= StringReplace(M.Strings[i],'.','0,',[rfReplaceAll])
    else
      // ���� ����� � ����� ����� � ������ ������� �
      if((pointpos>0) and (Length(M.Strings[i])=pointpos)) then
         M.Strings[i]:=StringReplace(M.Strings[i],'.','',[rfReplaceAll]);
    // ������ ��� ���������� ����� �� �������
    M.Strings[i]:=StringReplace(M.Strings[i],'.',',',[rfReplaceAll]);
  end;
end;

//���������� ������ ��� ��������� ��������� ��� �������� ����
procedure TGraph.ButtonDateClick(Sender: TObject);
var
  Znach: String;
  i, j: integer;
  SWEFile, TmpStringList: TStrings;
begin
  if CBFrom.ItemIndex>=CBTo.ItemIndex then
    ShowMessage('���� ������ ������� ��������� ���� ��� �����, �������� ������ ��������')
  else
  begin
    TChartSWE.Series[0].Clear;
    TChartDepth.Series[0].Clear;
    TChartMelt.Series[0].Clear;
    for i := CBFrom.ItemIndex to CBTo.ItemIndex do
    begin
      TChartSWE.Series[0].Add(StrToFloat(SGRez.Cells[2,i+1]), StringReplace(SGRez.Cells[1, i+1],',','.',[rfReplaceAll]), clPurple);
      TChartDepth.Series[0].Add(StrToFloat(SGRez.Cells[3,i+1]), StringReplace(SGRez.Cells[1, i+1],',','.',[rfReplaceAll]), clBlue);
      TChartMelt.Series[0].Add(StrToFloat(SGRez.Cells[4,i+1]), StringReplace(SGRez.Cells[1, i+1],',','.',[rfReplaceAll]), clAqua);
    end;
  end;
  if ODSWE.Files.Count=1 then
  begin
    SWEPoints.Clear;
    j:=1;
    for i := CBFrom.ItemIndex to CBTo.ItemIndex do
    begin
      if StringReplace(CBFrom.Items[i], '.', ',', [rfReplaceAll])=SGDepth.Cells[1,j] then
      begin
        SWEPoints.Add(StrToFloat(SGDepth.Cells[2,j]), CBFrom.Items[i], clPurple);
        j:=j+1;
      end
      else
      SWEPoints.Add(StrToFloat(SGRez.Cells[3,i+1]), CBFrom.Items[i], clNone);
    end;
  end;
  if ODDepth.Files.Count=1 then
  begin
    DepthPoints.Clear;
    j:=1;
    for i := CBFrom.ItemIndex to CBTo.ItemIndex do
    begin
      if StringReplace(CBFrom.Items[i], '.', ',', [rfReplaceAll])=SGDepth.Cells[1,j] then
      begin
        DepthPoints.Add(StrToFloat(SGDepth.Cells[2,j]), CBFrom.Items[i], clPurple);
        j:=j+1;
      end
      else
      DepthPoints.Add(StrToFloat(SGRez.Cells[3,i+1]), CBFrom.Items[i], clNone);
    end;
  end;
end;

//��������� �������� ����� Depth
procedure TGraph.ButtonDepthClick(Sender: TObject);
var
  DepthFile, TmpStringList: TStrings;
  i, j: Integer;
begin
  if ODDepth.Execute then
  begin
    if TChartSWE.SeriesCount=2 then
    begin
      DepthPoints.Free;
    end;
    DepthFile:=TStringList.Create;
    DepthFile.LoadFromFile(ODDepth.FileName);
    DepthPoints:=TPointSeries.Create(Self);
    DepthPoints.Marks.Visible:=True;
    SGDepth.RowCount:=DepthFile.Count;
    for i := 1 to DepthFile.Count-1 do
    begin
      DepthFile.Strings[i]:= ReplaceSpaces(DepthFile.Strings[i], 2);
      TmpStringList:= TStringList.Create;
      TmpStringList.Text:=StringReplace(DepthFile.Strings[i],'_',#13#10,[rfReplaceAll]);
      ReplacePoint(TmpStringList, 2);
      SGDepth.Cells[1,i]:=TmpStringList.Strings[0];
      SGDepth.Cells[2,i]:=TmpStringList.Strings[1];
      TmpStringList.Free;
    end;

    j:=1;
    for i := CBFrom.ItemIndex to CBTo.ItemIndex do
      begin
        if StringReplace(CBFrom.Items[i], '.', ',', [rfReplaceAll])=SGDepth.Cells[1,j] then
        begin
          DepthPoints.Add(StrToFloat(SGDepth.Cells[2,j]), CBFrom.Items[i], clBlue);
          j:=j+1
        end
        else
          DepthPoints.Add(StrToFloat(SGRez.Cells[3,i+1]), CBFrom.Items[i], clNone);
      end;
    TChartDepth.AddSeries(DepthPoints);
  end;
end;

//��������� �������� ����� SWE
procedure TGraph.ButtonSWEClick(Sender: TObject);
var
  SWEFile, TmpStringList: TStrings;
  i, j: Integer;
begin
  if ODSWE.Execute then
  begin
    if TChartSWE.SeriesCount=2 then
    begin
      SWEPoints.Free;
    end;
    SWEFile:=TStringList.Create;
    SWEFile.LoadFromFile(ODSWE.FileName);
    SWEPoints:=TPointSeries.Create(Self);
    SWEPoints.Marks.Visible:=True;
    SGDepth.RowCount:=SWEFile.Count;
    for i := 1 to SWEFile.Count-1 do
    begin
      SWEFile.Strings[i]:= ReplaceSpaces(SWEFile.Strings[i], 2);
      TmpStringList:= TStringList.Create;
      TmpStringList.Text:=StringReplace(SWEFile.Strings[i],'_',#13#10,[rfReplaceAll]);
      ReplacePoint(TmpStringList, 2);
      SGDepth.Cells[1,i]:=TmpStringList.Strings[0];
      SGDepth.Cells[2,i]:=TmpStringList.Strings[1];
      TmpStringList.Free;
    end;
    SWEFile.Free;

    j:=1;
    for i := CBFrom.ItemIndex to CBTo.ItemIndex do
      begin
        if StringReplace(CBFrom.Items[i], '.', ',', [rfReplaceAll])=SGDepth.Cells[1,j] then
        begin
          SWEPoints.Add(StrToFloat(SGDepth.Cells[2,j]), CBFrom.Items[i], clPurple);
          j:=j+1
        end
        else
          SWEPoints.Add(StrToFloat(SGRez.Cells[3,i+1]), CBFrom.Items[i], clNone);
      end;
    TChartSWE.AddSeries(SWEPoints);
  end;
end;

//��������� ��������� ����
procedure TGraph.CBFromChange(Sender: TObject);
begin
  ButtonDate.Click;
end;

//��������� �������� ����
procedure TGraph.CBToChange(Sender: TObject);
begin
  ButtonDate.Click;
end;

//��������� ��������� ������ ��������
procedure TGraph.DataButtonClick(Sender: TObject);
var
  SL,TmpStringList:TStrings;
  i:integer;
  Znach, TmpString:String;
begin
  SL:=TStringList.Create;
  SL.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\vnd.rez');
  for i := 2 to SL.Count-1 do // ������ �� ������ �����
    if Length(trim(SL.Strings[i]))=0 then
      SL.Delete(i);

  SGRez.RowCount:=SL.Count-1;
  for i := 2 to SL.Count-1 do  // ��������� �������
  begin
      SL.Strings[i]:= ReplaceSpaces(SL.Strings[i], 5);
      TmpStringList:= TStringList.Create;
      TmpStringList.Text:=StringReplace(SL.Strings[i],'_',#13#10,[rfReplaceAll]);
      ReplacePoint(TmpStringList, 5);
      TmpString:=TmpStringList.Strings[0];
      Insert(',', TmpString, 3); //��������� ����������� ������ � ���
      TmpStringList.Strings[0]:=TmpString;
      SGRez.Cells[1,i-1]:=TmpStringList.Strings[0]; //����
      SGRez.Cells[2,i-1]:=TmpStringList.Strings[1]; //SWE
      SGRez.Cells[3,i-1]:=TmpStringList.Strings[2]; //Depth
      SGRez.Cells[4,i-1]:=TmpStringList.Strings[3]; //Melt
      TmpStringList.Free;
  end;

  for i := 1 to SGRez.RowCount-1 do
  begin
    CBFrom.Items.Add(StringReplace(SGRez.Cells[1, i],',','.',[rfReplaceAll]));
    CBTo.Items.Add(StringReplace(SGRez.Cells[1, i],',','.',[rfReplaceAll]));
  end;
  CBFrom.ItemIndex:=0;
  CBTo.ItemIndex:=CBTo.Items.Count-1;

  for i := CBFrom.ItemIndex to CBTo.ItemIndex do
  begin
    TChartSWE.Series[0].Add(StrToFloat(SGRez.Cells[2,i+1]), StringReplace(SGRez.Cells[1, i+1],',','.',[rfReplaceAll]), clPurple);
    TChartDepth.Series[0].Add(StrToFloat(SGRez.Cells[3,i+1]), StringReplace(SGRez.Cells[1, i+1],',','.',[rfReplaceAll]), clBlue);
    TChartMelt.Series[0].Add(StrToFloat(SGRez.Cells[4,i+1]), StringReplace(SGRez.Cells[1, i+1],',','.',[rfReplaceAll]), clAqua);
  end;

  SL.Free;
end;

end.
