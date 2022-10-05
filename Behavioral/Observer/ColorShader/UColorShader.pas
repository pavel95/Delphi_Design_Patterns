unit UColorShader;

interface

uses
  Classes, SysUtils, Vcl.Graphics, Winapi.Windows,
  UNormalizer;



type
  TColorShader = class
  private
    // .. Vychozi barva
    R1, G1, B1 : byte;
    // Vysledna barva pri 100% volume
    R2, G2, B2 : byte;

    FMinVolume : double;
    FMaxVolume : double;
    FVolume : double;

    RNorm : TNormalizer;
    GNorm : TNormalizer;
    BNorm : TNormalizer;

    procedure RGBFromCol(ACol : TColor; out R, G, B : byte);
    procedure UpdateColInterval;
  public
    constructor Create;
    destructor Destroy; override;



    procedure SetCol1(ACol : TColor); overload;
    procedure SetCol2(ACol : TColor); overload;
    procedure SetCols(ACol1, ACol2 : TColor); overload;

    procedure SetCol1(R, G, B : byte); overload;
    procedure SetCol2(R, G, B : byte); overload;
    procedure SetCols(AR1, AG1, AB1, AR2, AG2, AB2 : byte); overload;

    procedure SetMaxVolume(AValue : double);
    procedure SetMinVolume(AValue : double);
    procedure SetVolumeInterval(AStart, AEnd : double);

    procedure MakeShade(AVolume : double; out R, G, B : byte); overload;
    function MakeShade(AVolume : double) : TColor; overload;

    property MinVolume : double read FMinVolume write SetMinVolume;
    property MaxVolume : double read FMaxVolume write SetMaxVolume;
    property Volume : double read FVolume write FVolume;
  end;

implementation

{ TColorShader }

constructor TColorShader.Create;
begin
  RNorm := TNormalizer.Create;
  GNorm := TNormalizer.Create;
  BNorm := TNormalizer.Create;

  RNorm.TransformInterval := true;
  GNorm.TransformInterval := true;
  BNorm.TransformInterval := true;
end;

destructor TColorShader.Destroy;
begin
  FreeAndNil(RNorm);
  FreeAndNil(GNorm);
  FreeAndNil(BNorm);
  inherited;
end;

function TColorShader.MakeShade(AVolume: double): TColor;
var
  R, G, B : byte;
begin
  MakeShade(AVolume, R, G, B);
  result := RGB(R, G, B);
end;

procedure TColorShader.MakeShade(AVolume : double; out R, G, B : byte);
begin
  R := Trunc(RNorm.Normalize(AVolume));
  G := Trunc(GNorm.Normalize(AVolume));
  B := Trunc(BNorm.Normalize(AVolume));
end;

procedure TColorShader.RGBFromCol(ACol : TColor; out R, G, B: byte);
var
  tmpRGB : integer;
begin
  tmpRGB := ColorToRGB(ACol);
  R := GetRValue(tmpRGB);
  G := GetGValue(tmpRGB);
  B := GetBValue(tmpRGB);
end;

procedure TColorShader.SetCol1(ACol: TColor);
begin
  RGBFromCol(ACol, R1, G1, B1);
  UpdateColInterval;
end;

procedure TColorShader.SetCol2(ACol: TColor);
begin
  RGBFromCol(ACol, R2, G2, B2);
  UpdateColInterval;
end;

procedure TColorShader.SetCols(ACol1, ACol2: TColor);
begin
  SetCol1(ACol1);
  SetCol2(ACol2);
end;

procedure TColorShader.SetCol1(R, G, B: byte);
begin
  R1 := R;
  G1 := G;
  B1 := B;
  UpdateColInterval;
end;

procedure TColorShader.SetCol2(R, G, B: byte);
begin
  R2 := R;
  G2 := G;
  B2 := B;
  UpdateColInterval;
end;

procedure TColorShader.SetCols(AR1, AG1, AB1, AR2, AG2, AB2: byte);
begin
  SetCol1(AR1, AG1, AB1);
  SetCol1(AR2, AG2, AB2);
end;

procedure TColorShader.SetMaxVolume(AValue: double);
begin
  FMinVolume := AValue;
  UpdateColInterval;
end;

procedure TColorShader.SetMinVolume(AValue: double);
begin
  FMaxVolume := AValue;
  UpdateColInterval;
end;

procedure TColorShader.SetVolumeInterval(AStart, AEnd: double);
begin
  MinVolume := AStart;
  MaxVolume := AEnd;
end;

procedure TColorShader.UpdateColInterval;
begin
  RNorm.SetInterval(FMinVolume, FMaxVolume, R1, R2);
  GNorm.SetInterval(FMinVolume, FMaxVolume, G1, G2);
  BNorm.SetInterval(FMinVolume, FMaxVolume, B1, B2);
end;

end.
