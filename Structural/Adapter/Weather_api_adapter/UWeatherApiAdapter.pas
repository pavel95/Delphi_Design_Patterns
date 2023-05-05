unit UWeatherApiAdapter;

interface

uses
  UWeatherApi;

type
  // interface describing protocol which other classes must follow to be able
  //   to colaborate with client code
  IWeatherApi = interface
    function GetTemperature : double;
    function GetHumidity : double;
    function GetWindSpeed : double;
  end;

  // Adapter
  // It implements client interface and has reference to incompatible service - which it controls.
  // Or it can implement service's interface if it is possible.
  // Adapter modifies input or output data, so it is compatible with our application.
  TWeatherApiAdapter = class(TInterfacedObject, IWeatherApi)
  private
    FWeatherApi : TWeatherApi;
  public
    constructor Create(AWeatherApi : TWeatherApi);
    function GetTemperature : double;
    function GetHumidity : double;
    function GetWindSpeed : double;
  end;

implementation

{ TWeatherApiAdapter }

constructor TWeatherApiAdapter.Create(AWeatherApi: TWeatherApi);
begin
  FWeatherApi := AWeatherApi;
end;

function TWeatherApiAdapter.GetHumidity: double;
begin
  Result := FWeatherAPI.GetHumidityInPercentage;
end;

function TWeatherApiAdapter.GetTemperature: double;
begin
  Result := FWeatherAPI.GetTemperatureInFahrenheit;
  // Convert Fahrenheit to Celsius (the format expected by our application)
  Result := (Result - 32) * 5 / 9;
end;

function TWeatherApiAdapter.GetWindSpeed: double;
begin
  Result := FWeatherAPI.GetWindSpeedInMph;
  // Convert mph to km/h (the format expected by our application)
  Result := Result * 1.60934;
end;

end.
