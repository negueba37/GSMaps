unit GSMap.Position;

interface
  uses
    System.SysUtils;
type
    TGSMapPosition = class
  private
    FLatitude: Double;
    FLongitude: Double;
  public
    function Latitude:Double;overload;
    function Longitude:Double;overload;
    function LatitudeToString:string;overload;
    function LongitudeToString:string;overload;
    function Latitude(AValue:Double):TGSMapPosition;overload;
    function Longitude(AValue:Double):TGSMapPosition;overload;
    function Latitude(AValue:String):TGSMapPosition;overload;
    function Longitude(AValue:string):TGSMapPosition;overload;
  end;
implementation

{ TGSMapPosition }

function TGSMapPosition.Latitude: Double;
begin
  Result := FLatitude;
end;

function TGSMapPosition.Latitude(AValue: Double): TGSMapPosition;
begin
  Result := Self;
  FLatitude := AValue;
end;

function TGSMapPosition.Latitude(AValue: String): TGSMapPosition;
begin
  Result := Self;
  FLatitude := StrToFloatDef(AValue.Replace('.',',',[rfReplaceAll]),0);
end;

function TGSMapPosition.LatitudeToString: string;
begin
  Result := FLatitude.ToString.Replace(',','.');
end;

function TGSMapPosition.Longitude(AValue: Double): TGSMapPosition;
begin
  Result := Self;
  FLongitude := AValue;
end;

function TGSMapPosition.Longitude(AValue: string): TGSMapPosition;
begin
  Result := Self;
  FLongitude := StrToFloatDef(AValue.Replace('.',',',[rfReplaceAll]),0);
end;

function TGSMapPosition.Longitude: Double;
begin
  Result := FLongitude;
end;

function TGSMapPosition.LongitudeToString: string;
begin
  Result := FLongitude.ToString.Replace(',','.');
end;

end.
