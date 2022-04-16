unit View.MapaEdge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX,
  Vcl.Edge, Vcl.StdCtrls, Vcl.ExtCtrls,MSHTML,System.NetEncoding, Vcl.OleCtrls,
  SHDocVw,System.Generics.Collections, Vcl.ComCtrls,
  GSGoogleMaps, GSMap.Geoocoder, GSMap.Address, GSMap.Configuracoes;

type

  TfrmEdge = class(TForm)
    EdgeBrowser: TEdgeBrowser;
    Panel1: TPanel;
    Button3: TButton;
    Panel3: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Panel4: TPanel;
    ListBox: TListBox;
    Panel5: TPanel;
    edtLongitude: TEdit;
    edtLatitude: TEdit;
    Button4: TButton;
    MemoResult: TMemo;
    Panel6: TPanel;
    Button5: TButton;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    edtUf: TEdit;
    Button6: TButton;
    edtEndereco: TEdit;
    edtCidade: TEdit;
    TabSheet2: TTabSheet;
    Panel7: TPanel;
    pnlOrigem: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    pnlDestino: TPanel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Button8: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button7: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure EdgeBrowserExecuteScript(Sender: TCustomEdgeBrowser;
      AResult: HRESULT; const AResultObjectAsJson: string);
    procedure Button8Click(Sender: TObject);
    procedure pnlOrigemClick(Sender: TObject);

  private
    WkMapa:TGSMaps;
    FListLocalizacao:TDictionary<string,string>;
    procedure CarregarLista();
    function GetKeySelectList:String;
    procedure AfterExecuteJS(AResult:String);
  public
    { Public declarations }
  end;

var
  frmEdge: TfrmEdge;

implementation

{$R *.dfm}

procedure TfrmEdge.AfterExecuteJS(AResult: String);
begin
  MemoResult.Clear;
  MemoResult.Lines.Add(AResult);
end;

procedure TfrmEdge.Button1Click(Sender: TObject);
var
  LKey:string;
begin
  if (ListBox.ItemIndex < 0) then
    raise Exception.Create('Nenhuma localização selecionada!');

  LKey := GetKeySelectList;
  if(FListLocalizacao.ContainsKey(LKey))then
  begin
    WkMapa.Address.Position.Latitude(LKey)
                           .Longitude(FListLocalizacao.Items[LKey]);
    WkMapa.GoToLacalization;
  end;
end;

procedure TfrmEdge.Button4Click(Sender: TObject);
begin
  if (Trim(edtLatitude.Text) <> EmptyStr) and (Trim(edtLongitude.Text) <> EmptyStr) then
  begin
    FListLocalizacao.Add(edtLatitude.Text,edtLongitude.Text);
    CarregarLista();
    edtLatitude.Text := EmptyStr;
    edtLongitude.Text := EmptyStr;
    edtLatitude.SetFocus;
  end;
end;

procedure TfrmEdge.Button6Click(Sender: TObject);
var
  LEndereco:string;
begin
  WkMapa.Address.Localization.Logradouro('Rua')
                             .Endereco(edtEndereco.Text)
                             .Numero('662')
                             .Cidade(edtCidade.Text)
                             .UF(edtUf.Text);
  WkMapa.Geoocoder.BuscarEndereco(WkMapa.Address.Localization.AdrressToString());
end;



procedure TfrmEdge.Button7Click(Sender: TObject);
begin
  WkMapa.Geoocoder.Origem.Logradouro := Edit6.Text;
  WkMapa.Geoocoder.Origem.Endereco := Edit4.Text;
  WkMapa.Geoocoder.Origem.Numero := Edit5.Text;
  WkMapa.Geoocoder.Origem.Bairro := Edit2.Text;
  WkMapa.Geoocoder.Origem.Cidade := Edit3.Text;
  WkMapa.Geoocoder.Origem.UF := Edit1.Text;

  WkMapa.Geoocoder.Destino.Logradouro := Edit12.Text;
  WkMapa.Geoocoder.Destino.Endereco := Edit10.Text;
  WkMapa.Geoocoder.Destino.Numero := Edit11.Text;
  WkMapa.Geoocoder.Destino.Bairro := Edit8.Text;
  WkMapa.Geoocoder.Destino.Cidade := Edit9.Text;
  WkMapa.Geoocoder.Destino.UF := Edit7.Text;
  WkMapa.Geoocoder.TracarRota();
end;

procedure TfrmEdge.Button8Click(Sender: TObject);
begin
  WkMapa.GoToLacalization;
end;

procedure TfrmEdge.CarregarLista;
var
  LKey:string;
begin
  ListBox.Items.Clear;
  for LKey in FListLocalizacao.Keys do
  begin
    ListBox.Items.Add(LKey +' | '+ FListLocalizacao.Items[LKey]);
  end;
end;

procedure TfrmEdge.EdgeBrowserExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HRESULT; const AResultObjectAsJson: string);
begin
  ShowMessage(AResultObjectAsJson);
end;

procedure TfrmEdge.FormCreate(Sender: TObject);
begin
  WkMapa := TGSMaps.Create;
  WkMapa.Browser := EdgeBrowser;
  FListLocalizacao := TDictionary<string,string>.Create;
  FListLocalizacao.Add('-23.6615616447644','-52.625987555105745');
  FListLocalizacao.Add('-23.67582917874805','-52.631512718616406');
  FListLocalizacao.Add('-23.65868520050511','-52.67456933098635');
  FListLocalizacao.Add('-23.674649088290064','-52.60249992396642');
  CarregarLista;
  WkMapa.Events.AfterExecuteScript := AfterExecuteJS;
  WkMapa.Configuracao
          .VisibleMap(TEnumTypeVisibleMap.mtHYBRID)
          .Zoom(16);
  WkMapa.Address.Position.Latitude(-23.656805337778664)
                         .Longitude(-52.6098084658812);
  WkMapa.GoToLacalization;
  WkMapa.GoToLacalization;
end;

procedure TfrmEdge.FormDestroy(Sender: TObject);
begin
  WkMapa.Free;
  FListLocalizacao.Free;
end;

procedure TfrmEdge.FormShow(Sender: TObject);
begin
  WkMapa.LoadMap('C:\Projetos\Git\Delphi\GSMaps\src\Resource\Index.html');
end;

function TfrmEdge.GetKeySelectList: String;
var
  LItem:string;
  LPos:Integer;
begin
  if(ListBox.ItemIndex <0)then Exit;

  LItem := ListBox.Items[ListBox.ItemIndex];
  LPos := Pos('|',LItem)-2;
  Result := Copy(LItem,1,LPos).Trim;
end;
procedure TfrmEdge.pnlOrigemClick(Sender: TObject);
begin

end;

{
  WkMapa.LimparListaLocalizacao;
  WkMapa.AddLocalizacao('-23.6615616447644','-52.625987555105745');
  WkMapa.AddLocalizacao('-23.67582917874805','-52.631512718616406');
  WkMapa.AddLocalizacao('-23.65868520050511','-52.67456933098635');
  WkMapa.AddLocalizacao('-23.674649088290064','-52.60249992396642');
  WkMapa.CriarTodosPoligonos;
}

end.
