unit UCORPattern;

interface

uses
  SysUtils;

type
  IProcessor = interface
  ['{0D0081C6-E804-427E-A1C1-0FA33E194D3A}']
    procedure SetSuccessor(AProcessor : IProcessor);
    procedure ProcessRequest(ARequest : integer);
  end;

  TTemperatureProcessor = class(TInterfacedObject, IProcessor)
  private
    FSucessor : IProcessor;
  public
    constructor Create(AProcessor : IProcessor);
    procedure SetSuccessor(AProcessor : IProcessor);
    procedure ProcessRequest(ARequest : integer); virtual;
  end;


  TFreezProcessor = class(TTemperatureProcessor)
  public
    procedure ProcessRequest(ARequest : integer); override;
  end;

  TZeroProcessor = class(TTemperatureProcessor)
  public
    procedure ProcessRequest(ARequest : integer); override;
  end;

  TColdProcessor = class(TTemperatureProcessor)
  public
    procedure ProcessRequest(ARequest : integer); override;
  end;

  THotProcessor = class(TTemperatureProcessor)
  public
    procedure ProcessRequest(ARequest : integer); override;
  end;

  TChain = class
  private
    FChain : IProcessor;
    procedure buildChain;
  public
    procedure Process(ARequest : integer);
    constructor Create;
  end;

implementation

{ TProcessor }

constructor TTemperatureProcessor.Create(AProcessor: IProcessor);
begin
  FSucessor := AProcessor;
end;

procedure TTemperatureProcessor.ProcessRequest(ARequest : integer);
begin
  if FSucessor <> nil then
    FSucessor.ProcessRequest(ARequest);
end;

procedure TTemperatureProcessor.SetSuccessor(AProcessor: IProcessor);
begin
  FSucessor := AProcessor;
end;

{ TChain }

procedure TChain.buildChain;
begin
  FChain := TFreezProcessor.Create(
    TZeroProcessor.Create(
      TColdProcessor.Create(
        THotProcessor.Create(nil)
      )
    )
  );
end;

constructor TChain.Create;
begin
  buildChain;
end;

procedure TChain.Process(ARequest : integer);
begin
  FChain.ProcessRequest(ARequest);
end;

{ TFreezProcessor }

procedure TFreezProcessor.ProcessRequest(ARequest : integer);
begin
  if ARequest < 0 then
    Writeln(Format('[%iC]: It is freezing. Dont go outside!',[ARequest]))
  else
    inherited;
end;

{ TZeroProcessor }

procedure TZeroProcessor.ProcessRequest(ARequest: integer);
begin
  if (ARequest = 0) then
    Writeln(Format('[%iC]: Temperature is zero. Water is turning to ice..',[ARequest]))
  else
    inherited;
end;

{ TNiceProcessorr }

procedure TColdProcessor.ProcessRequest(ARequest: integer);
begin
  if (ARequest > 0) and (ARequest <= 15) then
    Writeln(Format('[%iC]: It is cold outside. Put on some jacket.',[ARequest]))
  else
    inherited;
end;

{ THotProcessor }

procedure THotProcessor.ProcessRequest(ARequest: integer);
begin
  inherited;
  if ARequest > 15 then
    Writeln(Format('[%iC]: Nice weather, go for a walk!.',[ARequest]))
  else
    inherited;
end;

end.
