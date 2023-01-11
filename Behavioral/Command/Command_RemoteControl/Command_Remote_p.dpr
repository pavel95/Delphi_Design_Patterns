program Command_Remote_p;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UCommand in 'UCommand.pas';

var
  command : ICommand;
  television : TTelevision;
  light : TLight;
  remoteControl : TRemoteControl;

begin
  try
    // .. recievers
    light := TLight.Create;
    television := TTelevision.Create;

    // .. sender of commands
    remoteControl := TRemoteControl.Create;
    try
      remoteControl.SetCommand(TOnCommand.Create(light));
      remoteControl.PressButton;

      remoteControl.SetCommand(TPlayFilmsCommand.Create(television));
      remoteControl.PressButton;

      remoteControl.SetCommand(TOffCommand.Create(television));
      remoteControl.PressButton;

      remoteControl.SetCommand(TOffCommand.Create(light));
      remoteControl.PressButton;

      Readln;
    finally
      FreeAndNil(television);
      FreeAndNil(light);
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
