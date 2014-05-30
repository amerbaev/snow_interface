unit GraphInit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls, VCLTee.Series,
  Vcl.Grids;

type
  TInitialGraph = class(TForm)
    PanelChart: TPanel;
    PanelControls: TPanel;
    ChartTemp: TChart;
    ChartPrec: TChart;
    ButtonResize: TButton;
    LabelFrom: TLabel;
    LabelTo: TLabel;
    GroupBoxPeriod: TGroupBox;
    ComboBoxFrom: TComboBox;
    ComboBoxTo: TComboBox;
    Series1: TLineSeries;
    Series2: TLineSeries;
    ButtonData: TButton;
    SGData: TStringGrid;
    ButtonDate: TButton;
    procedure ButtonResizeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonDataClick(Sender: TObject);
    procedure ButtonDateClick(Sender: TObject);
    procedure ComboBoxFromChange(Sender: TObject);
    procedure ComboBoxToChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InitialGraph: TInitialGraph;

implementation

uses Main;

{$R *.dfm}
//Right fraction divider
procedure ReplacePoint(M: TStrings; numofvar: Integer);
var
  i, pointpos: Integer;
begin
  for i:=0 to numofvar-1 do
  { Replace divider from point to comma}
  begin
    pointpos:=pos('.',M.Strings[i]);
    //If point in start then replace it to "0,"
    if(pointpos=1) then
      M.Strings[i]:= StringReplace(M.Strings[i],'.','0,',[rfReplaceAll])
    else
      //If porint in end then just delete it
      if((pointpos>0) and (Length(M.Strings[i])=pointpos)) then
         M.Strings[i]:=StringReplace(M.Strings[i],'.','',[rfReplaceAll]);
    //Replace all remaining points to commas
    M.Strings[i]:=StringReplace(M.Strings[i],'.',',',[rfReplaceAll]);
  end;
end;

//Delete uneceessary spaces
function ReplaceSpaces(WorkString:string; numofvar: Integer): String;
var
  i, k, space, tab: Integer;
begin
  //Delete all spaces and tabs on start of line
  while( (WorkString[1]=' ') or (WorkString[1]=#9) ) do
    Delete(WorkString, 1, 1);

  for i:=1 to numofvar-1 do
  begin
    //Find first space or tab position
    space := Pos(' ', WorkString);
    tab := Pos(#9, WorkString);

    if ( ( (space < tab) and (space > 0) ) or ( tab = 0 ) )then
      k:=space
    else
      k:=tab;

    //Delete all tabs and spaces after found
    while( (WorkString[k+1]=' ') or (WorkString[k+1]=#9) ) do
      Delete(WorkString, k+1, 1);
    WorkString[k]:='_'; {Replace found to underscore for find next space or tab on next iteration}
  end;
  Result:=WorkString;
end;

procedure TInitialGraph.ButtonDateClick(Sender: TObject);
var
  i: integer;
begin
  if ComboBoxFrom.ItemIndex>=ComboBoxTo.ItemIndex then
    ShowMessage('Дата начала периода превышает дату его конца, выберите другие значения')
  else
  begin
    ChartTemp.Series[0].Clear;
    ChartPrec.Series[0].Clear;
    for i := ComboBoxFrom.ItemIndex to ComboBoxTo.ItemIndex do
    begin
      ChartTemp.Series[0].Add(StrToFloat(SGData.Cells[2,i+1]), StringReplace(SGData.Cells[1, i+1],',','.',[rfReplaceAll]), clRed);
      ChartPrec.Series[0].Add(StrToFloat(SGData.Cells[3,i+1]), StringReplace(SGData.Cells[1, i+1],',','.',[rfReplaceAll]), clBlue);
    end;
  end;
end;

procedure TInitialGraph.ButtonResizeClick(Sender: TObject);
begin
  PanelChart.Height:=InitialGraph.ClientHeight;
  ChartTemp.Height:=Round(InitialGraph.ClientHeight/2);
  ChartPrec.Height:=Round(InitialGraph.ClientHeight/2);
end;

procedure TInitialGraph.ComboBoxFromChange(Sender: TObject);
begin
  ButtonDate.Click;
end;

procedure TInitialGraph.ComboBoxToChange(Sender: TObject);
begin
  ButtonDate.Click;
end;

procedure TInitialGraph.FormCreate(Sender: TObject);
begin
 ButtonResize.Click;
end;

procedure TInitialGraph.FormResize(Sender: TObject);
begin
  ButtonResize.Click;
end;

procedure TInitialGraph.FormShow(Sender: TObject);
begin
  ButtonResize.Click;
  ButtonData.Click;
end;

procedure TInitialGraph.ButtonDataClick(Sender: TObject);
var
  StrList, TmpStringList: TStrings;
  i: Integer;
  TmpString: string;
begin
  StrList:=TStringList.Create;
  StrList.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\'+Main.DailyFilename);
  {for i := 2 to StrList.Count-1 do
    if Length(Trim(StrList.Strings[i]))=0 then
      StrList.Delete(i);}
  SGData.RowCount:=StrList.Count;
  for i := 1 to StrList.Count-1 do
  begin
    StrList.Strings[i]:=ReplaceSpaces(StrList.Strings[i], 4);
    TmpStringList:=TStringList.Create;
    TmpStringList.Text:=StringReplace(StrList.Strings[i],'_',#13#10,[rfReplaceAll]);
    ReplacePoint(TmpStringList, 4);
    TmpString:=TmpStringList.Strings[0];
    Insert(',',TmpString,3);
    TmpStringList.Strings[0]:=TmpString;
    SGData.Cells[1,i]:=TmpStringList.Strings[0]; //Date
    SGData.Cells[2,i]:=TmpStringList.Strings[1]; //Temperature
    SGData.Cells[3,i]:=TmpStringList.Strings[2]; //Precipitation
    TmpStringList.Free;
  end;
  for i := 1 to SGData.RowCount-1 do
  begin
    ComboBoxFrom.Items.Add(StringReplace(SGData.Cells[1, i],',','.',[rfReplaceAll]));
    ComboBoxTo.Items.Add(StringReplace(SGData.Cells[1, i],',','.',[rfReplaceAll]));
  end;
  ComboBoxFrom.ItemIndex:=0;
  ComboBoxTo.ItemIndex:=ComboBoxTo.Items.Count-1;
  for i := ComboBoxFrom.ItemIndex to ComboBoxTo.ItemIndex do
  begin
    ChartTemp.Series[0].Add(StrToFloat(SGData.Cells[2,i+1]), StringReplace(SGData.Cells[1, i+1],',','.',[rfReplaceAll]), clRed);
    ChartPrec.Series[0].Add(StrToFloat(SGData.Cells[3,i+1]), StringReplace(SGData.Cells[1, i+1],',','.',[rfReplaceAll]), clBlue);
  end;

  StrList.Free;
end;

end.
