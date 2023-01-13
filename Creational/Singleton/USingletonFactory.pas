unit USingletonFactory;

interface

uses
  Vcl.StdCtrls, SysUtils;

type
  // .. Vystavim pouze interface a metodu pro ziskani ISingleton
  ISingleton = interface ['{2DB55DFD-313B-475F-BB1F-E5300A088C7F}']
    procedure Log(AWhere : TListBox; AMsg : string);
  end;

  function GetSingleton : ISingleton;

implementation

type
  TSingleton = class(TInterfacedObject, ISingleton)
  public
    destructor Destroy; override;
    procedure Log(AWhere : TListBox; AMsg : string);
  end;

var
  GSingleton : ISingleton;

function GetSingleton : ISingleton;
begin
  if not Assigned(GSingleton) then
    GSingleton := TSingleton.Create;
  result := GSingleton;
end;

{ TSingleton }

destructor TSingleton.Destroy;
begin
  GSingleton := nil;
  inherited;
end;

procedure TSingleton.Log(AWhere: TListBox; AMsg: string);
begin
  AWhere.ItemIndex := AWhere.Items.Add(Format('[%p]: %s',[pointer(Self), AMsg]));
end;

end.
