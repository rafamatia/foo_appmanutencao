unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfMain = class(TForm)
    btDatasetLoop: TButton;
    btThreads: TButton;
    btStreams: TButton;
    procedure btDatasetLoopClick(Sender: TObject);
    procedure btStreamsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure limparMemoria;
  public
  end;

var
  fMain: TfMain;

implementation

uses
  DatasetLoop, ClienteServidor, uMensagens;

{$R *.dfm}

procedure TfMain.btDatasetLoopClick(Sender: TObject);
begin
  fDatasetLoop.Show;
end;

procedure TfMain.btStreamsClick(Sender: TObject);
begin
  fClienteServidor.Show;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LimparMemoria;
  Application.Terminate;
end;

procedure TfMain.limparMemoria;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
    Application.ProcessMessages;
  except
    on E: Exception do
      MensagemErro('Ocorreu um erro ao esvaziar a memória!' + sLineBreak + 'Detalhes Técnicos: ' + E.Message);
  end;
end;

end.
