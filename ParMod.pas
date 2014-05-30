unit ParMod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TModParam = class(TForm)
    edtGMELT: TEdit;
    edtRNEW: TEdit;
    edtESN: TEdit;
    edtULMAX: TEdit;
    lblGMELT: TLabel;
    lbl: TLabel;
    lbESN: TLabel;
    lbULMAX: TLabel;
    edtELEV0: TEdit;
    lblELEV0: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    lblGcm: TLabel;
    lblMeter: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModParam: TModParam;

implementation

{$R *.dfm}

uses Main;

procedure TModParam.btnCancelClick(Sender: TObject);
begin
  ModParam.Close;
end;

procedure TModParam.btnOKClick(Sender: TObject);
var
  F: TFileStream;
  M: TStrings;
begin
  // Меняем точки на запятые
  edtGMELT.Text:=StringReplace(edtGMELT.Text,'.',',',[rfReplaceAll]);
  edtRNEW.Text:=StringReplace(edtRNEW.Text,'.',',',[rfReplaceAll]);
  edtESN.Text:=StringReplace(edtESN.Text,'.',',',[rfReplaceAll]);
  edtULMAX.Text:=StringReplace(edtULMAX.Text,'.',',',[rfReplaceAll]);
  edtELEV0.Text:=StringReplace(edtELEV0.Text,'.',',',[rfReplaceAll]);

  //Меняем значения в основеном модуле
  Main.GMELT:=StrToFloat(edtGMELT.Text);
  Main.RNEW:=StrToFloat(edtRNEW.Text);
  Main.ESN:=StrToFloat(edtESN.Text);
  Main.ULMAX0:=StrToFloat(edtULMAX.Text);
  Main.Elev0:=StrToFloat(edtELEV0.Text);

  ModParam.Close;
end;

procedure TModParam.FormShow(Sender: TObject);
begin
  edtGMELT.Text:=FloatToStr(Main.GMELT);
  edtRNEW.Text:=FloatToStr(Main.RNEW);
  edtESN.Text:=FloatToStr(Main.ESN);
  edtULMAX.Text:=FloatToStr(Main.ULMAX0);
  edtELEV0.Text:=FloatToStr(Main.Elev0);
end;

end.
