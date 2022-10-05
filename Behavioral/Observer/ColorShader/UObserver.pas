unit UObserver;

interface

uses
  Classes, System.Generics.Collections, Vcl.Graphics,
  System.TypInfo, UColorShader;

type
  IObserver = interface
  ['{148C120F-0548-469C-8CE7-47219305FDA3}']
    procedure Update(ASubject : TObject);
  end;

  ISubject = interface
  ['{8601E567-A017-4DEC-A8C1-81D305B1FA08}']

    procedure Attach(AObserver : IObserver);
    procedure Detach(AObserver : IObserver);

    procedure Notify;
  end;

  TValueSubject<T> = class(TInterfacedObject, ISubject)
  strict private
    FObservers : TList<IObserver>;
    FValue : T;

    procedure SetValue(AValue : T);
  public
    constructor Create;
    procedure Attach(AObserver : IObserver);
    procedure Detach(AObserver : IObserver);
    procedure Notify;

    property Value :T read FValue write SetValue;
  end;

  TObjectColorizer = class(TInterfacedObject, IObserver)
  strict private
    FColor1, FColor2 : TColor;
    FControls : TList<TObject>;
    FColorShader : TColorShader;

    procedure SetMinVolume(AValue : double);
    function GetMinVolume : double;

    procedure SetMaxVolume(AValue : double);
    function GetMaxVolume : double;
  public
    constructor Create; overload;
    constructor Create(AColor1, AColor2 : TColor); overload;
    procedure Update(ASubject : TObject);

    procedure SetVolume(AMax, AMin : double);

    property Controls : TList<TObject> read FControls;
    property MaxVolume : double read GetMaxVolume write SetMaxVolume;
    property MinVolume : double read GetMinVolume write SetMinVolume;
  end;


implementation

{ TValueSubject }

procedure TValueSubject<T>.Attach(AObserver: IObserver);
begin
  if FObservers.IndexOf(AObserver) < 0 then
    FObservers.Add(AObserver);
end;

constructor TValueSubject<T>.Create;
begin
  inherited Create;
  FObservers := TList<IObserver>.Create;
end;

procedure TValueSubject<T>.Detach(AObserver: IObserver);
begin
  FObservers.Remove(AObserver);
end;

procedure TValueSubject<T>.Notify;
var
  obs : IObserver;
begin
  for obs in FObservers do
    obs.Update(Self);
end;

procedure TValueSubject<T>.SetValue(AValue: T);
begin
  FValue := AValue;
  Notify;
end;

{ TObjectColorizer }

constructor TObjectColorizer.Create;
begin
  inherited Create;
  FControls := TList<TObject>.Create;
  FColorShader := TColorShader.Create;
end;

constructor TObjectColorizer.Create(AColor1, AColor2: TColor);
begin
  Create;
  FColorShader.SetCols(AColor1, AColor2);
end;

function TObjectColorizer.GetMaxVolume: double;
begin
  result := FColorShader.MaxVolume;
end;

procedure TObjectColorizer.SetMaxVolume(AValue: double);
begin
  FColorShader.MaxVolume := AValue;
end;

function TObjectColorizer.GetMinVolume: double;
begin
  result := FColorShader.MinVolume;
end;

procedure TObjectColorizer.SetMinVolume(AValue: double);
begin
  FColorShader.MinVolume := AValue;
end;

procedure TObjectColorizer.SetVolume(AMax, AMin: double);
begin
  MaxVolume := AMax;
  MinVolume := AMin;
end;

procedure TObjectColorizer.Update(ASubject: TObject);
var
  obj : TObject;
  volume : integer;
begin
  volume := TValueSubject<integer>(ASubject).Value;
  for obj in FControls do
  begin
    if IsPublishedProp(obj,'Color') then
    begin
      SetOrdProp(obj, 'Color', FColorShader.MakeShade(volume));
    end;
  end;
end;

end.
