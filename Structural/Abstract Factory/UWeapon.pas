unit UWeapon;

interface

type
  IWeapon = interface
  ['{EA4E0D9B-2001-497E-A8DD-B73911D78500}']
    function GetName : string;
  end;

  TFireSword = class(TInterfacedObject, IWeapon)
  public
    function GetName : string;
  end;

  TWaterSpear = class(TInterfacedObject, IWeapon)
  public
    function GetName : string;
  end;

implementation

{ TFireSword }

function TFireSword.GetName: string;
begin
  result := 'Fire sword';
end;

{ TWaterSpear }

function TWaterSpear.GetName: string;
begin
  result := 'Water spear';
end;

end.
