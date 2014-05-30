unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ShellAPI, Vcl.Grids, Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    SnowdatOpenMenuBtn: TMenuItem;
    InitialOpenMenuBtn: TMenuItem;
    N3: TMenuItem;
    Rez1OpenMenuBtn: TMenuItem;
    ParamOpenMenuBtn: TMenuItem;
    Datas1OpenMenuBtn: TMenuItem;
    ZonesOpenMenuBtn: TMenuItem;
    DailyEditMenuBtn: TMenuItem;
    InitConEditMenuBtn: TMenuItem;
    btnRun: TButton;
    ExitMenuBtn: TMenuItem;
    lblNumOfDays: TLabel;
    lblTSforCalc: TLabel;
    lbTSforInp: TLabel;
    grpControlPar: TGroupBox;
    grpModelPar: TGroupBox;
    lblULMAX: TLabel;
    lblGMELT: TLabel;
    lblELEV0: TLabel;
    lblRNEW: TLabel;
    lblESN: TLabel;
    btnRedContr: TButton;
    btnRedModel: TButton;
    btnGraph: TButton;
    N10: TMenuItem;
    dlgOpenInitCon: TOpenDialog;
    dlgOpenParam: TOpenDialog;
    dlgOpenDatas: TOpenDialog;
    dlgOpenZones: TOpenDialog;
    lblTSforInpVal: TLabel;
    lblNumofDaysVal: TLabel;
    lblTSforCalcVal: TLabel;
    lblGMELTVal: TLabel;
    lblELEV0val: TLabel;
    lblESNval: TLabel;
    lblRNEWval: TLabel;
    lblULMAXval: TLabel;
    dlgOpenDaily: TOpenDialog;
    btnReload: TButton;
    btnInitial: TButton;
    procedure ControlParEditMenuBtnClick(Sender: TObject);
    procedure ExitMenuBtnClick(Sender: TObject);
    procedure ModelParEditMenuBtnClick(Sender: TObject);
    procedure btnRedContrClick(Sender: TObject);
    procedure btnRedModelClick(Sender: TObject);
    procedure InitialOpenMenuBtnClick(Sender: TObject);
    procedure ParamOpenMenuBtnClick(Sender: TObject);
    procedure Datas1OpenMenuBtnClick(Sender: TObject);
    procedure ZonesOpenMenuBtnClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnGraphClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnReloadClick(Sender: TObject);
    procedure btnInitialClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Depth, Density: Real;
  Elev0, ElevMax, ElevStep: Real;
  NumOfDays, TSforCalc, TSforInp, GMELT: Real;
  TCR, RNEW, ESN, ULMAX0, UL0: Real;
  FileInitCon, FileDailyData, FileParam, FileDatas, FileZones, DailyFilename: string;

implementation

uses ContrPar, ParMod, GraphView, GraphInit;

{$R *.dfm}

//Перезапись файла SNOWDAT
procedure SnowdatRewrite;
var
  M:TStrings;
