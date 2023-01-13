unit UNewInstance;

interface

uses
  Vcl.StdCtrls, SysUtils;

type
  // .. Jeden ze spravnych zpusobu jak v delphi implementovat pravy singleton
  // .... je prepsani NewInstance a FreeInstance z TObject.
  // .. Metoda NewInstance se spousti jeste pred TObject.Create
  // .. Metoda NewInstance je virtualni - takze ji muzeme prepsat
  // .. Metoda FreeInstance se spousti pro uvolneni pameti a lze ji take prepsat
  // ..
  // Jak funguje NewInstance:
  // .. 1) NewInstance zavola metodu InstanceSize aby ziskala pocet bytu, ktere jsou potreba pro ulozeni noveho objektu
  // .. 2) Pote zavolani metody GetMem pro alokovani techto bytu v pameti
  // .. 3) Zavolani metody InitInstance, ktera naplni tyto byty nulami

  // Singleton
  // .. My prepiseme NewInstance aby nam vracela vzdy stejnou pamet - nas singleton
  // .. Tzn. Create bude vracet tuto pamet tez

  // .. FreeInstance prepiseme tak aby nic nedelala dokud neni nastaven urcity flag
  // .... a tento flag budeme nastavovat pouze v class destructoru
  // .... protoze class destructor se spousti pouze az pri ukonceni aplikace (az po provedeni vsech finalization sekci)
  // .... = konstruktor nepujde uvolnit za behu aplikace, uvolni se az pri ukonceni
  TNewInstanceSingleton = class
  strict private
  class var
    FSingleton : TNewInstanceSingleton;
    FShuttingDown : boolean;
  strict protected
    class function GetInstance : TNewInstanceSingleton; static;
  public
    class Destructor Destroy;
    class function NewInstance : TObject; override;
    // property pro globalni pristup k instanci, vzdy se pristupuje pres nasi metodu GetInsance ktera vola konstruktor - ten vraci stejnou pamet
    class property Instance : TNewInstanceSingleton read GetInstance;

    procedure FreeInstance; override;
    procedure Log(AWhere : TListBox; AMsg : string);
  end;

implementation

{ TNewInstanceSingleton }

class destructor TNewInstanceSingleton.Destroy;
begin
  FShuttingDown := true;
  FreeAndNil(FSingleton);
  inherited;
end;

procedure TNewInstanceSingleton.FreeInstance;
begin
  if FShuttingDown then
    inherited;
end;

class function TNewInstanceSingleton.GetInstance: TNewInstanceSingleton;
begin
  result := TNewInstanceSingleton.Create;
end;

procedure TNewInstanceSingleton.Log(AWhere: TListBox; AMsg: string);
begin
  AWhere.ItemIndex := AWhere.Items.Add(Format('[%p]: %s',[pointer(Self), AMsg]));
end;

class function TNewInstanceSingleton.NewInstance: TObject;
begin
  if not Assigned(FSingleton) then
    FSingleton := TNewInstanceSingleton(inherited NewInstance);
  result := FSingleton;
end;

end.
