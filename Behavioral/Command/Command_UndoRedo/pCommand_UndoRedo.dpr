program pCommand_UndoRedo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UCommand in 'UCommand.pas';


var
  Reciever : TReciever;
  Invoker : TInvoker;

begin
  try

    Reciever := TReciever.Create;
    try
      Invoker := TInvoker.Create;
      try
        // .. prida 5 (0+5=5)
        invoker.ExecuteCommand(TAddCommand.Create(Reciever, 5));
        Writeln(Reciever.Value);    //Output: 5

        // .. odecte 2 (5-2=3)
        Invoker.ExecuteCommand(TSubstractCommand.Create(Reciever, 2));
        Writeln(Reciever.Value);  //Output: 3

        // .. undo vrati na 5  (3+2=5)
        Invoker.Undo;
        WriteLn(Reciever.Value);

        // .. redo zase odecte na 3  (5-2=3)
        Invoker.Redo;
        WriteLn(Reciever.Value);

      finally
        FreeAndNil(Invoker);
      end;
    finally
      FreeAndNil(Reciever);
    end;

    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
