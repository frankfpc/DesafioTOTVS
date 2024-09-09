program BuscaCEP;

uses
  Vcl.Forms,
  ufrmBuscaCEP in 'ufrmBuscaCEP.pas' {frmBuscaCEP},
  BuscaCEP.model.interfaces in 'Model\BuscaCEP.model.interfaces.pas',
  BuscaCEP.model.interfaces.impl.DadosCEP in 'Model\BuscaCEP.model.interfaces.impl.DadosCEP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmBuscaCEP, frmBuscaCEP);
  Application.Run;
end.
