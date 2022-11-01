program Simple_Decorator_p;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UDecorator in 'UDecorator.pas';

var
  Mess : string;
  comp : IComponent;

begin
  try
    comp := TExclamationDecorator.Create(TUppercaseDecorator.Create(THelloComponent.Create));
    Mess := comp.GetMessage;
    Writeln(Mess);

    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
