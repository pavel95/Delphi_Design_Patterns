program ColorShader_p;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {Form1},
  UNormalizer in 'UNormalizer.pas',
  UColorShader in 'UColorShader.pas',
  UObserver in 'UObserver.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
