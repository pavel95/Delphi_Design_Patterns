program Singleton_p;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FmMain},
  UGlobal_Variable in 'UGlobal_Variable.pas',
  UNewInstance in 'UNewInstance.pas',
  UNewInstance_RefCount in 'UNewInstance_RefCount.pas',
  USingletonFactory in 'USingletonFactory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
