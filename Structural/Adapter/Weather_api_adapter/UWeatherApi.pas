unit UWeatherApi;

interface

uses
  System.Math;

type
  // This class simulates third party api, which gives us data in format
  //   that we do not want. So we will create adapter that will control the api,
  //   and gives us data in right format.
  TWeatherApi = class

  public
    constructor Create;
    function GetTemperatureInFahrenheit : double;
    function GetHumidityInPercentage : double;
    function GetWindSpeedInMph : double;
  end;

implementation



{ TWeatherApi }

constructor TWeatherApi.Create;
begin
  inherited Create;
  Randomize;
end;

function TWeatherApi.GetHumidityInPercentage: double;
begin
  // Simulate retrieving the humidity in percentage from the weather service
  result := RandomRange(50, 100);
end;

function TWeatherApi.GetTemperatureInFahrenheit: double;
begin
  // Simulate retrieving the temperature in Fahrenheit from the weather service
  result := RandomRange(50 , 100);
end;

function TWeatherApi.GetWindSpeedInMph: double;
begin
  // Simulate retrieving the wind speed in mph from the weather service
  result := RandomRange(5, 15);
end;

end.
