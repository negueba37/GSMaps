unit GSMap.Geoocoder;

interface

uses
  System.SysUtils, Vcl.Edge, System.JSON;

type
TEnderecoCompleto = record
      Logradouro: string;
      Numero: string;
      Bairro: string;
      Cidade: string;
      UF: string;
      Pais: string;
      Cep: string;
    end;
    TEndereco = record
      Logradouro: string;
      Endereco:string;
      Numero: string;
      Bairro: string;
      Cidade: string;
      UF: string;
    end;
  TGSMapGeoocoder = class
  private
   FBuscarEndereco: TProc<TEnderecoCompleto>;
   FBrowser:TEdgeBrowser;
    procedure SetBrowser(const Value: TEdgeBrowser);
  public
    constructor Create(ABrowser:TEdgeBrowser)overload;
    destructor Destroy; override;
    function AddRoute:TGSMapGeoocoder;
    function RemoveRoute:TGSMapGeoocoder;
    procedure OnBuscarEndereco(AJSON:TJSONObject);overload;
    procedure BuscarEndereco(ADescricao: string; AProc: TProc<TEnderecoCompleto>);
    procedure TracarRota(AOrigem,ADestino:TEndereco;AProc:TProc<TEndereco> = nil);
    function EnderecoParaString(Endereco:TEndereco):String;
  end;

implementation

{ TGSMapGeoocoder }

function TGSMapGeoocoder.AddRoute: TGSMapGeoocoder;
begin
  Result := Self;
end;

procedure TGSMapGeoocoder.BuscarEndereco(ADescricao: string;
  AProc: TProc<TEnderecoCompleto>);
begin
  if Assigned(AProc) then
    FBuscarEndereco := AProc;
  if not Assigned(FBrowser)  then Exit;
  TEdgeBrowser(FBrowser).ExecuteScript('GetGeocoder("'+ADescricao+'", -1, -1, "pt", -1, -1, -1, -1, "pt")');
  Sleep(500);
  FBrowser.ExecuteScript('GetGeocoderdata();');
end;


constructor TGSMapGeoocoder.Create(ABrowser:TEdgeBrowser);
begin
  if not Assigned(ABrowser) then
    raise Exception.Create('Browser não informado ! x0716');
  FBrowser := ABrowser;
end;

destructor TGSMapGeoocoder.Destroy;
begin

  inherited;
end;

function TGSMapGeoocoder.EnderecoParaString(Endereco: TEndereco): String;
var
  LResult:String;
begin
  Result := Endereco.Logradouro+' '+Endereco.Endereco+' '+Endereco.Numero+' ';
  Result := Result+Endereco.Bairro+' '+Endereco.Cidade+' '+Endereco.UF;
end;

procedure TGSMapGeoocoder.OnBuscarEndereco(AJSON: TJSONObject);
var
  LEnderecoCompleto:TEnderecoCompleto;
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

function TGSMapGeoocoder.RemoveRoute: TGSMapGeoocoder;
begin
  Result := Self;
end;

procedure TGSMapGeoocoder.SetBrowser(const Value: TEdgeBrowser);
begin
  FBrowser := Value;
end;

procedure TGSMapGeoocoder.TracarRota(AOrigem, ADestino: TEndereco;
  AProc: TProc<TEndereco>);
var
  LOrigem,LDestino:string;
begin
  LOrigem := EnderecoParaString(AOrigem);
  LDestino := EnderecoParaString(ADestino);
  FBrowser.ExecuteScript('GetDirectionsRoute('+QuotedStr(LOrigem)+','+QuotedStr(LDestino)+');');
end;

end.
