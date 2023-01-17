program pFactoryMethod_Seasons;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  UFactoryMethod in 'UFactoryMethod.pas';

var
  season: ISeason;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    season := TSeasonFactory.GetSeason(StrToDate('16.01.2023'));
    Writeln(season.GetName);
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
