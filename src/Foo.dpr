program Foo;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fMain},
  DatasetLoop in 'DatasetLoop.pas' {fDatasetLoop},
  ClienteServidor in 'ClienteServidor.pas' {fClienteServidor},
  uMensagens in 'uMensagens.pas',
  uRotinas in 'uRotinas.pas';

{$R *.res}

begin
  Application.Initialize;

  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfDatasetLoop, fDatasetLoop);
  Application.CreateForm(TfClienteServidor, fClienteServidor);
  Application.Run;
end.
