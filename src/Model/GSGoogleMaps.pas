unit GSGoogleMaps;

interface

uses
  Vcl.Edge, System.Generics.Collections, System.Classes, System.SysUtils,
  System.JSON, Rest.JSON, StrUtils, GSMap.Configuracoes, GSMap.Geoocoder,
  GSMap.Events, GSMap.Address;

type
  TLocalizacao = class
    Latitude: String;
    Longitude: string;
  end;

type
  TGSMaps = class(TComponent)
  private
    FListLocalizacao: TObjectList<TLocalizacao>;
    FBrowser: TEdgeBrowser;
    FConfiguracao: TGSMapConfiguracoes;
    FGeoocoder: TGSMapGeoocoder;
    FEvents: TGsMapEvents;
    FAddress:TGSMapAddressMap;
    procedure SetBrowser(const Value: TEdgeBrowser);
 private
    procedure LimparListaLocalizacao();
    Procedure AddLocalizacao(ALatitude, ALongitude: string);
  public
    constructor Create();
    destructor Destroy(); override;
    function Configuracao: TGSMapConfiguracoes;
    function Geoocoder: TGSMapGeoocoder;
    function Events:TGsMapEvents;

    procedure LoadMap(AUrl: string);

    function Address:TGSMapAddressMap;
    procedure GoToLacalization();
    procedure CriarTodosPoligonos();
    // procedure de callback
  published
    property Browser: TEdgeBrowser write SetBrowser;
  end;

implementation

{ TGSGoogleMaps }
procedure TGSMaps.AddLocalizacao(ALatitude, ALongitude: string);
var
  LLocalizacao: TLocalizacao;
begin
  LLocalizacao := TLocalizacao.Create;
  LLocalizacao.Latitude := ALatitude;
  LLocalizacao.Longitude := ALongitude;
  FListLocalizacao.Add(LLocalizacao);
end;

function TGSMaps.Address: TGSMapAddressMap;
begin
  Result := FAddress;
end;

procedure TGSMaps.LoadMap(AUrl: string);
begin
  FBrowser.Navigate(AUrl);
end;

function TGSMaps.Configuracao: TGSMapConfiguracoes;
begin
  Result := FConfiguracao;
end;

constructor TGSMaps.Create;
begin
  FConfiguracao := TGSMapConfiguracoes.Create();
  FListLocalizacao := TObjectList<TLocalizacao>.Create;
  FAddress := TGSMapAddressMap.Create;
end;

procedure TGSMaps.CriarTodosPoligonos;
var
  I: Integer;
  LStringList: TStringList;
  LPontoVirgula: string;
  LUltimoItem: Integer;
  Lstr: string;
begin
  // '41.580866|2.122579;41.603185|2.173725;41.614282|2.151847;41.575875|2.177757'
  LPontoVirgula := ';';
  LUltimoItem := pred(FListLocalizacao.Count);
  LStringList := TStringList.Create;
  LStringList.Text := '';
  try
    for I := 0 to pred(FListLocalizacao.Count) do
    begin
      if I = pred(FListLocalizacao.Count) then
        LPontoVirgula := '';
      Lstr := Lstr + FListLocalizacao[I].Latitude + '|' + FListLocalizacao[I]
        .Longitude + LPontoVirgula;
    end;
    FBrowser.ExecuteScript
      ('MakePolygon(0, true, true, ''red'', 0.2, true, ''#E00000'', 1.0, 3, true, '
      + QuotedStr(Lstr) + ', 1, ''<p>Prova2</p>'', true, 0, 0, 0, true);');
  finally
    LStringList.Free;
  end;
end;

destructor TGSMaps.Destroy;
begin
  if Assigned(FConfiguracao) then
    FConfiguracao.Free;
  if Assigned(FGeoocoder) then
    FGeoocoder.Free;
  if Assigned(FListLocalizacao) then
    FListLocalizacao.Free;
  if Assigned(FEvents) then
    FEvents.Free;
  if Assigned(FAddress) then
    FAddress.Free;
  inherited;
end;

function TGSMaps.Events: TGsMapEvents;
begin
  if not Assigned(FBrowser)then
    raise Exception.Create('Componente Edge não informado! xc970');
  Result := FEvents;
end;

function TGSMaps.Geoocoder: TGSMapGeoocoder;
begin
  Result := FGeoocoder;
end;

procedure TGSMaps.GoToLacalization;
var
  LStrFun: string;
begin





  LStrFun := 'GoToMap('+FAddress.Position.Latitude.ToString.Replace(',','.',[rfReplaceAll])
    + ',' + FAddress.Position.Longitude.ToString.Replace(',','.',[rfReplaceAll]) +
    ',"'+FConfiguracao.VisibleMapToString+'",'+FConfiguracao.Zoom.ToString+',"#ECE9D8","mtHYBRID;mtROADMAP;mtSATELLITE;mtTERRAIN;mtOSM",';
  LStrFun := LStrFun +
    '"scDEFAULT",true,"cpTOP_LEFT",true,"cpTOP_LEFT","zcDEFAULT",false,false,false,false,';
  LStrFun := LStrFun +
    'true,false,"","",false,true,false,"lcWHITE","tuCELSIUS","wsKILOMETERS_PER_HOUR")';
  FBrowser.ExecuteScript(LStrFun);
end;

procedure TGSMaps.LimparListaLocalizacao;
begin
  FListLocalizacao.Clear;
end;

procedure TGSMaps.SetBrowser(const Value: TEdgeBrowser);
begin
  FBrowser := Value;
  if not Assigned(FBrowser) then Exit;
  if (FBrowser <> Value) then  Exit;

  if Assigned(FGeoocoder) then
    FGeoocoder.Free;
  FGeoocoder := TGSMapGeoocoder.Create(FBrowser);

  if Assigned(FEvents) then
    FEvents.Free;
  FEvents := TGsMapEvents.Create(FBrowser);
  FEvents.Geoocoder := FGeoocoder;
end;

end.
