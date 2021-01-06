unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    GroupBoxConfiguracao: TGroupBox;
    LabelHost: TLabel;
    EditHost: TEdit;
    LabelUsuario: TLabel;
    LabelSenha: TLabel;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    ButtonConnectar: TButton;
    IdFTP1: TIdFTP;
    RadioGroupModoTransferencia: TRadioGroup;
    MemoRelatorio: TMemo;
    ButtonDisconectar: TButton;
    btnUpload: TButton;
    OpenDialog1: TOpenDialog;
    procedure ButtonConnectarClick(Sender: TObject);
    procedure habilitaBotoes();
    procedure ButtonDisconectarClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
  private
    { Private declarations }
    diretorioLeitura : String;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.btnUploadClick(Sender: TObject);
var
  m : TStream;
  f : TStream;
  t : Cardinal;
  Nome_Arquivo, Auxiliar :String;
  contador : Integer;
begin
   Auxiliar := EmptyStr;
   f := nil;
   m := nil;
   MemoRelatorio.Lines.Add('Diretório original: ' + diretorioLeitura);
   OpenDialog1.Filter := 'Arquivos(*.*)|*.*';

   if OpenDialog1.Execute then
   begin
      Nome_Arquivo := OpenDialog1.FileName;

      MemoRelatorio.Lines.Add ('Operação: troca de diretório local');
      MemoRelatorio.Lines.Add ('Diretório do arquivo: ' + GetCurrentDir);
      MemoRelatorio.Lines.Add ('');

      Nome_Arquivo := AnsiStrRScan(PCHar(Nome_Arquivo), '\');
      for contador := 2 To StrLen(PCHar(Nome_Arquivo)) do
          Auxiliar := Auxiliar + Nome_Arquivo [contador];

      Nome_Arquivo := Auxiliar;

      try
         MemoRelatorio.Lines.Add('Operação: Upload');
         MemoRelatorio.Lines.Add ('Arquivo local: ' + OpenDialog1.FileName);
         MemoRelatorio.Lines.Add ('Gravado como: ' + Nome_Arquivo);

         f := TFileStream.Create(OpenDialog1.FileName,fmOpenRead);
         m := TMemoryStream.Create;
         m.CopyFrom(f,f.Size);
         m.Seek(0,0) ;
         t := GetTickCount;
         idFTP1.Put(m,'/Nfe/Entrada/' + Nome_Arquivo, true);

         MemoRelatorio.Lines.Add(Format('tempo %d milesegundos',[GetTickCount - t]));
         MemoRelatorio.Lines.Add(Format('Tamanho %d bytes',[m.Size]));
         MemoRelatorio.Lines.Add('');
      finally
         m.Free;
         f.Free;
      end;

      SetCurrentDir (diretorioLeitura);
      MemoRelatorio.Lines.Add('Operação: troca de diretorio local');
      MemoRelatorio.Lines.Add ('Diretório após a operação: ' + GetCurrentDir);
      MemoRelatorio.Lines.Add ('');
   end;
end;

procedure TFrmPrincipal.ButtonConnectarClick(Sender: TObject);
begin
   try
      IdFTP1.Host := EditHost.Text;
      IdFTP1.Username := EditUsuario.Text;
      IdFTP1.Password := EditSenha.Text;

      if RadioGroupModoTransferencia.ItemIndex = 2 then
      begin
        IdFTP1.PassiveUseControlHost := True;
        IdFTP1.Passive := True;
      end;

      IdFTP1.Connect;

      if IdFTP1.Connected then
      begin
        MemoRelatorio.Lines.Add('Conectado ao endereço: ' + idFTP1.Host);
        MemoRelatorio.Lines.Add('Servidor remoto: ' + idFTP1.SystemDesc);
        MemoRelatorio.Lines.Add('');
      end;
   except on E: Exception do
     begin
        MemoRelatorio.Lines.Add('Erro na conexão: ' + E.Message);
     end;
   end;

   habilitaBotoes();
end;

procedure TFrmPrincipal.ButtonDisconectarClick(Sender: TObject);
begin
   idFTP1.Disconnect;
   MemoRelatorio.Lines.Add('Desconectado');

   habilitaBotoes();
end;

procedure TFrmPrincipal.habilitaBotoes();
begin
   ButtonConnectar.Enabled := not IdFTP1.Connected;
   ButtonDisconectar.Enabled := not ButtonConnectar.Enabled;
   btnUpload.Enabled := not ButtonConnectar.Enabled;
end;

end.
