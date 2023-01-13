program ChatRoom_p;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UMediator in 'UMediator.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
