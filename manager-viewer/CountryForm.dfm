object fmCountry: TfmCountry
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Country'
  ClientHeight = 74
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    263
    74)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 12
    Width = 14
    Height = 13
    Caption = 'Id:'
  end
  object Label2: TLabel
    Left = 13
    Top = 39
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object edId: TEdit
    Left = 69
    Top = 9
    Width = 97
    Height = 21
    TabOrder = 0
    Text = 'edId'
    OnChange = edIdChange
  end
  object edName: TEdit
    Left = 69
    Top = 36
    Width = 182
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'edName'
    OnChange = edNameChange
    ExplicitWidth = 172
  end
end
