object frmBuscaCEP: TfrmBuscaCEP
  Left = 0
  Top = 0
  Caption = 'Busca CEP'
  ClientHeight = 258
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 69
    Height = 13
    Caption = 'Informe o CEP'
  end
  object Label2: TLabel
    Left = 10
    Top = 57
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  object edtCEP: TEdit
    Left = 99
    Top = 21
    Width = 94
    Height = 21
    TabOrder = 0
  end
  object memEndereco: TMemo
    Left = 8
    Top = 72
    Width = 393
    Height = 177
    TabOrder = 1
  end
  object btnPesquisarCEP: TBitBtn
    Left = 216
    Top = 19
    Width = 113
    Height = 25
    Caption = 'Consultar CEP'
    TabOrder = 2
    OnClick = btnPesquisarCEPClick
  end
end
