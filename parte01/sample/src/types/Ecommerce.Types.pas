unit Ecommerce.Types;

interface

type
  TCPF = record

  private
    FCPF: String;
    FArrayCPF: TArray<String>;
    FSomaDoPrimeiroDigitoVerificador: Integer;
    FSomaDoSegundoDigitoVerificador: Integer;
    FPrimeiroDigitoVerificador: Integer;
    FSegundoDigitoVerificador: Integer;

  const
    TAMANHO_MINIMO_CPF = 11;
    TAMANHO_MAXIMO_CPF = 14;
    FATOR_PRIMEIRO_DIGITO_VERIFICADOR = 11;
    FATOR_SEGUNDO_DIGITO_VERIFICADOR = 12;
    DIVISOR_DO_DIGITO = 11;
    POSICAO_PRIMEIRO_DIGITO_VERIFICADOR = 9;
    POSICAO_SEGUNDO_DIGITO_VERIFICADOR = 10;
    procedure CalcularSomaDoPrimeiroDigitoVerificador;
    procedure CalcularSomaDoSegundoDigitoVerificador;
    function CalcularDigitoVerificador(AValue: Integer): Integer;
    function GetTamanhoCPF(AValue: String): Integer;
    function GetPosicaoStringAjustada(AContador: Integer): Integer;
    function RemoverCaracteres: String;
    function Split(AValue: String): TArray<String>;
  public
    class operator Implicit(AValue: String): TCPF;
    function Validar: Boolean;
  end;

implementation

uses
  System.Types,
  System.Math,
  System.Sysutils;
{ TCPF }

function TCPF.CalcularDigitoVerificador(AValue: Integer): Integer;
var
  LRestoDaDivisao: Integer;
begin
  LRestoDaDivisao := AValue mod DIVISOR_DO_DIGITO;
  if LRestoDaDivisao < 2 then
  begin
    Result := 0;
    Exit;
  end;
  Result := DIVISOR_DO_DIGITO - LRestoDaDivisao;
end;

procedure TCPF.CalcularSomaDoPrimeiroDigitoVerificador;
var
  I: Integer;
  LDigitoCPF: Integer;
begin
  try
    for I := 0 to High(FArrayCPF) - 2 do
    begin
      LDigitoCPF := StrToInt(FArrayCPF[I]);
      FSomaDoPrimeiroDigitoVerificador := FSomaDoPrimeiroDigitoVerificador +
        ((FATOR_PRIMEIRO_DIGITO_VERIFICADOR - GetPosicaoStringAjustada(I)) *
        LDigitoCPF);
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create
        ('Erro ao calcular soma do primeiro dígito verificador');
    end;
  end;

end;

procedure TCPF.CalcularSomaDoSegundoDigitoVerificador;
var
  I: Integer;
  LDigitoCPF: Integer;
begin
  try
    for I := 0 to High(FArrayCPF) - 2 do
    begin
      LDigitoCPF := StrToInt(FArrayCPF[I]);
      FSomaDoSegundoDigitoVerificador := FSomaDoSegundoDigitoVerificador +
        ((FATOR_SEGUNDO_DIGITO_VERIFICADOR - GetPosicaoStringAjustada(I)) *
        LDigitoCPF);
    end;
    FSomaDoSegundoDigitoVerificador := FSomaDoSegundoDigitoVerificador +
      (FPrimeiroDigitoVerificador * 2);
  except
    on E: Exception do
    begin
      raise Exception.Create
        ('Erro ao calcular soma do segundo dígito verificador');
    end;
  end;
end;

function TCPF.GetPosicaoStringAjustada(AContador: Integer): Integer;
begin
  Result := AContador + 1;
end;

function TCPF.GetTamanhoCPF(AValue: String): Integer;
begin
  Result := Length(AValue);
end;

class operator TCPF.Implicit(AValue: String): TCPF;
var
  LTamanho: Integer;
begin
  if AValue.IsEmpty then
    raise Exception.Create('O CPF não pode ser vazio');
  LTamanho := Length(AValue);
  if not((CompareValue(LTamanho, TAMANHO_MINIMO_CPF) >= EqualsValue) or
    (CompareValue(LTamanho, TAMANHO_MAXIMO_CPF) <= LessThanValue)) then
    raise Exception.Create('O tamanho do CPF não é válido');
  Result.FCPF := AValue.Replace(' ', EmptyStr);
end;

function TCPF.RemoverCaracteres: String;
begin
  Result := FCPF.Replace('.', EmptyStr).Replace('-', EmptyStr);
end;

function TCPF.Split(AValue: String): TArray<String>;
var
  LArray: TArray<String>;
  I: Integer;
begin
  try
    LArray := TArray<String>.Create(EmptyStr);
    SetLength(LArray, GetTamanhoCPF(AValue));
    for I := 0 to GetTamanhoCPF(AValue) - 1 do
    begin
      LArray[I] := AValue[GetPosicaoStringAjustada(I)];
    end;
    Result := LArray;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao fazer split do CPF');
    end;
  end;
end;

function TCPF.Validar: Boolean;
begin
  try
    FArrayCPF := Split(RemoverCaracteres);
    CalcularSomaDoPrimeiroDigitoVerificador;
    FPrimeiroDigitoVerificador := CalcularDigitoVerificador
      (FSomaDoPrimeiroDigitoVerificador);
    CalcularSomaDoSegundoDigitoVerificador;
    FSegundoDigitoVerificador := CalcularDigitoVerificador
      (FSomaDoSegundoDigitoVerificador);
    Result := ((FArrayCPF[POSICAO_PRIMEIRO_DIGITO_VERIFICADOR]
      .ToInteger = FPrimeiroDigitoVerificador) and
      (FArrayCPF[POSICAO_SEGUNDO_DIGITO_VERIFICADOR]
      .ToInteger = FSegundoDigitoVerificador));
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao validar o CPF');
    end;
  end; 
end;

end.
