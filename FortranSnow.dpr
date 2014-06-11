program FortranSnow;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  ContrPar in 'ContrPar.pas' {ContParam},
  ParMod in 'ParMod.pas' {ModParam},
  GraphView in 'GraphView.pas' {Graph},
  GraphInit in 'GraphInit.pas' {InitialGraph},
  ToolsUnit in 'ToolsUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TContParam, ContParam);
  Application.CreateForm(TModParam, ModParam);
  Application.CreateForm(TGraph, Graph);
  Application.CreateForm(TInitialGraph, InitialGraph);
  Application.Run;
end.
