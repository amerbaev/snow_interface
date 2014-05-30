unit ContrPar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TContParam = class(TForm)
    edtN: TEdit;
    edtTAU: TEdit;
    edtDUR: TEdit;
    lblNumOfDays: TLabel;
    lbTSforCalc: TLabel;
    lbTSforInp: TLabel;
    lbDays: TLabel;
    lbDays2: TLabel;
    lblSec: TLabel;
    btOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ContParam: TContParam;
  a:Integer;

implementation

uses
  Main;
{$R *.dfm}

procedure TContParam.btnCancelClick(Sender: TObject);
begin
  ContParam.Close;
end;

procedure TContParam.btOKClick(Sender: TObject);
begin
  edtN.Text:=StringReplace(edtN.Text,'.',',',[rfReplaceAll]);
  edtTAU.Text:=StringReplace(edtTAU.Text,'.',',',[rfReplaceAll]);
  edtDUR.Text:=StringReplace(edtDUR.Text,'.',',',[rfReplaceAll]);
  Main.NumOfDays:=StrToFloat(edtN.Text);
  Main.TSforCalc:=StrToFloat(edtTAU.Text);
  Main.TSforInp:=StrToFloat(edtDUR.Text);
  ContParam.Close;
end;

procedure TContParam.FormShow(Sender: TObject);
begin
  edtN.Text:=FloatToStr(Main.NumOfDays);
  edtTAU.Text:=FloatToStr(Main.TSforCalc);
  edtDUR.Text:=FloatToStr(Main.TSforInp);
end;

end.
