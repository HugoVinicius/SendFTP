object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Envio FTP'
  ClientHeight = 553
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 713
    Height = 161
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBoxConfiguracao: TGroupBox
      Left = 9
      Top = 8
      Width = 448
      Height = 153
      Caption = ' Configura'#231#227'o '
      TabOrder = 0
      object LabelHost: TLabel
        Left = 16
        Top = 24
        Width = 22
        Height = 13
        Caption = 'Host'
      end
      object LabelUsuario: TLabel
        Left = 16
        Top = 48
        Width = 36
        Height = 13
        Caption = 'Usu'#225'rio'
      end
      object LabelSenha: TLabel
        Left = 16
        Top = 80
        Width = 30
        Height = 13
        Caption = 'Senha'
      end
      object EditHost: TEdit
        Left = 56
        Top = 21
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object EditUsuario: TEdit
        Left = 56
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object EditSenha: TEdit
        Left = 56
        Top = 77
        Width = 121
        Height = 21
        PasswordChar = '#'
        TabOrder = 2
      end
      object ButtonConnectar: TButton
        Left = 40
        Top = 104
        Width = 161
        Height = 38
        Caption = 'Conectar'
        TabOrder = 3
        OnClick = ButtonConnectarClick
      end
      object RadioGroupModoTransferencia: TRadioGroup
        Left = 200
        Top = 13
        Width = 233
        Height = 56
        Caption = 'Modo de Transfer'#234'ncia'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Padr'#227'o'
          'Ativo'
          'Passivo')
        TabOrder = 4
      end
      object ButtonDisconectar: TButton
        Left = 216
        Top = 104
        Width = 161
        Height = 38
        Caption = 'Desconectar'
        Enabled = False
        TabOrder = 5
        OnClick = ButtonDisconectarClick
      end
    end
    object btnUpload: TButton
      Left = 512
      Top = 112
      Width = 161
      Height = 38
      Caption = 'Upload'
      Enabled = False
      TabOrder = 1
      OnClick = btnUploadClick
    end
  end
  object MemoRelatorio: TMemo
    Left = 0
    Top = 161
    Width = 713
    Height = 392
    Align = alClient
    TabOrder = 1
  end
  object IdFTP1: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 256
    Top = 80
  end
  object OpenDialog1: TOpenDialog
    Left = 352
    Top = 280
  end
end
