unit UFactoryMethod;

// .. This code provides a basic example of the factory method pattern.
// .. The factory method is the class function TSeasonFactory.GetSeason, which takes
// .. in a date and returns an object that implements the ISeason interface.
//
// .. The factory method uses the month of the date to determine which object
// .. to create and return, with different objects being created for different
// .. seasons (spring, summer, fall, and winter). This allows for the creation
// .. of objects to be abstracted away from the client code.

interface

type
  ISeason = interface
    function GetName : string;
  end;

  TSpring = class(TInterfacedObject, ISeason)
    function GetName : string;
  end;

  TSummer = class(TInterfacedObject, ISeason)
    function GetName : string;
  end;

  TFall = class(TInterfacedObject, ISeason)
    function GetName : string;
  end;

  TWinter = class(TInterfacedObject, ISeason)
    function GetName : string;
  end;

  TSeasonFactory = class
    class function GetSeason(const ADate : TDateTime) : ISeason;
  end;

implementation

uses
  SysUtils;

{ TSpring }

function TSpring.GetName: string;
begin
  result := 'Spring';
end;

{ TSummer }

function TSummer.GetName: string;
begin
  result := 'Summer';
end;

{ TAutumn }

function TFall.GetName: string;
begin
  result := 'Autumn';
end;

{ TWinter }

function TWinter.GetName: string;
begin
  result := 'Winter';
end;


{ TSeasonFactory }

class function TSeasonFactory.GetSeason(const ADate: TDateTime): ISeason;
var
  year,month,day: Word;
begin
  // .. Simple function for demonstration, doesn't care about days
  DecodeDate(ADate, year, month, day);
  case month of
    3..5:
      Result := TSpring.Create;
    6..8:
      Result := TSummer.Create;
    9..11:
      Result := TFall.Create;
  else
    Result := TWinter.Create;
  end;
end;

end.
