unit DailyQuestion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormQuest = class(TForm)
    Locate: TButton;
    Old: TButton;
    procedure LocateClick(Sender: TObject);
    procedure OldClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormQuest: TFormQuest;
  Answer: Boolean;

implementation

uses Main;

{$R *.dfm}

// Locate new daily file
procedure TFormQuest.LocateClick(Sender: TObject);
begin
  Main.DailyAnswer:=True;
  FormQuest.Close;
end;

// Keep old daily file
procedure TFormQuest.OldClick(Sender: TObject);
begin
  Main.DailyAnswer:=False;
  FormQuest.Close;
end;

end.
