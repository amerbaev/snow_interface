unit MemoEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls;

type
  TFormEditor = class(TForm)
    MemoRed: TMemo;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEditor: TFormEditor;

implementation

uses Main;

{$R *.dfm}

procedure Daily;
begin
  FormEditor.MemoRed.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\'+Main.DailyFilename);
end;

procedure InitCon;
begin
  FormEditor.MemoRed.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT');
end;

procedure TFormEditor.FormShow(Sender: TObject);
begin
  case Main.EditFile of
    0: Daily;
    1: InitCon;
  end;
end;

procedure TFormEditor.N2Click(Sender: TObject);
begin
  case Main.EditFile of
    0: MemoRed.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+'fortfiles\'+Main.DailyFilename);
    1: MemoRed.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+'fortfiles\SNOWDAT');
  end;
end;

procedure TFormEditor.N3Click(Sender: TObject);
begin
  SaveDialog1.Execute();
  MemoRed.Lines.SaveToFile(SaveDialog1.FileName);
end;

end.
