unit UMediator;

interface

uses
  SysUtils, System.Generics.Collections;

type
  TColleague = class;

  // Mediator abstract base class
  TMediator = class abstract
  public
    // Deklarace metody pro colleagues posilani zprav skrze mediator
    procedure Send(const AMessage: string; AColleague: TColleague); virtual; abstract;
  end;

  // Colleague abstract base class
  TColleague = class abstract
  private
    FMediator : TMediator;
  public
    constructor Create(AMediator : TMediator);
    procedure Send(AMessage : String); virtual; abstract;
    procedure Recieve(AMessage : string; AColleague : TColleague); virtual; abstract;
  end;


  TConcreteMediator = class(TMediator)
  private
    FColleagues : TList<TColleague>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddColleague(AColleague : TColleague);
    procedure RemoveColleague(AColleague : TColleague);
    procedure Send(const AMessage: string; AColleague: TColleague); override;
  end;

  TConcreteColleague = class(TColleague)
  public
    procedure Send(AMessage : String); override;
    procedure Recieve(AMessage : string; AColleague : TColleague); override;
  end;

implementation

{ TColleague }

constructor TColleague.Create(AMediator: TMediator);
begin
  FMediator := AMediator;
end;

{ TConcreteMediator }

constructor TConcreteMediator.Create;
begin
  FColleagues := TList<TColleague>.Create;
end;

destructor TConcreteMediator.Destroy;
begin
  FreeAndNil(FColleagues);
  inherited;
end;

procedure TConcreteMediator.Send(const AMessage: string; AColleague: TColleague);
var
  Colleague : TColleague;
begin
  // Poslani zpravy vsem colleagues
  for Colleague in FColleagues do
  begin
    Colleague.Recieve(AMessage, AColleague);
  end;

end;

procedure TConcreteMediator.AddColleague(AColleague: TColleague);
begin
  if FColleagues.Contains(AColleague) then
    FColleagues.Add(AColleague);
end;

procedure TConcreteMediator.RemoveColleague(AColleague: TColleague);
begin
  FColleagues.Remove(AColleague);
end;

{ TConcreteColleague }

procedure TConcreteColleague.Recieve(AMessage: string; AColleague: TColleague);
begin
  // ziskani zpravy od jineho colleague skrze mediatora
  Writeln('Colleague received message: ', AMessage);
end;

procedure TConcreteColleague.Send(AMessage: String);
begin
  // poslani zpravy vsem colleague skrze mediator
  FMediator.Send(AMessage, Self);
end;

end.
