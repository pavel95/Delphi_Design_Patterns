unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin,
  ObserverPattern, Vcl.ExtCtrls;

type
  TFmMain = class(TForm)
    lbLog: TListBox;
    sedHeat: TSpinEdit;
    sedRain: TSpinEdit;
    lblInfo: TLabel;
    btnAddLabel: TButton;
    btnRemLabel: TButton;
    btnAddLog: TButton;
    btnRemLog: TButton;
    procedure FormCreate(Sender: TObject);
    procedure sedRainChange(Sender: TObject);
    procedure sedHeatChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddLabelClick(Sender: TObject);
    procedure btnRemLabelClick(Sender: TObject);
    procedure btnAddLogClick(Sender: TObject);
    procedure btnRemLogClick(Sender: TObject);
  private
    { Private declarations }
    WeatherStation: TWeatherStation;
    ObserverLog, ObserverLabel : IObserver;
    WeatherStationUpd: TWeatherStation;
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.dfm}

procedure TFmMain.btnAddLabelClick(Sender: TObject);
begin
  WeatherStation.Attach(ObserverLabel);
end;

procedure TFmMain.btnRemLabelClick(Sender: TObject);
begin
  WeatherStation.Detach(ObserverLabel);
end;

procedure TFmMain.btnAddLogClick(Sender: TObject);
begin
  WeatherStation.Attach(ObserverLog);
end;

procedure TFmMain.btnRemLogClick(Sender: TObject);
begin
  WeatherStation.Detach(ObserverLog);
end;

procedure TFmMain.FormCreate(Sender: TObject);
begin
  ObserverLog := TObserverLog.Create(lbLog);
  ObserverLabel := TObserverLabel.Create(lblInfo);
  WeatherStation := TWeatherStation.Create('Praha');

  WeatherStation.Heat := sedHeat.Value;
  WeatherStation.Rain := sedRain.Value;

  WeatherStation.Attach(ObserverLog);
  WeatherStation.Attach(ObserverLabel);
end;

procedure TFmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(WeatherStation);
end;

procedure TFmMain.sedHeatChange(Sender: TObject);
begin
  WeatherStation.Heat := sedHeat.Value;
end;

procedure TFmMain.sedRainChange(Sender: TObject);
begin
  WeatherStation.Rain := sedRain.Value;
end;

end.
