unit UBridge;

interface

uses
  Classes, SysUtils;

type
  // Implementor
  IDrawingAPI = interface
    procedure DrawShape(x, y : integer);
  end;

  // Abstraction
  TShape = class
  private
    FDrawingAPI : IDrawingAPI;
  public
    constructor Create(ADrawingAPI : IDrawingAPI);
    procedure Draw; virtual; abstract;
    procedure Resize(APercent : double); virtual; abstract;
  end;


  TCircle = class(TShape)
  private
    FX, FY, FRadius : integer;
  public
    constructor Create(AX, AY, ARadius);
  end;

  TSquare = class(TShape)

  end;

implementation

{ TShape }

constructor TShape.Create(ADrawingAPI: IDrawingAPI);
begin
  FDrawingAPI := ADrawingAPI;
end;

{ TCircle }

constructor TCircle.Create(AX, AY, ARadius);
begin
  inherited Create;
  FX := AX;
  FY := AY;
  FRadius := ARadius;
end;

end.
