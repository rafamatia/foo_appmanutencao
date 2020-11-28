object fDatasetLoop: TfDatasetLoop
  Left = 0
  Top = 0
  Caption = 'Dataset Loop'
  ClientHeight = 281
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid: TDBGrid
    Left = 16
    Top = 72
    Width = 441
    Height = 201
    DataSource = DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btDeletarPares: TButton
    Left = 16
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Deletar pares'
    TabOrder = 1
    OnClick = btDeletarParesClick
  end
  object DBNavigator: TDBNavigator
    Left = 16
    Top = 41
    Width = 240
    Height = 25
    DataSource = DataSource
    TabOrder = 2
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Field1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Field2'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 312
    Top = 152
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 392
    Top = 152
  end
end
