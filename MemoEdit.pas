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
    procedure MemoRedKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N5Click(Sender: TObject);
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

// Save on exit
procedure Exit;
begin
  case MessageBox(0, 'Сохранить изменения?', 'Выход', MB_YESNO) of
    IDYES: FormEditor.N2.Click;
  end;
end;

procedure TFormEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Exit;
end;

//Load file
procedure TFormEditor.FormShow(Sender: TObject);
begin
  case Main.EditFile of
    // Daily
    0: FormEditor.MemoRed.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)
                                              +'fortfiles\'+Main.DailyFilename);
    // Init
    1: FormEditor.MemoRed.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)
                                                          +'fortfiles\SNOWDAT');
  end;
end;

// Save on Ctrl+S
procedure TFormEditor.MemoRedKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = Ord('S')) and (ssCtrl in Shift) then
  begin
    FormEditor.N2.Click;
  end;
end;

// File-Save
procedure TFormEditor.N2Click(Sender: TObject);
begin
  case Main.EditFile of
    // Daily
    0: MemoRed.Lines.SaveToFile(ExtractFilePath(Application.ExeName)
                                              +'fortfiles\'+Main.DailyFilename);
    // Init
    1: MemoRed.Lines.SaveToFile(ExtractFilePath(Application.ExeName)
                                                          +'fortfiles\SNOWDAT');
  end;
end;

// File-Save as
procedure TFormEditor.N3Click(Sender: TObject);
begin
  SaveDialog1.Execute();
  MemoRed.Lines.SaveToFile(SaveDialog1.FileName);
end;

// File-Exit
procedure TFormEditor.N5Click(Sender: TObject);
begin
  Exit;
end;

end.
