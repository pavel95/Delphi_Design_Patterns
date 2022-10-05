unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  UNormalizer, UColorShader, Vcl.ComCtrls, Vcl.ActnMan, Vcl.ActnColorMaps,
  UObserver;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    TrackBar1: TTrackBar;
    AColorBox1: TColorBox;
    AColorBox2: TColorBox;
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    BColorBox1: TColorBox;
    BColorBox2: TColorBox;
    Panel2: TPanel;
    Panel3: TPanel;
    ComboBox1: TComboBox;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AColorBox1Change(Sender: TObject);
    procedure AColorBox2Change(Sender: TObject);
  private
    { Private declarations }
    FValueSubject : TValueSubject<integer>;
    FAObjectColorizer, FBObjectColorizer : TObjectColorizer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AColorBox1Change(Sender: TObject);
begin
  //
end;

procedure TForm1.AColorBox2Change(Sender: TObject);
begin
  //
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FAObjectColorizer := TObjectColorizer.Create(AColorBox1.Selected, AColorBox2.Selected);
  FAObjectColorizer.SetVolume(TrackBar1.Min, TrackBar1.Max);


  FAObjectColorizer.Controls.Add(Label1);
  FAObjectColorizer.Controls.Add(Memo1);
  FAObjectColorizer.Controls.Add(Panel2);

  FBObjectColorizer := TObjectColorizer.Create(BColorBox1.Selected, BColorBox2.Selected);
  FBObjectColorizer.SetVolume(TrackBar1.Min, TrackBar1.Max);
  FBObjectColorizer.Controls.Add(Panel1);
  FBObjectColorizer.Controls.Add(Edit1);

  FValueSubject := TValueSubject<integer>.Create;
  FValueSubject.Attach(FAObjectColorizer);
  FValueSubject.Attach(FBObjectColorizer);
  FValueSubject.Value := TrackBar1.Position;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
  col : TColor;
begin
  FValueSubject.Value := TTrackBar(Sender).Position;
end;

end.
