unit UClassSingleton;

interface

uses
  Vcl.StdCtrls, SysUtils;

type
  ClassSingleton = Class
  public
    procedure Log(AWhere : TListBox; AMsg : string);
  End;

implementation

{ ClassSingleton }

procedure ClassSingleton.Log(AWhere: TListBox; AMsg: string);
begin
  AWhere.ItemIndex := AWhere.Items.Add(Format('[%p]: %s',[pointer(Self), AMsg]));
end;

end.
