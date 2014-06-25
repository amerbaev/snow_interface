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
    procedure DailyEditMenuBtnClick(Sender: TObject);
    procedure InitConEditMenuBtnClick(Sender: TObject);
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
  DailyAnswer: Boolean;
  EditFile: Integer;

implementation

uses ContrPar, ParMod, GraphView, GraphInit, ToolsUnit, DailyQuestion, MemoEdit;

{$R *.dfm}

var
  Tools: ToolsUnit.TTools;

//Перезаписать файл SNOWDAT
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

//Перезаписать файл ZONES.ARE
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

//Перезаписать файл PARAM.ARE
procedure ParamRewrite;
var
  M:TStrings;
begin
  M:=TStringList.Create;
  M.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE');
  M.Strings[2]:=FloatToStr(NumOfDays)+' '+FloatToStr(TSforCalc)+' '
                                                          +FloatToStr(TSforInp);
  M.Strings[4]:=FloatToStr(GMELT);
  M.SaveToFile(ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE');
  M.Free;
end;

//Перезаписать файл DATAS1.ARE
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
  ShellExecute(Application.Handle,'open','snowars.exe',nil,'...\fortfiles',SW_RESTORE);
end;

//Вызов для запуска программы расчета
procedure TMainForm.btnRunClick(Sender: TObject);
begin
  Calculate;
end;

//Выход из программы
procedure TMainForm.ExitMenuBtnClick(Sender: TObject);
begin
  MainForm.Close;
end;

//Открытие окна редактирования управляющих параметров
procedure TMainForm.ControlParEditMenuBtnClick(Sender: TObject);
begin
  ContParam.ShowModal;
  btnReload.Click;
end;

//Открытие окна редактирования параметров модели
procedure TMainForm.ModelParEditMenuBtnClick(Sender: TObject);
begin
  ModParam.ShowModal;
  btnReload.Click;
end;

//Показать графики результатов вычислений
procedure TMainForm.btnGraphClick(Sender: TObject);
begin
  Graph.ShowModal;
end;

//Показать графики начальных параметров
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

//Редактирование параметров модели
procedure TMainForm.btnRedModelClick(Sender: TObject);
begin
  ModParam.ShowModal;
  btnReload.Click;
  SnowdatRewrite;
  ZonesRewrite;
end;

//Перезагрузить все данные
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

//Прочитать все данные из файла SNOWDAT
procedure ReadSnowdat(const FileName: string);
  const numofvar = 2; //Переменные: Depth and Density
var
  M:TStrings;
  FullString:string;
begin
  FullString:=Tools.SingleString(FileName,1);

  FullString:=Tools.ReplaceSpaces(FullString, numofvar);

  M:=TStringList.Create;
  M.Text:=StringReplace(FullString,'_',#13#10,[rfReplaceAll]);

  Tools.ReplacePoint(M, numofvar);

  Depth:=StrToFloat(M.Strings[0]);
  Density:=StrToFloat(M.Strings[1]);

  M.Free;
end;

//Прочитать все данные из файла ZONES.ARE
procedure ReadZones(const FileName: string);
  const numofvar = 3;
var
  M:TStrings;
  FullString:string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName)+'\fortfiles');

  DailyFilename:=Tools.ReplaceSpaces(Tools.SingleString(FileName, 1), 1);
  while Pos('''', DailyFilename) <> 0 do
    Delete(DailyFilename, Pos('''', DailyFilename), 1);

  FullString:=Tools.SingleString(FileName, 3);

  FullString:=Tools.ReplaceSpaces(FullString, numofvar);
  M:=TStringList.Create;
  M.Text:=StringReplace(FullString,'_',#13#10,[rfReplaceAll]);

  Tools.ReplacePoint(M, numofvar);

  Elev0:=StrToFloat(M.Strings[0]);
  ElevMax:=StrToFloat(M.Strings[1]);
  ElevStep:=StrToFloat(M.Strings[2]);

  M.Free;
end;

//Прочитать все данные из файла PARAM.ARE
procedure ReadParam(const FileName: string);
  const numofvar_1 = 3;
  const numofvar_2 = 1;
var
  M:TStrings;
  FullString_1, FullString_2:string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName)+'\fortfiles');

  FullString_1:=Tools.SingleString(FileName, 2);
  FullString_2:=Tools.SingleString(FileName, 4);

  FullString_1:=Tools.ReplaceSpaces(FullString_1, numofvar_1);
  FullString_2:=Tools.ReplaceSpaces(FullString_2, numofvar_2);

  M:=TStringList.Create;
  M.Text:=StringReplace(FullString_1,'_',#13#10,[rfReplaceAll]);
  Tools.ReplacePoint(M, numofvar_1);
  NumOfDays:=StrToFloat(M.Strings[0]);
  TSforCalc:=StrToFloat(M.Strings[1]);
  TSforInp:=StrToInt(M.Strings[2]);
  M.Clear;
  M.Text:=StringReplace(FullString_2,'_',#13#10,[rfReplaceAll]);
  Tools.ReplacePoint(M, numofvar_2);
  GMELT:=StrToFloat(M.Strings[0]);
  M.Free;
end;

//Прочитать все данные из файла DATAS1.ARE
procedure ReadDatas1(const FileName: string);
  const numofvar = 5; { Переменные: TCR, RNEW, ESN, ULMAX0, UL0 }
var
  M:TStrings;
  FullString:string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName)+'\fortfiles');

  FullString:=Tools.SingleString(FileName, 1);
  FullString:=Tools.ReplaceSpaces(FullString, numofvar);

  M:=TStringList.Create;
  M.Text:=StringReplace(FullString,'_',#13#10,[rfReplaceAll]);
  Tools.ReplacePoint(M, numofvar);
  TCR:=StrToFloat(M.Strings[0]);
  RNEW:=StrToFloat(M.Strings[1]);
  ESN:=StrToFloat(M.Strings[2]);
  ULMAX0:=StrToFloat(M.Strings[3]);
  UL0:=StrToFloat(M.Strings[4]);

  M.Free;
end;

//Загрузить другой файл SNOWDAT
procedure TMainForm.InitConEditMenuBtnClick(Sender: TObject);
begin
  EditFile:=1;
  FormEditor.ShowModal;
end;

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
        Tools.FileCopy(FileInitCon, FortFile );
    end;
end;

//Загрузить другой файл PARAM.ARE
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
        Tools.FileCopy(FileParam, FortFile );
    end;
end;

procedure TMainForm.DailyEditMenuBtnClick(Sender: TObject);
begin
  EditFile:=0;
  FormEditor.ShowModal;
end;

//Загрузить другой файл DATAS1.ARE
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
        Tools.FileCopy(FileDatas, FortFile );
    end;
end;

//Загрузить другой файл ZONES.ARE
procedure TMainForm.ZonesOpenMenuBtnClick(Sender: TObject);
var
  FortFile, FileDaily, FortDaily, OldDailyFilename, OldFortDaily:String;
begin
  if dlgOpenZones.Execute then
    begin
      DailyAnswer:=False;

      FortFile:= ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE';
      FortDaily:= ExtractFilePath(Application.ExeName)+'fortfiles\'+ DailyFilename;
                                                //Путь к старому файлу DailyData

      FileZones:=dlgOpenZones.FileName;
      OldDailyFilename:=DailyFilename;
      OldFortDaily:=FortDaily;
      ReadZones(FileZones);
      FileDaily:= ExtractFilePath(FileZones)+DailyFilename;{Совмещаем новое имя
                                      файла DailyData c директорией файла ZONES}
      Tools.FileCopy(FileZones, FortFile);

      //Daily file
      if FileExists(FileDaily) then
      begin
        FortDaily:= ExtractFilePath(Application.ExeName)+'fortfiles\'+ DailyFilename;
        Tools.FileCopy(FileDaily, FortDaily);
      end
      else
      begin
        if DailyAnswer then // Вызвов диалога
          if dlgOpenDaily.Execute then
          begin
            FileDaily:=dlgOpenDaily.FileName; // Новый Daily
            DeleteFile(OldFortDaily);//Удалить старый файл DailyData
            Tools.FileCopy(FileDaily, FortDaily);
            Tools.FileStringReplace(FortFile, 1, ''''+ExtractFileName(FileDaily)+'''');
          end
        else
          begin
            // Оставить старый файл
            Tools.FileStringReplace(FortFile, 1, ''''+OldDailyFilename+'''');
            DailyFilename:=OldDailyFilename;
            FortDaily:=OldFortDaily;
          end;
      end;
    end;
end;

//Открытие программы, чтение всех имеющихся файлов
procedure TMainForm.FormCreate(Sender: TObject);
begin //Подгрузить все файлы
  ReadSnowdat(ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT');
  ReadParam(ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE');
  ReadDatas1(ExtractFilePath(Application.ExeName)+'fortfiles\DATAS1.ARE');
  ReadZones(ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE');
  btnReload.Click; //Показать вс данные
end;

end.
