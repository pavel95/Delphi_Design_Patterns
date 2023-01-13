unit UMediator;

interface

uses
  Classes, System.Generics.Collections;

type
  TUser = class;

  IChatMediator = interface
  ['{82C38C0C-9DE4-4355-8338-CC60075FEA6B}']
    procedure AddUser(AUser : TUser);
    procedure SendMessage(AMessage : string; AUser : TUser);
  end;

  TUser = class
  protected
    FChatMediator : IChatMediator;
    FName : string;
  public
    procedure Send(AMessage : string); virtual; abstract;
    procedure Recieve(AMessage : string); virtual; abstract;

    constructor Create(AChatMediator : IChatMediator; AName : string);
  end;

  TChatMediator = class(TInterfacedObject, IChatMediator)
  private
    FUsers : TList<TUser>;
  public
    constructor Create;
  end;

implementation

{ TUser }

constructor TUser.Create(AChatMediator: IChatMediator; AName: string);
begin
  inherited Create;
  FChatMediator := AChatMediator;
  FName := AName;
end;

{ TChatMediator }

constructor TChatMediator.Create;
begin
  FUsers := TList<TUser>.Create;
end;

end.
