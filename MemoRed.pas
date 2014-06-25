unit MemoRed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TRedact = class(TForm)
    MainMenuRed: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Label1: TLabel;
    MemoRed: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Redact: TRedact;

implementation

{$R *.dfm}

end.
