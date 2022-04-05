unit View.MapaEdge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX,
  Vcl.Edge, Vcl.StdCtrls, Vcl.ExtCtrls,MSHTML,System.NetEncoding, Vcl.OleCtrls,
  SHDocVw,System.Generics.Collections, Vcl.ComCtrls,
  GSGoogleMaps, GSMap.Geoocoder;

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
    Panel8: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Panel9: TPanel;
    Edit7: TEdit;
    Button7: TButton;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;

    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure EdgeBrowserExecuteScript(Sender: TCustomEdgeBrowser;
      AResult: HRESULT; const AResultObjectAsJson: string);

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
    WkMapa.AddLocalizacao(LKey,FListLocalizacao.Items[LKey]);
    WkMapa.MostrarMapa;
  end;
end;

procedure TfrmEdge.Button2Click(Sender: TObject);
begin
{
  WkMapa.LimparListaLocalizacao;
  WkMapa.AddLocalizacao('-23.6615616447644','-52.625987555105745');
  WkMapa.AddLocalizacao('-23.67582917874805','-52.631512718616406');
  WkMapa.AddLocalizacao('-23.65868520050511','-52.67456933098635');
  WkMapa.AddLocalizacao('-23.674649088290064','-52.60249992396642');
  WkMapa.CriarTodosPoligonos;
}
end;

procedure TfrmEdge.Button3Click(Sender: TObject);
var
  LStrFun:string;
begin
  LStrFun := 'DoMap(41.39963248,2.16794777,"mtROADMAP",10,false,true,true,true, true,0,0,false,"#ECE9D8",true,"mtHYBRID;mtROADMAP;mtSATELLITE;mtTERRAIN;mtOSM","cpTOP_RIGHT",';
  LStrFun := LStrFun+'"mtcDEFAULT",true,true,true,"cpTOP_LEFT",true,"cpTOP_LEFT",true,"cpBOTTOM_LEFT","scDEFAULT",true,"cpTOP_LEFT",true,"cpTOP_LEFT","zcDEFAULT",false,false,false,false,';
  LStrFun := LStrFun+'true,false,"","",false,true,false,"lcWHITE","tuCELSIUS","wsKILOMETERS_PER_HOUR")';
  LStrFun :=  ('MapsControlTransit(true);');

  try
    EdgeBrowser.ExecuteScript(LStrFun);

  except on E: Exception do
    ShowMessage(e.Message);
  end;
  ShowMessage(EdgeBrowser.DocumentTitle);

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
  procedure AfterEndereco(Endereco:TEnderecoCompleto);
                           begin
                              MemoResult.Lines.Clear;
                              MemoResult.Lines.Add(Endereco.Logradouro);
                              MemoResult.Lines.Add(Endereco.Numero);
                              MemoResult.Lines.Add(Endereco.Bairro);
                              MemoResult.Lines.Add(Endereco.Cidade);
                              MemoResult.Lines.Add(Endereco.UF);

                              MemoResult.Lines.Add(Endereco.Pais);
                              MemoResult.Lines.Add(Endereco.Cep);
                           end;

begin
  LEndereco := edtEndereco.Text+','+edtCidade.Text+' '+edtUf.Text;
  WkMapa.Geoocoder.BuscarEndereco(LEndereco,nil);
end;



procedure TfrmEdge.Button7Click(Sender: TObject);
var
  LOrigem:TEndereco;
  LDestino:TEndereco;
begin
  LOrigem.Logradouro := Edit6.Text;
  LOrigem.Endereco := Edit4.Text;
  LOrigem.Numero := Edit5.Text;
  LOrigem.Bairro := Edit2.Text;
  LOrigem.Cidade := Edit3.Text;
  LOrigem.UF := Edit1.Text;

  LDestino.Logradouro := Edit12.Text;
  LDestino.Endereco := Edit10.Text;
  LDestino.Numero := Edit11.Text;
  LDestino.Bairro := Edit8.Text;
  LDestino.Cidade := Edit9.Text;
  LDestino.UF := Edit7.Text;
  WkMapa.Geoocoder.TracarRota(LOrigem,LDestino);
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
end;

procedure TfrmEdge.FormDestroy(Sender: TObject);
begin
  WkMapa.Free;
  FListLocalizacao.Free;
end;

procedure TfrmEdge.FormShow(Sender: TObject);
begin
  WkMapa.CarregarMapa('C:\Projetos\Git\Delphi\GSMaps\src\Resource\Index.html');
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

end.
