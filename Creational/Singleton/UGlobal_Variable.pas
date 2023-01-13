unit UGlobal_Variable;

interface

uses
  Vcl.StdCtrls, SysUtils;

type
  // .. Nejedna se o pravy singleton, nebrani vytvareni novych instanci
  // .. Analogie v delphi napr Application : TApplication
  // .. globalni promenna ktera se vytvari pri spusteni aplikace a uvolnuje pri ukonceni
  // .... -Initialization a Finalization
  TGlobalVariable = class
  public
    procedure Log(AWhere : TListBox; AMsg : string);
  end;

var
  GlobalVariable : TGlobalVariable;

implementation

{ TGlobalVariable }

procedure TGlobalVariable.Log(AWhere: TListBox; AMsg: string);
begin
  AWhere.ItemIndex := AWhere.Items.Add(Format('[%p]: %s',[pointer(Self), AMsg]));
end;

Initialization
  GlobalVariable := TGlobalVariable.Create;
Finalization
  FreeAndNil(GlobalVariable);
end.
