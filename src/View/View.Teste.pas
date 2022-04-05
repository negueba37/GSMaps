unit View.Teste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Winapi.WebView2,
  Winapi.ActiveX, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, Vcl.Edge;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    EdgeBrowser1: TEdgeBrowser;
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  EdgeBrowser1.Navigate('file:///C:/WkTechnology/TesteHTML/Componente/Index.html');
  WebBrowser1.Navigate('file:///C:/WkTechnology/TesteHTML/Componente/Index.html');
end;

end.
