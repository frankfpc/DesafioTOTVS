unit BuscaCEP.model.interfaces.impl.DadosCEP;

interface

uses BuscaCEP.model.interfaces,
  REST.Client,
  REST.Types,
  System.JSON,
  Vcl.Dialogs,
  System.SysUtils;

type

  TDadosCEP = class(TInterfacedObject, IDadosCEP)
  private
    const
      APIViaCEP : String = 'https://viacep.com.br/ws/[CEP]/json';
      APICEP : String = 'https://cdn.apicep.com/file/apicep/[CEP].json';
      APIawesomeAPI : String = 'https://cep.awesomeapi.com.br/json/[CEP]';

    var
      FEndereco : String;
      FBairro : String;
      FCidade : String;
      FUF : String;
      FCEP : String;

    function SoNumeros(aDado: String): String;
    function ValidaCEP(aCEP: String): Boolean;
    function BuscaAPIViaCEP(aCEP: String): Boolean;
    function BuscaAPICEP(aCEP: String): Boolean;
    function BuscaAPIAwesomeAPI(aCEP: String): Boolean;

  public
    procedure PesquisarCEP(aCEP: String);

    procedure SetEndereco(value: String);
    function GetEndereco: String;
    procedure SetBairro(value: String);
    function GetBairro: String;
    procedure SetCidade(value: String);
    function GetCidade: String;
    procedure SetUF(value: String);
    function GetUF: String;
    procedure SetCEP(value: String);
    function GetCEP: String;
    property Endereco: String read GetEndereco write SetEndereco;
    property Bairro: String read GetBairro write SetBairro;
    property Cidade: String read GetCidade write SetCidade;
    property UF: String read GetUF write SetUF;
    property CEP: String read GetCEP write SetCEP;

  end;

implementation

{ TDadosCEP }

function TDadosCEP.BuscaAPIAwesomeAPI(aCEP: String): Boolean;
var
  RestClient : TRESTClient;
  RestRequest : TRESTRequest;
  ArrayJson : TJSONArray;
  json : String;
  StatusRetorno: Boolean;

begin
  StatusRetorno := True;

  RestClient := TRESTClient.Create(nil);
  RestRequest := TRESTRequest.Create(nil);
  RestRequest.Client := RestClient;

  try
    try
      RestClient.BaseURL := StringReplace(APIawesomeAPI, '[CEP]', aCEP, []);
      RestRequest.Execute;
    except
      StatusRetorno := False;
    end;

  finally

    if (StatusRetorno = True) and (Pos('code', RestRequest.Response.JSONText) <> 0) then
      StatusRetorno := False;

  end;

  if StatusRetorno = False then
    Result := False
  else
  begin
    json := RestRequest.Response.JSONText;

    SetEndereco( RestRequest.Response.JSONValue.FindValue('address_type').ToString.Replace('"', '') + ' ' +
                 RestRequest.Response.JSONValue.FindValue('address_name').ToString.Replace('"', ''));
    SetBairro( RestRequest.Response.JSONValue.FindValue('district').ToString.Replace('"', ''));
    SetCidade( RestRequest.Response.JSONValue.FindValue('city').ToString.Replace('"', ''));
    SetUF( RestRequest.Response.JSONValue.FindValue('state').ToString.Replace('"', ''));
    SetCEP( RestRequest.Response.JSONValue.FindValue('cep').ToString.Replace('"', ''));

    Result := True;
  end;

  ArrayJson.DisposeOf;
end;

function TDadosCEP.BuscaAPICEP(aCEP: String): Boolean;
var
  RestClient : TRESTClient;
  RestRequest : TRESTRequest;
  ArrayJson : TJSONArray;
  json : String;
  StatusRetorno: Boolean;

begin
  StatusRetorno := True;

  RestClient := TRESTClient.Create(nil);
  RestRequest := TRESTRequest.Create(nil);
  RestRequest.Client := RestClient;

  try
    try
      RestClient.BaseURL := StringReplace(APICEP, '[CEP]', Copy(aCEP, 1, 5) +'-' + Copy(aCEP, 6, 3), []);
      RestRequest.Execute;
    except
      StatusRetorno := False;
    end;

  finally

    if (StatusRetorno = True) and (Pos('code', RestRequest.Response.JSONText) <> 0) then
      StatusRetorno := False;

  end;

  if StatusRetorno = False then
    Result := False
  else
  begin
    json := RestRequest.Response.JSONText;

    SetEndereco( RestRequest.Response.JSONValue.FindValue('address').ToString.Replace('"', ''));
    SetBairro( RestRequest.Response.JSONValue.FindValue('district').ToString.Replace('"', ''));
    SetCidade( RestRequest.Response.JSONValue.FindValue('city').ToString.Replace('"', ''));
    SetUF( RestRequest.Response.JSONValue.FindValue('state').ToString.Replace('"', ''));
    SetCEP( RestRequest.Response.JSONValue.FindValue('code').ToString.Replace('"', ''));

    Result := True;
  end;

  ArrayJson.DisposeOf;
