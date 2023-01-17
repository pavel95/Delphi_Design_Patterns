unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UMonster, UAbstractFactory;

type
  // Client code creates instances of the concrete factories and uses them
  //  to create instances of the concrete products
  TForm1 = class(TForm)
    lbLog: TListBox;
    GroupBox1: TGroupBox;
    btnFire: TButton;
    btnWater: TButton;
    btnAttack: TButton;
    btnMove: TButton;
    procedure btnFireClick(Sender: TObject);
    procedure btnAttackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnWaterClick(Sender: TObject);
    procedure btnMoveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMonster : TMonster;
    FMonsterFactory : IMonsterFactory;

    procedure GetNewMonster;
    procedure Log(AMessage : string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnAttackClick(Sender: TObject);
begin
  Log(FMonster.Attack);
end;

procedure TForm1.btnFireClick(Sender: TObject);
begin
  FMonsterFactory := TFireMonsterFactory.Create;
  GetNewMonster;
end;

procedure TForm1.btnMoveClick(Sender: TObject);
begin
  Log(FMonster.Move);
end;

procedure TForm1.btnWaterClick(Sender: TObject);
begin
  FMonsterFactory := TWaterMonsterFactory.Create;
  GetNewMonster;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FMonsterFactory := TFireMonsterFactory.Create;
  GetNewMonster;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMonster);
end;

procedure TForm1.GetNewMonster;
begin
  FreeAndNil(FMonster);
  FMonster := FMonsterFactory.CreateMonster;
  Log(FMonster.GetName + ' created');
end;

procedure TForm1.Log(AMessage: string);
begin
  lbLog.ItemIndex := lbLog.Items.Add(AMessage);
end;

end.
