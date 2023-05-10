program Proxy_Logging_p;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {fmProxy};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmProxy, fmProxy);
  Application.Run;
end.