end;

function TDadosCEP.BuscaAPIViaCEP(aCEP: String): Boolean;
var
  RestClient: TRESTClient;
  RestRequest: TRESTRequest;
  ArrayJson: TJSONArray;
  json: String;
  StatusRetorno: Boolean;

begin
  StatusRetorno := True;

  RestClient := TRESTClient.Create(nil);
  RestRequest := TRESTRequest.Create(nil);
  RestRequest.Client := RestClient;

  try
    try
      RestClient.BaseURL := StringReplace(APIViaCEP, '[CEP]', aCEP, []);
      RestRequest.Execute;
    except
      StatusRetorno := False;
    end;

  finally

    if (StatusRetorno = True) and (Pos('erro', RestRequest.Response.JSONText) <> 0) then
      StatusRetorno := False;

  end;


  if StatusRetorno = False  then
    Result := False
  else
  begin
    json := RestRequest.Response.JSONText;

    SetEndereco( RestRequest.Response.JSONValue.FindValue('logradouro').ToStringReplace('"', '') );
    SetEndereco( RestRequest.Response.JSONValue.FindValue('logradouro').ToString.Replace('"', '') );
    SetBairro( RestRequest.Response.JSONValue.FindValue('bairro').ToString.Replace('"', ''));
    SetCidade( RestRequest.Response.JSONValue.FindValue('localidade').ToString.Replace('"', ''));
    SetUF( RestRequest.Response.JSONValue.FindValue('uf').ToString.Replace('"', ''));
    SetCEP( RestRequest.Response.JSONValue.FindValue('cep').ToString.Replace('"', ''));

    Result := True;
  end;

  ArrayJson.DisposeOf;

end;

function TDadosCEP.GetBairro: String;
begin
  Result := FBairro;
end;

function TDadosCEP.GetCEP: String;
begin
  Result := FCEP;
end;

function TDadosCEP.GetCidade: String;
begin
  Result := FCidade;
end;

function TDadosCEP.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TDadosCEP.GetUF: String;
begin
  Result := FUF;
end;

procedure TDadosCEP.PesquisarCEP(aCEP: String);
var
  BuscaOk : Boolean;
  vCEP : String;

begin

  BuscaOk := False;

  if not ValidaCEP(aCEP) then
    Exit;

  vCEP := Sonumeros(aCEP);

  BuscaOk := BuscaAPIViaCEP(vCEP);

  if not BuscaOk then
    BuscaOk := BuscaAPICEP(vCEP);

  if not BuscaOk then
    BuscaOk := BuscaAPIawesomeAPI(vCEP);

  if not BuscaOk then
    ShowMessage('Não foi possível localizar o CEP informado!');

end;

procedure TDadosCEP.SetBairro(value: String);
begin
  FBairro := value;
end;

procedure TDadosCEP.SetCEP(value: String);
begin
  FCEP := value;
end;

procedure TDadosCEP.SetCidade(value: String);
begin
  FCidade := value;
end;

procedure TDadosCEP.SetEndereco(value: String);
begin
  FEndereco := value;
end;

procedure TDadosCEP.SetUF(value: String);
begin
  FUF := value;
end;

function TDadosCEP.SoNumeros(aDado: String): String;
var
  S : String;
begin
  S := '';
  For var I: Integer := 1 To Length(aDado) Do
    If (aDado[I] In ['0' .. '9']) Then
      S := S + aDado[I];
  Result := S
end;

function TDadosCEP.ValidaCEP(aCEP: String): Boolean;
var
  vCEP: String;
  StatusCEP : Boolean;
begin

  vCEP := SoNumeros(aCEP);

  StatusCEP := True;

  if (StatusCEP = True) and (vCEP <> aCEP) then
  begin
    ShowMessage('O CEP informado contém caracteres inválidos, corrija a informação e tente novamente.');
    StatusCEP := False;
  end;

  if (StatusCEP = True) and (Length(vCEP) < 8) then
  begin
    ShowMessage('O CEP informado está incompleto, corrija a informação e tente novamente.');
    StatusCEP := False;
  end;

  if (StatusCEP = True) and (Length(vCEP) > 8) then
  begin
    ShowMessage('O CEP informado está contém números a mais, corrija a informação e tente novamente.');
    StatusCEP := False;
  end;

  Result := StatusCEP;
end;

end.
