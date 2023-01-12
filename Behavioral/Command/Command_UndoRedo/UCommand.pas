unit UCommand;

interface

uses
  Classes, System.Generics.Collections, SysUtils;

type
  // Rozhrani pro command ------------------------------------------------------
  ICommand = interface
    procedure Execute;
    procedure Undo;
  end;

  // Reciever - objekt ktery vykonava prikazy ----------------------------------
  TReciever = class
  private
    FValue : integer;
  public
    procedure Add(AValue : integer);
    procedure Subtract(AValue : integer);

    property Value : integer read FValue write FValue;
  end;

  // Invoker -zodpovedny za manipulaci s prikazy, undo redo---------------------
  TInvoker = class
  private
    // .. list vykonanych prikazu
    FCommands : TList<ICommand>;
    // .. index aktualniho commandu
    FCurrent : integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ExecuteCommand(ACommand : ICommand);
    procedure Undo;
    procedure Redo;
  end;

  TAddCommand = class(TInterfacedObject, ICommand)
  private
    FReciever : TReciever;
    FValue : integer;
  public
    constructor Create(AReciever : TReciever; ANumber : integer);
    procedure Execute;
    procedure Undo;
  end;

  TSubstractCommand = class(TInterfacedObject, ICommand)
  private
    FReciever : TReciever;
    FValue : integer;
  public
    constructor Create(AReciever  : TReciever; ANumber : integer);
    procedure Execute;
    procedure Undo;
  end;

implementation

{ TInvoker }

constructor TInvoker.Create;
begin
  inherited Create;
  FCommands := TList<ICommand>.Create;
  FCurrent := -1;
end;

destructor TInvoker.Destroy;
begin
  FreeAndNil(FCommands);
  inherited;
end;

procedure TInvoker.ExecuteCommand(ACommand: ICommand);
begin
  ACommand.Execute;
  FCommands.Add(ACommand);
  Inc(FCurrent);
end;

procedure TInvoker.Redo;
begin
  if FCurrent < FCommands.Count - 1 then
  begin
    // .. Pri redo volame command o jeden index vis, takze nejdrive index inkrementujeme
    // .. Kdybychom volali prikaz na aktualnim indexu, nechovalo by se redo podle ocekavani
    // .. Ex: 0 + 50 - 10 = 40
    // .. undo -> redo -> by melo byt zase 40
    // ..     undo: + 10, redo: !+50! ..  my ale potrebujeme redo prikazu -10
    Inc(FCurrent);
    FCommands[FCurrent].Execute;

  end else
    raise Exception.Create('Cannot redo: Current command is the last one.');
end;

procedure TInvoker.Undo;
begin
  if FCurrent > 0 then
  begin
    FCommands[FCurrent].Undo;
    Dec(FCurrent);
  end else
    raise Exception.Create('Cannot undo: Current command is the first one.');
end;

{ TAddCommand }

constructor TAddCommand.Create(AReciever: TReciever; ANumber: integer);
begin
  inherited Create;
  FReciever := AReciever;
  FValue := ANumber;
end;

procedure TAddCommand.Execute;
begin
  FReciever.Add(FValue);
end;

procedure TAddCommand.Undo;
begin
  FReciever.Subtract(FValue);
end;

{ TSubstractCommand }

constructor TSubstractCommand.Create(AReciever: TReciever; ANumber: integer);
begin
  inherited Create;
  FReciever := AReciever;
  FValue := ANumber;
end;

procedure TSubstractCommand.Execute;
begin
  FReciever.Subtract(FValue);
end;

procedure TSubstractCommand.Undo;
begin
  FReciever.Add(FValue);
end;

{ TReciever }

procedure TReciever.Add(AValue: integer);
begin
  FValue := FValue + AValue;
end;

procedure TReciever.Subtract(AValue: integer);
begin
  FValue := FValue - AValue;
end;

end.
