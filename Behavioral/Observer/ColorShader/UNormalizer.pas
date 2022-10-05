unit UNormalizer;

interface
//+-----------------------------------------------------------------------------
// .. Normalization process

//                  X - min(X)
//   (B - A) * -------------------- + A
//               max(X) - min(X)

// X - vybrana hodnota pro normalizaci
// [min(X), max(X)] - interval, ze ktereho je hodnota X vybirana
// [A, B] - interval do ktereho se prenasi normalizace

// Priklad
// Mam interval od 1 do 3
// Hodnota X pro normalizaci = 2
// Normalizace vyjde 0,5 (tato hodnota je vzdy od 0 do 1).. lze to nazvat pomerem ci procentualnim narustem
// .. ve vzorecku je to ta zlomkova cast
// pokud budeme chtit prevest do intervalu napr. od 10 do 20 pocitame ve vzorecku take s promennymi A a B...
// tato hodnota je: (20-10) * 0,5 + 10 = 15
//+-----------------------------------------------------------------------------
type
  TNormalizer = class
  private
    B, A, minX, maxX : double;
    FTransformInterval : boolean;
  public
    constructor Create; overload;
    constructor Create(aMinX, aMaxX : double); overload;
    constructor Create(aMinX, aMaxX, ATransMin, ATransMax : double); overload;
  public
    ///  <summary>Nastavi interval pro vypocet normalizovane hodnoty</summary>
    ///  <param name = "AStart">Pocatek intervalu</param>
    ///  <param name = "AEnd">Konec intervalu</param>
    ///  <param name = "ANormalizationInterval">Zda se jedna o prenaseny interval normalizace</param>
    procedure SetInterval(AStart, AEnd : double; ATransInterval : boolean = false); overload;
    procedure SetInterval(AStart, AEnd, ATransStart, ATransEnd : double); overload;
    function Normalize(AValue : double) : double;

    property TransformInterval : boolean read FTransformInterval write FTransformInterval;
  end;

implementation

{ Normalizer }

constructor TNormalizer.Create(aMinX, aMaxX : double);
begin
  inherited Create;
  Assert(aMinX <> aMaxX, '');
  minX := aMinX;
  maxX := aMaxX;
  FTransformInterval := false;
end;

constructor TNormalizer.Create(aMinX, aMaxX, ATransMin, ATransMax: double);
begin
  inherited Create;
  Assert(aMinX <> aMaxX, '');
  minX := aMinX;
  maxX := aMaxX;
  FTransformInterval := true;

  A := ATransMin;
  B := ATransMax;
end;

constructor TNormalizer.Create;
begin
  Create(0,1);
end;

function TNormalizer.Normalize(AValue: double) : double;
var
  X, Xnorm : double;
begin
  X := AValue;
  Xnorm := (X - minX) / (maxX - minX);

  if not FTransformInterval then
    result := Xnorm
  else
    result := (B - A) * Xnorm + A;
end;

procedure TNormalizer.SetInterval(AStart, AEnd, ATransStart, ATransEnd: double);
begin
  SetInterval(AStart, AEnd, false);
  SetInterval(ATransStart, ATransEnd, true);
end;

procedure TNormalizer.SetInterval(AStart, AEnd: double;
  ATransInterval: boolean = false);
begin
  if ATransInterval then begin
    A := AStart;
    B := AEnd;
  end
  else begin
    minX := AStart;
    maxX := AEnd;
  end;
end;

end.
