unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  UGlobal_Variable,
  UNewInstance,
  UNewInstance_RefCount,
  UClassSingleton,
  USingletonFactory;

type
  // .. Note:
  // .. Implementace singletonu jak je obvykla v C#, Java, apod. - zprivatnenim konstruktoru - v delphi nefunguje.
  // .. zde by se zavolal prvni dostupny konstruktor (nejdale z TObject)
  // .. Pokusy o tzv. hidden create pusobi problemy

  TFmMain = class(TForm)
    pnlMenu: TPanel;
    lbLog: TListBox;
    btnGlobalVariable: TButton;
    btnNewInstance: TButton;
    btnNewInstanceRefCount: TButton;
    btnSingletonFactory: TButton;
    procedure btnGlobalVariableClick(Sender: TObject);
    procedure btnNewInstanceClick(Sender: TObject);
    procedure btnNewInstanceRefCountClick(Sender: TObject);
    procedure btnSingletonFactoryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.dfm}

procedure TFmMain.btnGlobalVariableClick(Sender: TObject);
begin
  GlobalVariable.Log(lbLog, 'Using global variable without explicit creating');

end;

procedure TFmMain.btnNewInstanceClick(Sender: TObject);
var
  LSingleton : TNewInstanceSingleton;
begin
  LSingleton := TNewInstanceSingleton.Create;
  LSingleton.Log(lbLog, 'This singleton was created');
  LSingleton.Free;
  LSingleton.Log(lbLog, 'There was attempt to free this singleton');
  LSingleton := TNewInstanceSingleton.Create;
  LSingleton.Log(lbLog, 'Create was called again, but I am still same');
end;

procedure TFmMain.btnNewInstanceRefCountClick(Sender: TObject);
var
  Ic1, Ic2, Ic3 : TNewInstanceRefCount;
begin
  Ic1 := TNewInstanceRefCount.Create;
  Ic2 := TNewInstanceRefCount.Create;
  Ic3 := TNewInstanceRefCount.Create;

  Ic1.Log(lbLog,'Instance count Singleton (1) created');
  Ic2.Log(lbLog,'Instance count Singleton (2) created');
  Ic3.Log(lbLog,'Instance count Singleton (3) created');

  Ic1.Free;
  Ic2.Free;

  Ic1.Log(lbLog, 'Singleton (1) called free');
  Ic2.Log(lbLog, 'Singleton (2) called free');

  Ic3.Log(lbLog,'I am not freed yet');
  Ic3.Free;
end;

procedure TFmMain.btnSingletonFactoryClick(Sender: TObject);
var
  LSingleton : ISingleton;
begin
  LSingleton := GetSingleton;
  LSingleton.Log(lbLog,'Created from singleton factory');
end;

end.
