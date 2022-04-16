program Maps;

uses
  Vcl.Forms,
  View.MapaEdge in 'src\View\View.MapaEdge.pas' {frmEdge},
  View.Teste in 'src\View\View.Teste.pas' {Form1},
  GSGoogleMaps in 'src\Model\GSGoogleMaps.pas',
  GSMap.Configuracoes in 'src\Model\GSMap.Configuracoes.pas',
  GSMap.Geoocoder in 'src\Model\GSMap.Geoocoder.pas',
  GSMap.Address in 'src\Model\GSMap.Address.pas',
  GSMap.Events in 'src\Model\GSMap.Events.pas',
  GSMap.Geoocoder.Configuration in 'src\Model\GSMap.Geoocoder.Configuration.pas',
  GSMap.Position in 'src\Model\Localization\GSMap.Position.pas',
  GSMap.Localization in 'src\Model\Localization\GSMap.Localization.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmEdge, frmEdge);
  //Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
