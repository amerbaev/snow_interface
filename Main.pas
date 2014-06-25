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

//Rewrite file SNOWDAT
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

//Rewrite file ZONES.ARE
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

//Rewrite file PARAM.ARE
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

//Rewrite file DATAS1.ARE
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

//Run calculation program
procedure Calculate;
begin
  ShellExecute(Application.Handle,'open','snowars.exe',nil,'...\fortfiles',SW_RESTORE);
end;

//Call for run calculation program
procedure TMainForm.btnRunClick(Sender: TObject);
begin
  Calculate;
end;

//Exit
procedure TMainForm.ExitMenuBtnClick(Sender: TObject);
begin
  MainForm.Close;
end;

//Open control parameters edit window
procedure TMainForm.ControlParEditMenuBtnClick(Sender: TObject);
begin
  ContParam.ShowModal;
  btnReload.Click;
end;

//Open model parameters edit window
procedure TMainForm.ModelParEditMenuBtnClick(Sender: TObject);
begin
  ModParam.ShowModal;
  btnReload.Click;
end;

//Show charts of results
procedure TMainForm.btnGraphClick(Sender: TObject);
begin
  Graph.ShowModal;
end;

//Open control parameters edit window
procedure TMainForm.btnInitialClick(Sender: TObject);
begin
  InitialGraph.ShowModal;
end;

//Editing of control parameters
procedure TMainForm.btnRedContrClick(Sender: TObject);
begin
  ContParam.ShowModal;
  btnReload.Click;
end;

//Open model parameters edit window
procedure TMainForm.btnRedModelClick(Sender: TObject);
begin
  ModParam.ShowModal;
  btnReload.Click;
  SnowdatRewrite;
  ZonesRewrite;
end;

//Reload all datas
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

//Read all data from SNOWDAT file
procedure ReadSnowdat(const FileName: string);
  const numofvar = 2; //Variables: Depth and Density
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

//Read all data from ZONES.ARE file
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

//Read all data from PARAM.ARE file
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

//Read all data from DATAS1.ARE file
procedure ReadDatas1(const FileName: string);
  const numofvar = 5; { variables: TCR, RNEW, ESN, ULMAX0, UL0 }
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

//Load another SNOWDAT file
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

//Load another PARAM.ARE file
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

//Load another DATAS1.ARE file
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

//Load another ZONES.ARE file
procedure TMainForm.ZonesOpenMenuBtnClick(Sender: TObject);
var
  FortFile, FileDaily, FortDaily, OldDailyFilename, OldFortDaily:String;
begin
  if dlgOpenZones.Execute then
    begin
      DailyAnswer:=False;

      FortFile:= ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE';
      FortDaily:= ExtractFilePath(Application.ExeName)+'fortfiles\'+ DailyFilename;
                                                    //Path to old DailyData file

      FileZones:=dlgOpenZones.FileName;
      OldDailyFilename:=DailyFilename;
      OldFortDaily:=FortDaily;
      ReadZones(FileZones);
      FileDaily:= ExtractFilePath(FileZones)+DailyFilename;{Substitute new name
                                          of DailyData file to ZONES file folder}
      Tools.FileCopy(FileZones, FortFile);

      //Daily file
      if FileExists(FileDaily) then
      begin
        FortDaily:= ExtractFilePath(Application.ExeName)+'fortfiles\'+ DailyFilename;
        Tools.FileCopy(FileDaily, FortDaily);
      end
      else
      begin
        if DailyAnswer then // Execute dialog
          if dlgOpenDaily.Execute then
          begin
            FileDaily:=dlgOpenDaily.FileName; // New daily
            DeleteFile(OldFortDaily);//Delete old DailyData file
            Tools.FileCopy(FileDaily, FortDaily);
            Tools.FileStringReplace(FortFile, 1, ''''+ExtractFileName(FileDaily)+'''');
          end
        else
          begin
            // Keep old file
            Tools.FileStringReplace(FortFile, 1, ''''+OldDailyFilename+'''');
            DailyFilename:=OldDailyFilename;
            FortDaily:=OldFortDaily;
          end;
      end;
    end;
end;

//Open program, read all existing files
procedure TMainForm.FormCreate(Sender: TObject);
begin //Load all files
  ReadSnowdat(ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT');
  ReadParam(ExtractFilePath(Application.ExeName)+'fortfiles\PARAM.ARE');
  ReadDatas1(ExtractFilePath(Application.ExeName)+'fortfiles\DATAS1.ARE');
  ReadZones(ExtractFilePath(Application.ExeName)+'fortfiles\ZONES.ARE');
  btnReload.Click; //Show new data
end;

end.
