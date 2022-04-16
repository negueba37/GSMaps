unit GSMap.Geoocoder.Configuration;

interface

type

  TEnumTypeTravelMode = (DRIVING);
  TGSMapGeoocoderConfiguration = class
  private
    FTravelMode: TEnumTypeTravelMode;
    procedure SetTravelMode(const Value: TEnumTypeTravelMode);
  public
  published
  property TravelMode:TEnumTypeTravelMode read FTravelMode write SetTravelMode default TEnumTypeTravelMode.DRIVING;
  end;

implementation

{ TGSMapGeoocoderConfiguration }

procedure TGSMapGeoocoderConfiguration.SetTravelMode(
  const Value: TEnumTypeTravelMode);
begin
  FTravelMode := Value;
end;

end.
