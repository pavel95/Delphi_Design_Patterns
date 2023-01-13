unit UNewInstance_RefCount;

interface

uses
  Vcl.StdCtrls, SysUtils;

type
  // .. Myslenka podobna jako u UClassSingleton - prepsani NewInstance a FreeInstance
  // .... Tam se vytvoril a zil az do ukonceni programu
  // .... Zde jen do doby kdy se pouziva
  // .... K tomu pocitame pokusy o vytvoreni instanci, a uvolnovani
  // .... Vraci se stejna instance a uvolni se az kdyz pocet pouziti klesne na nulu
  TNewInstanceRefCount = class
  strict private
  class var
    FInstanceCount : integer;
    FSingleton : TNewInstanceRefCount;

  public
    class destructor destroy;
    procedure FreeInstance; override;

    class function NewInstance : TObject; override;

    procedure Log(AWhere : TListBox; AMsg : string);
  end;

implementation

{ TNewInstanceRefCount }

class destructor TNewInstanceRefCount.destroy;
begin
  FreeAndNil(FSingleton);
  inherited;
end;

procedure TNewInstanceRefCount.FreeInstance;
begin
  Dec(FInstanceCount);
  if FInstanceCount = 0 then begin
    inherited;
    FSingleton := nil;
  end;
end;

procedure TNewInstanceRefCount.Log(AWhere: TListBox; AMsg: string);
begin
  AWhere.ItemIndex := AWhere.Items.Add(Format('[%p]: %s',[pointer(Self), AMsg]));
end;

class function TNewInstanceRefCount.NewInstance: TObject;
begin
  if not Assigned(FSingleton) then
    FSingleton := TNewInstanceRefCount(inherited NewInstance);
  result := FSingleton;
  inc(FInstanceCount);
end;

end.
