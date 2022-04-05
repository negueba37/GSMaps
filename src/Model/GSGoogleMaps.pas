unit GSGoogleMaps;

interface

uses
  Vcl.Edge, System.Generics.Collections, System.Classes, System.SysUtils,
  System.JSON, Rest.JSON, StrUtils, GSMap.Configuracoes, GSMap.Geoocoder,
  GSMap.Events;

type
  TEnumTipoMap = (Defaut, Satelite);

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
    FMapa: TEnumTipoMap;
    FConfiguracao: TGSMapConfiguracoes;
    FGeoocoder: TGSMapGeoocoder;
    FEvents: TGsMapEvents;
    procedure SetBrowser(const Value: TEdgeBrowser);
    procedure OnTracarRota(AJSON: TJSONObject);
    procedure SetMapa(const Value: TEnumTipoMap);
  public
    constructor Create();
    destructor Destroy(); override;
    function Configuracao: TGSMapConfiguracoes;
    function Geoocoder: TGSMapGeoocoder;
    function Events:TGsMapEvents;
    procedure CarregarMapa(AUrl: string);
    Procedure AddLocalizacao(ALatitude, ALongitude: string);
    procedure LimparListaLocalizacao();
    procedure MostrarLocalidades();
    procedure MostrarMapa();
    procedure CriarTodosPoligonos();
    // procedure de callback
  published
    property Browser: TEdgeBrowser write SetBrowser;
    property Mapa: TEnumTipoMap read FMapa write SetMapa;

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

procedure TGSMaps.CarregarMapa(AUrl: string);
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

procedure TGSMaps.LimparListaLocalizacao;
begin
  FListLocalizacao.Clear;
end;

procedure TGSMaps.MostrarLocalidades;
begin
  FBrowser.ExecuteScript('');
end;

procedure TGSMaps.MostrarMapa;
var
  LStrFun: string;
begin
  LStrFun := 'DoMap(' + FListLocalizacao[pred(FListLocalizacao.Count)].Latitude
    + ',' + FListLocalizacao[pred(FListLocalizacao.Count)].Longitude +
    ',"mtROADMAP",10,false,true,true,true, true,0,0,false,"#ECE9D8",true,"mtHYBRID;mtROADMAP;mtSATELLITE;mtTERRAIN;mtOSM","cpTOP_RIGHT",';
  LStrFun := LStrFun +
    '"mtcDEFAULT",true,true,true,"cpTOP_LEFT",true,"cpTOP_LEFT",true,"cpBOTTOM_LEFT","scDEFAULT",true,"cpTOP_LEFT",true,"cpTOP_LEFT","zcDEFAULT",false,false,false,false,';
  LStrFun := LStrFun +
    'true,false,"","",false,true,false,"lcWHITE","tuCELSIUS","wsKILOMETERS_PER_HOUR")';
  FBrowser.ExecuteScript(LStrFun);
end;

procedure TGSMaps.OnTracarRota(AJSON: TJSONObject);
begin
  //
end;

procedure TGSMaps.SetBrowser(const Value: TEdgeBrowser);
begin
  FBrowser := Value;
  if not Assigned(FBrowser) then
    Exit;
  if (FBrowser <> Value) then
    Exit;
  // TEdgeBrowser(FBrowser).OnExecuteScript := OnExecuteScript;

  if Assigned(FGeoocoder) then
    FGeoocoder.Free;
  FGeoocoder := TGSMapGeoocoder.Create(FBrowser);

  if Assigned(FEvents) then
    FEvents.Free;
  FEvents := TGsMapEvents.Create(FBrowser);
  FEvents.Geoocoder := FGeoocoder;
end;

procedure TGSMaps.SetMapa(const Value: TEnumTipoMap);
begin
  FMapa := Value;
end;

end.
