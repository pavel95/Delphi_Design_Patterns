program pColleagues;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UMediator in 'UMediator.pas';

var
  Mediator : TMediator;
  Colleague1, Colleague2, Colleague3 : TColleague;

begin
  // Tento projekt demonstruje mediator pattern
  // .. Misto toho aby objekty komunikovali primo mezi sebou, vyuzivaji k tomu mediator
  // .. timto zpusobem redukujeme zavislosti mezi objekty
  Mediator := TConcreteMediator.Create;
  Colleague1 := TConcreteColleague.Create(Mediator);
  Colleague2 := TConcreteColleague.Create(Mediator);
  Colleague3 := TConcreteColleague.Create(Mediator);
  try

  finally
    FreeAndNil(Colleague1);
    FreeAndNil(Colleague2);
    FreeAndNil(Colleague3);
    FreeAndNil(Mediator);
  end;
end.
