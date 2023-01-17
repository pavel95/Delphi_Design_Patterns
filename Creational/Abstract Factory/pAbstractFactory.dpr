program pAbstractFactory;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {Form1},
  UMonster in 'UMonster.pas',
  UWeapon in 'UWeapon.pas',
  UAbstractFactory in 'UAbstractFactory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
