unit GSMap.Configuracoes;

interface
  type
  TEnumTypeVisibleMap = (mtHYBRID,mtROADMAP,mtSATELLITE);
  TGSMapConfiguracoes = class
  private
    FZoom: Integer;
    FVisibleMap:TEnumTypeVisibleMap;
    public
    constructor Create();
    destructor Destroy();override;
    function Zoom(AValue:Integer):TGSMapConfiguracoes;overload;
    function Zoom:Integer;overload;
    function VisibleMap(AValue:TEnumTypeVisibleMap):TGSMapConfiguracoes;overload;
    function VisibleMap:TEnumTypeVisibleMap;overload;
    function VisibleMapToString:string;
  end;
implementation

{ TGSMapConfiguracoes }

constructor TGSMapConfiguracoes.Create;
begin
  FZoom := 8;
end;

destructor TGSMapConfiguracoes.Destroy;
begin

  inherited;
end;


function TGSMapConfiguracoes.VisibleMapToString: string;
begin
  case FVisibleMap of
    mtHYBRID: Result := 'mtHYBRID';
    mtROADMAP: Result := 'mtROADMAP';
    mtSATELLITE: Result := 'mtSATELLITE';
  end;
end;

function TGSMapConfiguracoes.VisibleMap: TEnumTypeVisibleMap;
begin
  Result := FVisibleMap;
end;

function TGSMapConfiguracoes.VisibleMap(
  AValue: TEnumTypeVisibleMap): TGSMapConfiguracoes;
begin
  Result := Self;
  FVisibleMap := AValue;
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
