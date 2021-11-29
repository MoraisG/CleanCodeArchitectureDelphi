unit Tests.Pessoa;

interface

uses
  DTO.Pessoa,
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestPessoa = class(TObject)
  private
    FPessoa: TPessoa;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    [TestCase(' Verificar se o CPF é válido', '111.111.111-11')]
    [TestCase(' Verificar se o CPF é válido', '935.411.347-80')]
    procedure CPFValido(ACPF: String);
    [Test]
    [TestCase(' Verificar se o CPF é válido', '111.444.777-05')]
    [TestCase(' Verificar se o CPF é válido', '123.456.789-99')]
    procedure CPFInvalido(AValue: String);
    procedure VerificarPedidoComCumpomDeDesconto;
    procedure VerificarPedidoMinimo;
  end;

implementation

uses
  System.SysUtils,
  System.Classes;

procedure TTestPessoa.Setup;
begin
  FPessoa := TPessoa.Create;
end;

procedure TTestPessoa.TearDown;
begin
  FPessoa.Free;
end;

procedure TTestPessoa.CPFInvalido(AValue: String);
begin
  FPessoa.CPF := AValue;
  Assert.IsFalse(FPessoa.CPF.Validar);
end;

procedure TTestPessoa.CPFValido(ACPF: String);
begin
  FPessoa.CPF := ACPF;
  Assert.IsTrue(FPessoa.CPF.Validar);
end;

procedure TTestPessoa.VerificarPedidoComCumpomDeDesconto;
begin

end;

procedure TTestPessoa.VerificarPedidoMinimo;
begin

end;

initialization

TDUnitX.RegisterTestFixture(TTestPessoa);

end.
