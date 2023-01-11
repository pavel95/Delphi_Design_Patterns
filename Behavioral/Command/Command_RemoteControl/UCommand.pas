unit UCommand;

interface

uses
  SysUtils;

type
  // Command pattern - umoznuje oddelit logiku provadeni prikazu
  // od objektu, ktery musi prikaz provest
  // Zapouzdrujepozadavek jako objekt, tim je umozneno parametrizovat dalsi objekty ruznymi prikazy

  //  Interface for command ----------------------------------------------------
  ICommand = interface
  ['{AB25F9B2-6ADC-4D1B-BFCA-11857AB80B90}']
    procedure Execute;
  end;

  //  Sender (Invoker) ---------------------------------------------------------
  // ... spousti command
  // ... musi mit referenci na command : ICommand
  TRemoteControl = class
  private
    FCommand : ICommand;
  public
    procedure SetCommand(ACommand : ICommand);
    procedure PressButton;
  end;

  // Recievers -----------------------------------------------------------------
  // .. Prijimace pro commandy
  // .. vykonavaji akce pozadovane commandy
  TDevice = class
  protected
    FPower : boolean;
    function GetDeviceName : string; virtual; abstract;
  public
    procedure TurnOn; virtual;
    procedure TurnOff; virtual;
    property DeviceName : string read GetDeviceName;
  end;

  TLight = class(TDevice)
  protected
    function GetDeviceName : string; override;
  end;

  TTelevision = class(TDevice)
  strict private
    FChannel : integer;
  protected
    function GetDeviceName : string; override;
  public
    procedure PlayChannel(AChannel : integer);
  end;

  // Concrete commands ---------------------------------------------------------
  // .. definuji specificke akce, ktere prijimace musi vykonat
  // ... v metode execute implementace
  TOnCommand = class(TInterfacedObject, ICommand)
  strict private
    FDevice : TDevice;
  public
    constructor Create(ADevice : TDevice);
    procedure Execute;
  end;

  TOffCommand = class(TInterfacedObject, ICommand)
  strict private
    FDevice : TDevice;
  public
    constructor Create(ADevice : TDevice);
    procedure Execute;
  end;

  TPlayFilmsCommand = class(TInterfacedObject, ICommand)
  strict private
    FTelevision : TTelevision;
  public
    constructor Create(ATelevision : TTelevision);
    procedure Execute;
  end;

implementation

{ TDevice }

procedure TDevice.TurnOff;
begin
  if FPower then begin
    FPower := false;
    Writeln(GetDeviceName + ' off.');
  end;
end;

procedure TDevice.TurnOn;
begin
  if not FPower then begin
    FPower := true;
    Writeln(GetDeviceName + ' on.');
  end;
end;

{ TTelevision }

function TTelevision.GetDeviceName: string;
begin
  result := 'Television';
end;

procedure TTelevision.PlayChannel(AChannel: integer);
begin
  case AChannel of
    1 : Writeln('Playing CT1');
    2 : Writeln('Playing Discovery');
    3 : Writeln('Playing HBO');
    else Writeln('playing unknown channel');
  end;
end;

{ TLight }

function TLight.GetDeviceName: string;
begin
  result := 'Lights';
end;

{ TLightOnCommand }

constructor TOnCommand.Create(ADevice: TDevice);
begin
  inherited Create;
  FDevice := ADevice;
end;

procedure TOnCommand.Execute;
begin
  FDevice.TurnOn;
end;

{ TLightOffCommand }

constructor TOffCommand.Create(ADevice: TDevice);
begin
  inherited Create;
  FDevice := ADevice;
end;

procedure TOffCommand.Execute;
begin
  FDevice.TurnOff;
end;

{ TPlayFilms }

constructor TPlayFilmsCommand.Create(ATelevision : TTelevision);
begin
  inherited Create;
  FTelevision := ATelevision;
end;

procedure TPlayFilmsCommand.Execute;
begin
  FTelevision.TurnOn;
  FTelevision.PlayChannel(3);
end;

{ TRemoteControl }

procedure TRemoteControl.PressButton;
begin
  if FCommand <> nil then
    FCommand.Execute;
end;

procedure TRemoteControl.SetCommand(ACommand: ICommand);
begin
  FCommand := ACommand;
end;

end.
