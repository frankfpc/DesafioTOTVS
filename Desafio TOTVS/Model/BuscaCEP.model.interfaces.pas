unit BuscaCEP.model.interfaces;

interface

type
  IDadosCep = Interface
    ['{6EDD430D-F9F9-40FA-987F-818087947AC4}']
    procedure PesquisarCEP(aCEP : String);

    procedure SetEndereco(value : String);
    function GetEndereco : String;
    procedure SetBairro(value : String);
    function GetBairro : String;
    procedure SetCidade(value : String);
    function GetCidade : String;
    procedure SetUF(value : String);
    function GetUF : String;
    procedure SetCEP(value : String);
    function GetCEP : String;
    property Endereco: String read GetEndereco write SetEndereco;
    property Bairro: String read GetBairro write SetBairro;
    property Cidade: String read GetCidade write SetCidade;
    property UF: String read GetUF write SetUF;
    property CEP: String read GetCEP write SetCEP;

  End;

implementation

end.
