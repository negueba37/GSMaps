unit GSMap.Address;

interface

uses GSMap.Position, GSMap.Localization;
  type
  TGSMapAddres = class
      Logradouro: string;
      Endereco:string;
      Numero: string;
      Bairro: string;
      Cidade: string;
      UF: string;

  end;

  TGSMapCompleteAddress = record
      Logradouro: string;
      Numero: string;
      Bairro: string;
      Cidade: string;
      UF: string;
      Pais: string;
      Cep: string;
  end;
    TGSMapAddressOrigemDestino = class
      private
      public
      var
      Logradouro: string;
      Endereco:string;
      Numero: string;
      Bairro: string;
      Cidade: string;
      UF: string;
      function AdrressToString:string;
  end;
  TGSMapAddressMap = class
    private
    FLocalization:TGSMapAddress;
    FPosition:TGSMapPosition;
    public
    function Localization:TGSMapAddress;
    function Position:TGSMapPosition;
    constructor Create;
    destructor Destroy;override;
  end;


implementation

{ TGSMapAddressOrigemDestino }

function TGSMapAddressOrigemDestino.AdrressToString: string;
var
  LResult:String;
begin
  Result := Logradouro+' '+Endereco+' '+Numero+' ';
  Result := Result+Bairro+' '+Cidade+' '+UF;
end;

{ TGSMapAddressMap }
constructor TGSMapAddressMap.Create;
begin
  FLocalization := TGSMapAddress.Create;
  FPosition := TGSMapPosition.Create;
end;

destructor TGSMapAddressMap.Destroy;
begin
  if Assigned(FLocalization) then
    FLocalization.Free;
  if Assigned(FPosition) then
    FPosition.Free;
  inherited;
end;

function TGSMapAddressMap.Localization: TGSMapAddress;
begin
  Result := FLocalization;
end;


function TGSMapAddressMap.Position: TGSMapPosition;
begin
  Result := FPosition;
end;

end.
