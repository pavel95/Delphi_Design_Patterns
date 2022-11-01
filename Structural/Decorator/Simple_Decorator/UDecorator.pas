unit UDecorator;

interface

uses
  SysUtils;

type
  IComponent = interface
  ['{F6EAEB73-82ED-4946-951D-5400CF791A47}']

    function GetMessage : string;
  end;

  THelloComponent = class(TInterfacedObject, IComponent)
  public
    function GetMessage : string; virtual;
  end;

  TBaseDecorator = class(TInterfacedObject, IComponent)
  strict private
    FComponent : IComponent;
  public
    constructor Create(AComponent : IComponent);
    function GetMessage : string; virtual;
  end;

  TUpperCaseDecorator = class(TBaseDecorator)
  public
    function GetMessage : string; override;
  end;

  TExclamationDecorator = class(TBaseDecorator)
  public
    function GetMessage : string; override;
  end;

implementation

{ THelloComponent }

function THelloComponent.GetMessage: string;
begin
  result := 'Hello world';
end;

{ TBaseDecorator }

constructor TBaseDecorator.Create(AComponent: IComponent);
begin
  inherited Create;
  FComponent := AComponent;
end;

function TBaseDecorator.GetMessage: string;
begin
  result := FComponent.GetMessage;
end;

{ TUpperCaseDecorator }

function TUpperCaseDecorator.GetMessage: string;
begin
  result := UpperCase(inherited GetMessage);
end;

{ TExclamationDecorator }

function TExclamationDecorator.GetMessage: string;
begin
  result := inherited GetMessage + '!';
end;

end.
