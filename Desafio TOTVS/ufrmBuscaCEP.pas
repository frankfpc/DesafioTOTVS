unit ufrmBuscaCEP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmBuscaCEP = class(TForm)
    edtCEP: TEdit;
    Label1: TLabel;
    memEndereco: TMemo;
    btnPesquisarCEP: TBitBtn;
    Label2: TLabel;
    procedure btnPesquisarCEPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBuscaCEP: TfrmBuscaCEP;

implementation

{$R *.dfm}

uses BuscaCEP.model.interfaces.impl.DadosCEP, BuscaCEP.model.interfaces;

procedure TfrmBuscaCEP.btnPesquisarCEPClick(Sender: TObject);
var
  BuscaCEP: IDadosCEP;
begin
  BuscaCEP := TDadosCEP.Create;

  if Trim(edtCEP.Text) <> '' then
  begin
    BuscaCEP.PesquisarCEP(edtCEP.Text);

    if BuscaCEP.CEP <> '' then
    begin
      memEndereco.Lines.Clear;
      memEndereco.Lines.add('Endereço: ' + BuscaCEP.Endereco);
      memEndereco.Lines.add('Bairro: ' + BuscaCEP.Bairro);
      memEndereco.Lines.add('Cidade: ' + BuscaCEP.Cidade + ' - ' + BuscaCEP.UF );
      memEndereco.Lines.add('CEP: ' + BuscaCEP.CEP);
    end;
  end
  else
  begin
    ShowMessage('CEP não informado!');
  end;
end;

end.



