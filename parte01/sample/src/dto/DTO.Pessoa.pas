unit DTO.Pessoa;

interface

uses Types.CPF;

type
  TPessoa = class
  private
    FNome: String;
    FEndereco: String;
    FCPF: TCPF;
    function GetNome: String;
    procedure SetNome(const Value: String);
    procedure SetEndereco(const Value: String);
    function GetEndereco: String;
    procedure SetCPF(const Value: TCPF);
    function GetCPF: TCPF;
  public
    property Nome: String read GetNome write SetNome;
    property Endereco: String read GetEndereco write SetEndereco;
    property CPF: TCPF read GetCPF write SetCPF;
  end;

implementation

{ TPessoa }

function TPessoa.GetCPF: TCPF;
begin
  Result := FCPF;
end;

function TPessoa.GetEndereco: String;
begin
  Result := FEndereco;
end;

function TPessoa.GetNome: String;
begin
  Result := FNome;
end;

procedure TPessoa.SetCPF(const Value: TCPF);
begin
  FCPF := Value;
end;

procedure TPessoa.SetEndereco(const Value: String);
begin
  FEndereco := Value;
end;

procedure TPessoa.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
