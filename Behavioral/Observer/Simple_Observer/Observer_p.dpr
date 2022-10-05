program Observer_p;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FmMain},
  ObserverPattern in 'ObserverPattern.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
