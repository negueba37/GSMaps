unit GSMap.Localization;

interface

type
  TGSMapAddress = class
  private
    FLogradouro: string;
    FEndereco: string;
    FNumero: string;
    FBairro: string;
    FCidade: string;
    FUF: string;
  public
    function Logradouro: string;overload;
    function Logradouro(AValue:string): TGSMapAddress;overload;
    function Endereco(AValue:string): TGSMapAddress;overload;
    function Endereco: string;overload;
    function Numero: string;overload;
    function Numero(AValue:string): TGSMapAddress;overload;
    function Bairro: string;overload;
    function Bairro(AValue:string): TGSMapAddress;overload;
    function Cidade: string;overload;
    function Cidade(AValue:string): TGSMapAddress;overload;
    function UF: string;overload;
    function UF(AValue:string): TGSMapAddress;overload;
    function AdrressToString: string;overload;
  end;

implementation

{ TGSMapAddress }

function TGSMapAddress.AdrressToString: string;
var
  LResult:String;
begin
  Result := Logradouro+' '+Endereco+' '+Numero+' ';
  Result := Result+Bairro+' '+Cidade+' '+UF;
end;

function TGSMapAddress.Bairro: string;
begin
  Result := FBairro;
end;

function TGSMapAddress.Bairro(AValue: string): TGSMapAddress;
begin
  Result:= Self;
  FBairro := AValue;
end;

function TGSMapAddress.Cidade(AValue: string): TGSMapAddress;
begin
  Result:= Self;
  FCidade := AValue;
end;

function TGSMapAddress.Cidade: string;
begin
  Result := FCidade
end;

function TGSMapAddress.Endereco: string;
begin
  Result := FEndereco;
end;

function TGSMapAddress.Endereco(AValue: string): TGSMapAddress;
begin
  Result:= Self;
  FEndereco := AValue;
end;

function TGSMapAddress.Logradouro: string;
begin
  Result := FLogradouro;
end;

function TGSMapAddress.Logradouro(AValue: string): TGSMapAddress;
begin
  Result:= Self;
  FLogradouro := AValue;
end;

function TGSMapAddress.Numero: string;
begin
  Result := FNumero;
end;

function TGSMapAddress.Numero(AValue: string): TGSMapAddress;
begin
  Result:= Self;
  FNumero := AValue;
end;

function TGSMapAddress.UF: string;
begin
  Result := FUF;
end;

function TGSMapAddress.UF(AValue: string): TGSMapAddress;
begin
  Result:= Self;
  FUF := AValue;
end;

end.
