unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  ///  Trik v delphi - proxy vcl komponent
  ///  Lze deklarovat stejnojmenne tridy, ktere mohou byt pouzity napriklad jako
  ///  v teto ukazce logovaci proxy - bez nutnosti prepisovat originalni kod.
  ///  Nasledne je mozne prepsat virtualni metody vcl komponenty pro nase ucely.
  ///
  ///  Podminka - museji byt deklarovany drive nez zde TfmProxy
  ///  form loader tak nacte proxy tridu misto originalu
  ///
  ///  
  ///  Trick in delphi - proxy with vcl components
  ///  classes of the same name can be declared, which can be used as in this
  ///  sample logging proxy, without having to rewrite the original code.
  ///
  ///  Subsequently, the virtual methods of the vcl components can be overridden
  ///  for our purposes.
  ///  The condition is that they must be declared before the TFmProxy here.
  ///  The form loader will thus load the proxy class instead of the original.

  TButton = class(Vcl.StdCtrls.TButton)
  public
    procedure Click; override;
  end;

  TEdit = class(Vcl.StdCtrls.TEdit)
  protected
    procedure KeyPress(var Key: Char); override;
  end;

  TfmProxy = class(TForm)
    lbLog: TListBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Log(AMessage : string);
  end;

var
  fmProxy: TfmProxy;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfmProxy.Log(AMessage: string);
begin
  lbLog.ItemIndex := lbLog.Items.Add(AMessage);
end;

{ TButton }

procedure TButton.Click;
begin
  fmProxy.Log(format('[%s]: Button will be clicked',[self.Name]));
  inherited;
  fmProxy.Log(format('[%s]: Button was clicked',[self.Name]));
end;

{ TEdit }

procedure TEdit.KeyPress(var Key: Char);
begin
  fmProxy.Log(format('[%s]: Key %s will be pressed on edit',[Self.Name, Key]));
  inherited;
  fmProxy.Log(format('[%s]: Key %s was pressed on edit',[Self.Name, Key]));
end;

end.
