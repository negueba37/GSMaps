unit GSMap.Events;

interface

uses
  Vcl.Edge, System.SysUtils, System.JSON, System.StrUtils, GSMap.Geoocoder;
  type
  TGsMapEvents = class
    private
    FBrowser:TEdgeBrowser;
    FGeoocoder: TGSMapGeoocoder;
    FAfterExecuteScript: TProc<string>;
    procedure OnExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HRESULT; const AResultObjectAsJson: string);
  procedure AposExecutarJS(const AResultObjectAsJson: string); overload;
  function ValidateResultObject(AResult: string;out Resultado:Boolean): string;
  procedure ExecuteCallback(AJSon: TJSONobject);
  function ExtractResult(AValue:string):string;
    procedure SetGeoocoder(const Value: TGSMapGeoocoder);
    procedure SetAfterExecuteScript(const Value: TProc<string>);
    public
    constructor Create(ABrowser:TEdgeBrowser);
    destructor Destroy;override;
    property AfterExecuteScript:TProc<string> read FAfterExecuteScript write SetAfterExecuteScript;
    property Geoocoder:TGSMapGeoocoder read FGeoocoder write SetGeoocoder;
  end;


implementation

{ TGsMapEvents }

procedure TGsMapEvents.AposExecutarJS(const AResultObjectAsJson: string);
var
  LResult:string;
  LJSON:TJSONObject;
  LResultado:Boolean;
begin
  LResult := ValidateResultObject(AResultObjectAsJson,LResultado);
  if not(LResultado) then Exit;
  LJSON := TJSONObject.ParseJSONValue(LResult) as TJSONObject;
  try
    ExecuteCallback(LJSON);

  finally
    LJSON.Free;
  end;
  if Assigned(FAfterExecuteScript) then
    FAfterExecuteScript(LResult);
end;

constructor TGsMapEvents.Create(ABrowser:TEdgeBrowser);
begin
  if not Assigned(ABrowser) then Exit;
  FBrowser := ABrowser;
  FBrowser.OnExecuteScript := OnExecuteScript;
end;

destructor TGsMapEvents.Destroy;
begin

  inherited;
end;

procedure TGsMapEvents.ExecuteCallback(AJSon: TJSONobject);
var
  LNameChamada:string;
begin
  if not Assigned(AJSon) then Exit;
  LNameChamada := AJSon.Get(0).JsonString.ToJSON.Replace('"','',[rfReplaceAll]);
  case AnsiIndexStr(LNameChamada, ['GetGeocoderdata', 'OPCAO2','OPCAO3']) of
    0: FGeoocoder.OnBuscarEndereco(AJSon);
    //1:OnTracarRota(AJSon);
  end;
  LNameChamada := AJSon.Get(0).JsonValue.ToJSON;
  LNameChamada := AJSon.Get(0).Value;
  LNameChamada := AJSon.Get(0).ToJSON;
end;

function TGsMapEvents.ExtractResult(AValue: string): string;
var
  LJSON:TJSONObject;
begin
  Result := EmptyStr;
  if AValue.IsEmpty then Exit;
  if not AValue.StartsWith('{') then Exit;
  LJSON := TJSONObject.ParseJSONValue(AValue) as TJSONObject;
  try
  finally
    LJSON.Free;
  end;
end;

procedure TGsMapEvents.OnExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HRESULT; const AResultObjectAsJson: string);
begin
  AposExecutarJS(AResultObjectAsJson);
  if Assigned(FAfterExecuteScript) then
    FAfterExecuteScript(AResultObjectAsJson);
end;

procedure TGsMapEvents.SetAfterExecuteScript(const Value: TProc<string>);
begin
  FAfterExecuteScript := Value;
end;

procedure TGsMapEvents.SetGeoocoder(const Value: TGSMapGeoocoder);
begin
  FGeoocoder := Value;
end;

function TGsMapEvents.ValidateResultObject(AResult: string;
  out Resultado: Boolean): string;
begin
  Result := EmptyStr;
  Resultado:= True;
  if (AResult.IsEmpty) or (AResult.ToLower = 'null') then
  begin
    Resultado := False;
    Exit;
  end;
  Result := AResult.Replace('\"','"',[rfReplaceAll]);
  Result := Copy(Result,2,Result.Length-2);
  if not (Result.StartsWith('{'))then
  begin
    Resultado := False;
    Exit;
  end;
  if not(Result.EndsWith('}'))then
  begin
    Resultado := False;
    Exit;
  end;
end;

end.
