unit UAbstractFactory;

interface

uses
  UMonster, UWeapon, Classes;

type
  // Abstract factory is creational pattern
  // that provides a way to create families of related or dependent objects

  //  TMonster class holds a reference to a TWeapon object,
  // and it's the factory's responsibility to create the right type of weapon when creating a monster.

  // .. Interface for creating objects
  IMonsterFactory = interface
    function CreateMonster : TMonster;
  end;

  // .. Concrete abstract factories
  TFireMonsterFactory = class(TInterfacedObject, IMonsterFactory)
  public
    function CreateMonster : TMonster;
  end;

  TWaterMonsterFactory = class(TInterfacedObject, IMonsterFactory)
    function CreateMonster : TMonster;
  end;

implementation

{ TFireMonsterFactory }

function TFireMonsterFactory.CreateMonster: TMonster;
begin
  result := TFireMonster.Create(TFireSword.Create);
end;

{ TWaterMonsterFactory }

function TWaterMonsterFactory.CreateMonster: TMonster;
begin
  result := TWaterMonster.Create(TWaterSpear.Create);
end;

end.
