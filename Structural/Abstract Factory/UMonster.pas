unit UMonster;

interface

uses
  UWeapon;

type
  TMonster = class
  private
    FWeapon : IWeapon;
  protected
    function Speak(AInfo : string) : string;
  public
    constructor Create(AWeapon : IWeapon);
    function GetName : string; virtual; abstract;
    function Attack : string;
    function Move : string; virtual; abstract;

    property Weapon : IWeapon read FWeapon write FWeapon;
  end;

  TFireMonster = class(TMonster)
  public
    function GetName : string; override;
    function Move : string; override;
  end;

  TWaterMonster = class(TMonster)
  public
    function GetName : string; override;
    function Move : string; override;
  end;

implementation

{ TMonster }

function TMonster.Attack: string;
begin
  result := Speak('attacking with ' + FWeapon.GetName + '!');
end;

constructor TMonster.Create(AWeapon: IWeapon);
begin
  FWeapon := AWeapon;
end;

function TMonster.Speak(AInfo: string): string;
begin
  result := GetName + ': ' + AInfo;
end;

{ TFireMonster }

function TFireMonster.GetName : string;
begin
  result := 'Fire monster';
end;

function TFireMonster.Move: string;
begin
  result := Speak('is walking')
end;

{ TWaterMonster }

function TWaterMonster.GetName : string;
begin
  result := 'Water monster';
end;

function TWaterMonster.Move: string;
begin
  result := Speak('is swimming');
end;

end.
