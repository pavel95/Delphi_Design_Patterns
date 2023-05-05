program pWeatherApi;

{$APPTYPE CONSOLE}

{$R *.res}

// Suppose we are building an application that needs to display weather
// information to the user. We decide to use a third-party weather API to
// retrieve the weather data. However, the third-party API returns the weather
// data in a format that does not match the format that our application
// expects. To solve this problem, we decide to use the Adapter pattern to
// adapt the third-party API to work with our application.

uses
  System.SysUtils,
  UWeatherApi in 'UWeatherApi.pas',
  UWeatherApiAdapter in 'UWeatherApiAdapter.pas';

var
  WeatherApi : TWeatherApi;
  WeatherApiAdapter : IWeatherApi;

begin
  try
    WeatherApi := TWeatherApi.Create;
    try
      WeatherApiAdapter := TWeatherApiAdapter.Create(WeatherApi);

      Writeln('Temperature: ' + FloatToStr(WeatherApiAdapter.GetTemperature));
      Writeln('Humidity: ' + FloatToStr(WeatherApiAdapter.GetHumidity));
      Writeln('Wind speed: ' + FloatToStr(WeatherApiAdapter.GetWindSpeed));
      Readln;
    finally
      FreeAndNil(WeatherApi);
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
