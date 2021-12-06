program ccatParte01;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  DTO.Pessoa in 'src\dto\DTO.Pessoa.pas',
  Types.CPF in 'src\types\Types.CPF.pas';

Var
  LPessoa: TPessoa;
  LCPF : String;
begin
  LPessoa := TPessoa.Create;
  try
    try
      Writeln('Digite o CPF por favor.');
      Readln(LCPF);
      LPessoa.CPF := LCPF;
      Writeln(LPessoa.CPF.Validar.ToString);
      Readln;
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
  finally
    LPessoa.Free;
  end;

end.
