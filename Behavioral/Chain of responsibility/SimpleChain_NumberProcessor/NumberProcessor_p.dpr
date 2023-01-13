program NumberProcessor_p;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UCORPattern in 'UCORPattern.pas';

var
  Chain : TChain;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Chain := TChain.Create;
    Chain.Process(-10);
    Chain.Process(0);
    Chain.Process(5);
    Chain.Process(28);

    Readln();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
