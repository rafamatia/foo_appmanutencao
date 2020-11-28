unit ClienteServidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Datasnap.DBClient, Data.DB, uMensagens, uRotinas;

type
  TServidor = class
  private
    FPath: AnsiString;
  public
    constructor Create;
    // Tipo do parâmetro não pode ser alterado
    function SalvarArquivos(AData: OleVariant): Boolean;
  end;

  TfClienteServidor = class(TForm)
    ProgressBar: TProgressBar;
    btEnviarSemErros: TButton;
    btEnviarComErros: TButton;
    btEnviarParalelo: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btEnviarSemErrosClick(Sender: TObject);
    procedure btEnviarComErrosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FPath: AnsiString;
    FServidor: TServidor;

    function InitDataset: TClientDataset;
  public
  end;

var
  fClienteServidor: TfClienteServidor;

const
  QTD_ARQUIVOS_ENVIAR = 100;

implementation

uses
  IOUtils;

{$R *.dfm}

procedure TfClienteServidor.btEnviarComErrosClick(Sender: TObject);
var
  cds: TClientDataset;
  i: Integer;
begin
  cds := InitDataset;
  for i := 0 to QTD_ARQUIVOS_ENVIAR do
  begin
    cds.Append;
    TBlobField(cds.FieldByName('Arquivo')).LoadFromFile(String(FPath));
    cds.Post;

{$REGION Simulação de erro, não alterar}
    if i = (QTD_ARQUIVOS_ENVIAR / 2) then
      FServidor.SalvarArquivos(NULL);
{$ENDREGION}
  end;

  FServidor.SalvarArquivos(cds.Data);
end;

procedure TfClienteServidor.btEnviarSemErrosClick(Sender: TObject);
var
  cds: TClientDataset;
  intFor: Integer;
  Inicio, Fim: Cardinal;
  Tempo: Extended;
begin
  if (not(FileExists(String(FPath)))) then
  begin
    MensagemAviso('Atenção! Não é possível enviar o arquivo ao servidor, pois o arquivo "' + String(FPath) + '" não existe.' + sLineBreak + 'Adicione o arquivo no caminho demonstrado nesta mensagem, e tente novamente.');
    Exit;
  end;

  try
    Inicio := GetTickCount;
    cds := InitDataset;
    try
      for intFor := 0 to QTD_ARQUIVOS_ENVIAR do
      begin
        cds.Append;
        TBlobField(cds.FieldByName('Arquivo')).LoadFromFile(String(FPath));
        TIntegerField(cds.FieldByName('id')).AsInteger := intFor;
        cds.Post;

        try
          FServidor.SalvarArquivos(cds.Data);
        finally
          cds.EmptyDataSet;
        end;
      end;

      Fim := GetTickCount;
      Tempo := (Fim - Inicio);
      MensagemInformacao('Arquivos Enviados ao Servidor com Sucesso!' + sLineBreak + 'Tempo de processamento: ' + retornarTempoPorExtenso(Tempo));
    finally
      FreeAndNil(cds);
    end;
  except
    on E: Exception do
      MensagemErro('Ocorreu um erro ao enviar os arquivos ao servidor!' + sLineBreak + sLineBreak + 'Detalhes Técnicos:' + sLineBreak + E.Message);
  end;
end;

procedure TfClienteServidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (FServidor <> nil) then
    FreeAndNil(FServidor);
end;

procedure TfClienteServidor.FormCreate(Sender: TObject);
begin
  inherited;
  FPath := AnsiString(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'pdf.pdf');
  FServidor := TServidor.Create;
end;

function TfClienteServidor.InitDataset: TClientDataset;
begin
  Result := TClientDataset.Create(nil);
  Result.FieldDefs.Add('Arquivo', ftBlob);
  Result.FieldDefs.Add('id', ftInteger);
  Result.CreateDataSet;
end;

{ TServidor }

constructor TServidor.Create;
begin
  FPath := AnsiString(ExtractFilePath(ParamStr(0)) + 'Servidor\');
end;

function TServidor.SalvarArquivos(AData: OleVariant): Boolean;
var
  cds: TClientDataset;
  FileName: string;
begin
  Result := False;
  try
    cds := TClientDataset.Create(nil);
    try
      cds.Data := AData;

{$REGION Simulação de erro, não alterar}
      if cds.RecordCount = 0 then
        Exit;
{$ENDREGION}
      if not DirectoryExists(String(FPath)) then
        ForceDirectories(String(FPath));

      cds.First;

      while not cds.Eof do
      begin
        FileName := String(FPath) + TIntegerField(cds.FieldByName('id')).AsString + '.pdf';

        if TFile.Exists(FileName) then
          TFile.Delete(FileName);

        TBlobField(cds.FieldByName('Arquivo')).SaveToFile(FileName);
        cds.Next;
      end;

      Result := True;
    finally
      FreeAndNil(cds);
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