begin
  M:=TStringList.Create;
  M.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT');
  M.Strings[1]:=FloatToStr(Depth)+' '+FloatToStr(Density);
  M.SaveToFile(ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT');
  M.Free;
end;

//Перезапись файла ZONES.ARE
procedure ZonesRewrite;
var
  M:TStrings;
begin
  M:=TStringList.Create;
  M.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE');
  M.Strings[3]:=FloatToStr(Elev0)+' '+FloatToStr(ElevMax)+' '+FloatToStr(ElevStep);
  M.SaveToFile(ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE');
  M.Free;
end;

//Перезапись файла PARAM.ARE
procedure ParamRewrite;
var
  M:TStrings;
begin
  M:=TStringList.Create;
  M.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE');
  M.Strings[2]:=FloatToStr(NumOfDays)+' '+FloatToStr(TSforCalc)+' '+FloatToStr(TSforInp);
  M.Strings[4]:=FloatToStr(GMELT);
  M.SaveToFile(ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE');
  M.Free;
end;

//Перезапись файла DATAS1.ARE
procedure Datas1Rewrite;
var
  M:TStrings;
begin
  M:=TStringList.Create;
  M.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\DATAS1.ARE');
  M.Strings[1]:=FloatToStr(TCR)+' '+FloatToStr(RNEW)+' '+FloatToStr(ESN)+' '
                +FloatToStr(ULMAX0)+FloatToStr(UL0);
  M.SaveToFile(ExtractFilePath(Application.ExeName)+'fortfiles\DATAS1.ARE');
  M.Free;
end;

//Запуск программы расчета
procedure Calculate;
begin
  ShellExecute(Application.Handle,'open','snow_DD_model.exe',nil,'...\fortfiles',SW_RESTORE);
end;

//Вызов запуска программы расчета
procedure TMainForm.btnRunClick(Sender: TObject);
begin
  Calculate;
end;

//Выход из программы
procedure TMainForm.ExitMenuBtnClick(Sender: TObject);
begin
  MainForm.Close;
end;

//Открыть окно редактирования управляющих параметров (мб сам файл)
procedure TMainForm.ControlParEditMenuBtnClick(Sender: TObject);
begin
  ContParam.ShowModal;
  btnReload.Click;
end;

//Открыть окно редактирования параметров модели (мб сам файл)
procedure TMainForm.ModelParEditMenuBtnClick(Sender: TObject);
begin
  ModParam.ShowModal;
  btnReload.Click;
end;

//Показать графики
procedure TMainForm.btnGraphClick(Sender: TObject);
begin
  Graph.ShowModal;
end;

//Открыть окно редактирования управляющих параметров
procedure TMainForm.btnInitialClick(Sender: TObject);
begin
  InitialGraph.ShowModal;
end;

//Редактирование управляющих параметров
procedure TMainForm.btnRedContrClick(Sender: TObject);
begin
  ContParam.ShowModal;
  btnReload.Click;
end;

//Открыть окно редактирования параметров модели
procedure TMainForm.btnRedModelClick(Sender: TObject);
begin
  ModParam.ShowModal;
  btnReload.Click;
  SnowdatRewrite;
  ZonesRewrite;
end;

//Обновление всех данных (событие — костыль)
procedure TMainForm.btnReloadClick(Sender: TObject);
begin
  lblNumofDaysVal.Caption:=FloatToStr(NumOfDays);
  lblTSforCalcVal.Caption:=FloatToStr(TSforCalc);
  lblTSforInpVal.Caption:=FloatToStr(TSforInp);
  lblGMELTVal.Caption:=FloatToStr(GMELT);
  lblRNEWval.Caption:=FloatToStr(RNEW);
  lblESNval.Caption:=FloatToStr(ESN);
  lblULMAXval.Caption:=FloatToStr(ULMAX0);
  lblELEV0val.Caption:=FloatToStr(Elev0);
end;

// Удаление лишних пробелов
function ReplaceSpaces(WorkString:string; numofvar: Integer): String;
var
  i, k, space, tab: Integer;
begin
  // удаляем пробелы и табы в начале строки
  while( (WorkString[1]=' ') or (WorkString[1]=#9) ) do
    Delete(WorkString, 1, 1);

  for i:=1 to numofvar-1 do
  begin
    // находим  положение первого пробела или таба
    space := Pos(' ', WorkString);
    tab := Pos(#9, WorkString);

    { если пробел нашелся раньше таба и вообще нашелся или таб не нашелся,
    используем его позицию, иначе позицию таба }
    if ( ( (space < tab) and (space > 0) ) or ( tab = 0 ) )then
      k:=space
    else
      k:=tab;

    // удаляем все пробелы и табы, оставляя только первый
    while( (WorkString[k+1]=' ') or (WorkString[k+1]=#9) ) do
      Delete(WorkString, k+1, 1);
    WorkString[k]:='_'; { заменяем пробел или табуляцию на нижнее подчеркивание,
                    чтобы найти следующий пробел или таб на следующей итерации }
  end;
  Result:=WorkString;
end;

//Правильный дробный разделитель
procedure ReplacePoint(M: TStrings; numofvar: Integer);
var
  i, pointpos: Integer;
begin
  for i:=0 to numofvar-1 do
  { меняем дробный разделитель с точки на запятую,
  чтобы корректно перевелось во float }
  begin
    pointpos:=pos('.',M.Strings[i]);
    // если точка в начале, заменяем её на 0,
    if(pointpos=1) then
      M.Strings[i]:= StringReplace(M.Strings[i],'.','0,',[rfReplaceAll])
    else
      // если точка в самом конце — просто убираем её
      if((pointpos>0) and (Length(M.Strings[i])=pointpos)) then
         M.Strings[i]:=StringReplace(M.Strings[i],'.','',[rfReplaceAll]);
    // меняем все оставшиеся точки на запятые
    M.Strings[i]:=StringReplace(M.Strings[i],'.',',',[rfReplaceAll]);
  end;
end;

//Достать нужную строку
function SingleString(const filename:string; stringnum: Integer):string;
var
  M:TStrings;
begin
  M:=TStringList.Create; // создали массив строк
  M.LoadFromFile(filename); // читаем файл в массив строк
  Result:=M.Strings[stringnum]; // берем нужную строку
  M.Free; // освободили массив строк
end;

//Копирование одного файла
procedure FileCopy(Const SourceFileName, TargetFileName: String);
var
  A,F : TFileStream;
begin
  A := TFileStream.Create(sourcefilename, fmOpenRead );
  try
    F := TFileStream.Create(targetfilename, fmOpenWrite or fmCreate);
    try
      F.CopyFrom(A, A.Size ) ;
      FileSetDate(F.Handle, FileGetDate(A.Handle));
    finally
      F.Free;
    end;
  finally
    A.Free;
  end;
end;

//Прочитать данные из файла SNOWDAT
procedure ReadSnowdat(const FileName: string);
  const numofvar = 2; // две переменные: Depth и Density
var
  M:TStrings;
  FullString:string;
begin
  FullString:=SingleString(FileName,1);

  FullString:=ReplaceSpaces(FullString, numofvar);

  M:=TStringList.Create;
  M.Text:=StringReplace(FullString,'_',#13#10,[rfReplaceAll]);

  ReplacePoint(M, numofvar);

  Depth:=StrToFloat(M.Strings[0]);
  Density:=StrToFloat(M.Strings[1]);

  M.Free;
end;

//Прочитать данные из файла ZONES.ARE
procedure ReadZones(const FileName: string);
  const numofvar = 3;
var
  M:TStrings;
  FullString:string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName)+'\fortfiles');

  DailyFilename:=ReplaceSpaces(SingleString(FileName, 1), 1);
  while Pos('''', DailyFilename) <> 0 do
    Delete(DailyFilename, Pos('''', DailyFilename), 1);

  FullString:=SingleString(FileName, 3);

  FullString:=ReplaceSpaces(FullString, numofvar);
  M:=TStringList.Create;
  M.Text:=StringReplace(FullString,'_',#13#10,[rfReplaceAll]);

  ReplacePoint(M, numofvar);

  Elev0:=StrToFloat(M.Strings[0]);
  ElevMax:=StrToFloat(M.Strings[1]);
  ElevStep:=StrToFloat(M.Strings[2]);

  M.Free;
end;

//Прочитать данные из файла PARAM.ARE
procedure ReadParam(const FileName: string);
  const numofvar_1 = 3;
  const numofvar_2 = 1;
var
  M:TStrings;
  FullString_1, FullString_2:string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName)+'\fortfiles');

  FullString_1:=SingleString(FileName, 2);
  FullString_2:=SingleString(FileName, 4);

  FullString_1:=ReplaceSpaces(FullString_1, numofvar_1);
  FullString_2:=ReplaceSpaces(FullString_2, numofvar_2);

  M:=TStringList.Create;
  M.Text:=StringReplace(FullString_1,'_',#13#10,[rfReplaceAll]);
  ReplacePoint(M, numofvar_1);
  NumOfDays:=StrToFloat(M.Strings[0]);
  TSforCalc:=StrToFloat(M.Strings[1]);
  TSforInp:=StrToInt(M.Strings[2]);
  M.Clear;
  M.Text:=StringReplace(FullString_2,'_',#13#10,[rfReplaceAll]);
  ReplacePoint(M, numofvar_2);
  GMELT:=StrToFloat(M.Strings[0]);
  M.Free;
end;

// Прочитать данные из файла DATAS1.ARE
procedure ReadDatas1(const FileName: string);
  const numofvar = 5; { Переменные TCR, RNEW, ESN, ULMAX0, UL0 }
var
  M:TStrings;
  FullString:string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName)+'\fortfiles');

  FullString:=SingleString(FileName, 1);
  FullString:=ReplaceSpaces(FullString, numofvar);

  M:=TStringList.Create;
  M.Text:=StringReplace(FullString,'_',#13#10,[rfReplaceAll]);
  ReplacePoint(M, numofvar);
  TCR:=StrToFloat(M.Strings[0]);
  RNEW:=StrToFloat(M.Strings[1]);
  ESN:=StrToFloat(M.Strings[2]);
  ULMAX0:=StrToFloat(M.Strings[3]);
  UL0:=StrToFloat(M.Strings[4]);

  M.Free;
end;

//Подгрузить другой SNOWDAT
procedure TMainForm.InitialOpenMenuBtnClick(Sender: TObject);
var
  FortFile:String;
begin
  FortFile:= ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT';
  if dlgOpenInitCon.Execute then
    begin
      FileInitCon:=dlgOpenInitCon.FileName;
      ReadSnowdat(FileInitCon);
      if ( FileParam <> FortFile ) then
        FileCopy(FileInitCon, FortFile );
    end;
end;

//Подгрузить другой PARAM.ARE
procedure TMainForm.ParamOpenMenuBtnClick(Sender: TObject);
var
  FortFile:String;
begin
  FortFile:= ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE';
  if dlgOpenParam.Execute then
    begin
      FileParam:=dlgOpenParam.FileName;
      ReadParam(FileParam);
      lblNumofDaysVal.Caption:=FloatToStr(NumOfDays);
      lblTSforCalcVal.Caption:=FloatToStr(TSforCalc);
      lblTSforInpVal.Caption:=FloatToStr(TSforInp);
      lblGMELTVal.Caption:=FloatToStr(GMELT);
      if ( FileParam <> FortFile ) then
        FileCopy(FileParam, FortFile );
    end;
end;

//Подгрузить другой DATAS1.ARE
procedure TMainForm.Datas1OpenMenuBtnClick(Sender: TObject);
var
  FortFile:String;
begin
  if dlgOpenDatas.Execute then
    begin
      FortFile:= ExtractFilePath(Application.ExeName)+'fortfiles\DATAS1.ARE';
      FileDatas:=dlgOpenDatas.FileName;
      ReadDatas1(FileDatas);
      lblRNEWval.Caption:=FloatToStr(RNEW);
      lblESNval.Caption:=FloatToStr(ESN);
      lblULMAXval.Caption:=FloatToStr(ULMAX0);
      lblELEV0val.Caption:=FloatToStr(Elev0);
      if ( FileDatas <> FortFile ) then
        FileCopy(FileDatas, FortFile );
    end;
end;

//Подгрузить другой ZONES.ARE
procedure TMainForm.ZonesOpenMenuBtnClick(Sender: TObject);
var
  FortFile, FileDaily, FortDaily:String;
begin
  if dlgOpenZones.Execute then
    begin
      FortFile:= ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE';
      FortDaily:= ExtractFilePath(Application.ExeName)+'fortfiles\'+ DailyFilename;
                                                    //Путь к старому файлу DailyData
      DeleteFile(FortDaily);//Удаляем старый файл DailyData
      FileZones:=dlgOpenZones.FileName;
      ReadZones(FileZones);
      FileDaily:= ExtractFilePath(FileZones)+DailyFilename;{Подставляем значение
                                                            нового имени DailyData
                                                            к пути той же папки}
      FortDaily:= ExtractFilePath(Application.ExeName)+'fortfiles\'+ DailyFilename;
                                                            {Объявляем, куда все будет
                                                            скопировано}
      if ( FileZones <> FortFile ) then
      begin
        FileCopy(FileZones, FortFile );
        FileCopy(FileDaily, FortDaily);
      end;
    end;
end;

//Открытие программы, чтение имеющихся файлов
procedure TMainForm.FormCreate(Sender: TObject);
begin //подгружаем все файлы
  ReadSnowdat(ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT');
  ReadParam(ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE');
  ReadDatas1(ExtractFilePath(Application.ExeName)+'fortfiles\DATAS1.ARE');
  ReadZones(ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE');
  btnReload.Click; //выводим обновленные переменные
end;

end.
