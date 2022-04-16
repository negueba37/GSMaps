unit GSMap.Geoocoder;

interface

uses
  System.SysUtils, Vcl.Edge, System.JSON, GSMap.Address,
  GSMap.Geoocoder.Configuration, GSMap.Localization;

type
  TGSMapGeoocoder = class
  private
   FBuscarEndereco: TProc<TGSMapCompleteAddress>;
   FOrigem:TGSMapAddressOrigemDestino;
   FDestino:TGSMapAddressOrigemDestino;
   FConfiguration:TGSMapGeoocoderConfiguration;
   FBrowser:TEdgeBrowser;
    procedure SetBrowser(const Value: TEdgeBrowser);
  public
    constructor Create(ABrowser:TEdgeBrowser)overload;
    destructor Destroy; override;
    function Configuration:TGSMapGeoocoderConfiguration;
    function AddRoute:TGSMapGeoocoder;
    function Origem:TGSMapAddressOrigemDestino;
    function Destino:TGSMapAddressOrigemDestino;
    function RemoveRoute:TGSMapGeoocoder;
    procedure OnBuscarEndereco(AJSON:TJSONObject);overload;
    procedure BuscarEndereco(ADescricao: string;
  AProc: TProc<TGSMapCompleteAddress> = nil);
    procedure TracarRota(AProc:TProc<TGSMapAddress> = nil);
  end;

implementation

{ TGSMapGeoocoder }

function TGSMapGeoocoder.AddRoute: TGSMapGeoocoder;
begin
  Result := Self;
end;

procedure TGSMapGeoocoder.BuscarEndereco(ADescricao: string;
  AProc: TProc<TGSMapCompleteAddress> = nil);
begin
  if Assigned(AProc) then
    FBuscarEndereco := AProc;
  if not Assigned(FBrowser)  then Exit;
  TEdgeBrowser(FBrowser).ExecuteScript('GetGeocoder("'+ADescricao+'", -1, -1, "pt", -1, -1, -1, -1, "pt")');
  Sleep(500);
  FBrowser.ExecuteScript('GetGeocoderdata();');
end;


function TGSMapGeoocoder.Configuration: TGSMapGeoocoderConfiguration;
begin

end;

constructor TGSMapGeoocoder.Create(ABrowser:TEdgeBrowser);
begin
  if not Assigned(ABrowser) then
    raise Exception.Create('Browser não informado ! x0716');
  FBrowser := ABrowser;
  FOrigem := TGSMapAddressOrigemDestino.Create;
  FDestino := TGSMapAddressOrigemDestino.Create;
  FConfiguration := TGSMapGeoocoderConfiguration.Create
end;

function TGSMapGeoocoder.Destino: TGSMapAddressOrigemDestino;
begin
  Result := FDestino;
end;

destructor TGSMapGeoocoder.Destroy;
begin
  FOrigem.Free;
  FDestino.Free;
  FConfiguration.Free;
  inherited;
end;

procedure TGSMapGeoocoder.OnBuscarEndereco(AJSON: TJSONObject);
var
  LEnderecoCompleto:TGSMapCompleteAddress;
  LJSONObject:TJSONObject;
  I: Integer;
begin
  if not Assigned(AJSON) then Exit;
  LJSONObject := AJSON.GetValue<TJSONObject>('GetGeocoderdata').GetValue<TJSONObject>('Endereco');
  LJSONObject.TryGetValue<string>('Logradouro',LEnderecoCompleto.Logradouro);
  LJSONObject.TryGetValue<string>('Numero',LEnderecoCompleto.Numero);
  LJSONObject.TryGetValue<string>('Bairro',LEnderecoCompleto.Bairro);
  LJSONObject.TryGetValue<string>('Cidade',LEnderecoCompleto.Cidade);
  LJSONObject.TryGetValue<string>('UF',LEnderecoCompleto.UF);
  LJSONObject.TryGetValue<string>('Pais',LEnderecoCompleto.Pais);
  LJSONObject.TryGetValue<string>('Cep',LEnderecoCompleto.Cep);

  if Assigned(FBuscarEndereco) then
    FBuscarEndereco(LEnderecoCompleto);
end;

function TGSMapGeoocoder.Origem: TGSMapAddressOrigemDestino;
begin
  Result := FOrigem;
end;

function TGSMapGeoocoder.RemoveRoute: TGSMapGeoocoder;
begin
  Result := Self;
end;

procedure TGSMapGeoocoder.SetBrowser(const Value: TEdgeBrowser);
begin
  FBrowser := Value;
end;

procedure TGSMapGeoocoder.TracarRota(AProc:TProc<TGSMapAddress> = nil);
begin
  FBrowser.ExecuteScript('GetDirectionsRoute('+QuotedStr(FOrigem.AdrressToString)+','+QuotedStr(FDestino.AdrressToString)+');');
end;

end.
