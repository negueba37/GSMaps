unit GSMap.Configuracoes;

interface
  type
  TGSMapConfiguracoes = class
  private
    FZoom: Integer;
    public
    constructor Create();
    destructor Destroy();override;
    function Zoom(AValue:Integer):TGSMapConfiguracoes;overload;
    function Zoom:Integer;overload;
  end;
implementation

{ TGSMapConfiguracoes }


{ TGSMapConfiguracoes }

constructor TGSMapConfiguracoes.Create;
begin
  FZoom := 8;
end;

destructor TGSMapConfiguracoes.Destroy;
begin

  inherited;
end;

function TGSMapConfiguracoes.Zoom: Integer;
begin
  Result := FZoom;
end;

function TGSMapConfiguracoes.Zoom(AValue: Integer):TGSMapConfiguracoes;
begin
  Result := Self;
  FZoom := AValue;
end;

end.
