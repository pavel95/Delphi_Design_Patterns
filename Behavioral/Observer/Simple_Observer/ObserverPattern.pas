unit ObserverPattern;

interface

uses
  Classes, SysUtils, Vcl.StdCtrls, System.Generics.Collections;

type
  // Observer pattern
  // .. Pozorovany objekt a Pozorovatele (1:N)
  // .. Sam pozorovany objekt dava vedet pozorovatelum o zmene sveho stavu
  // .... ty se pak updatuji

  // .. Rozhrani pro pozorovatele
  // .. musi mit Update metodu kterou vola pozorovany objekt
  IObserver = interface
  ['{F9403C58-4D18-4891-882A-5920286424E1}']
    procedure Update(ASubject : TObject);
  end;

  // .. Rozhrani pro pozorovany objekt (subjekt)
  // .. metody pro registrovani a odregistrovani pozorujiciho objektu - IObservera (Attach, Detach)
  // .. Metoda pro upozorneni pozorujicich objektu (Notify)
  ISubject = interface
  ['{8C62FA3D-687E-41C8-9AAB-F0C6C27719C6}']
    procedure Attach(AObserver : IObserver);
    procedure Detach(AObserver : IObserver);
    procedure Notify;
  end;

  // Implementace rozhrani ISubject - pozorovaneho objektu
  // .. ma list observeru
  // .. metoda Notify vola na kazdeho pozorovatele Update
  // .. Notify se provede vzdy kdyz se zmeni stav pozorovaneho objektu (SetHeat, SetRain)
  TWeatherStation = class(TInterfacedObject, ISubject)
  strict private
    FObservers : TList<IObserver>;
    FHeat : integer;
    FRain : integer;
    FCity : string;
  protected
    procedure SetHeat(value : integer);
    procedure SetRain(value : integer);
    procedure Notify;
  public
    constructor Create(ACity : string);
    destructor Destroy; override;

    procedure Attach(AObserver : IObserver);
    procedure Detach(AObserver : IObserver);

    property Heat : integer read FHeat write SetHeat;
    property Rain : integer read FRain write SetRain;
    property City : string read FCity;
  end;

  TObserverLog = class(TInterfacedObject, IObserver)
  strict private
    FLog : TListBox;
  public
    procedure Update(ASubject : TObject);
    constructor Create(AStrings : TListBox);
  end;

  TObserverLabel = class(TInterfacedObject, IObserver)
  strict private
    FLabel : TLabel;
  public
    constructor Create(Alabel : TLabel);
    procedure Update(ASubject : TObject);
  end;

implementation

{ TWeatherStation }

procedure TWeatherStation.Attach(AObserver: IObserver);
begin
  if FObservers.IndexOf(AObserver) < 0 then
    FObservers.Add(AObserver);
end;

procedure TWeatherStation.Detach(AObserver: IObserver);
begin
  FObservers.Remove(AObserver);
end;

procedure TWeatherStation.Notify;
var
  I : integer;
begin
  for I := 0 to FObservers.Count - 1 do
    IObserver(FObservers[I]).Update(Self);
end;

procedure TWeatherStation.SetHeat(value: integer);
begin
  FHeat := Value;
  Notify;
end;

procedure TWeatherStation.SetRain(value: integer);
begin
  FRain := Value;
  Notify;
end;

constructor TWeatherStation.Create(ACity : string);
begin
  inherited Create;
  FObservers := TList<IObserver>.Create;
  FCity := ACity;
end;

destructor TWeatherStation.Destroy;
begin
  FreeAndNil(FObservers);
  inherited;
end;

{ TObserverLog }

constructor TObserverLog.Create(AStrings: TListBox);
begin
  Assert(AStrings <> nil, 'Nowhere to log');
  inherited Create;
  FLog := AStrings;
end;

procedure TObserverLog.Update(ASubject : TObject);
begin
  if FLog <> nil then
    FLog.ItemIndex := FLog.Items.Add(Format('%s: Nyni %d C a pravdebodobnost srazek %d%%',
        [TWeatherStation(ASubject).City, TWeatherStation(ASubject).Heat, TWeatherStation(ASubject).Rain]));
end;

{ TObserverLabel }

constructor TObserverLabel.Create(Alabel: TLabel);
begin
  FLabel := ALabel;
end;

procedure TObserverLabel.Update(ASubject: TObject);
begin
  FLabel.Caption := Format('Teplota: %d, Srážky: %d%%',[TWeatherStation(ASubject).Heat,TWeatherStation(ASubject).Rain]);
end;

end.
