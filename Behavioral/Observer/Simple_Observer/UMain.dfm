object FmMain: TFmMain
  Left = 0
  Top = 0
  Caption = 'FmMain'
  ClientHeight = 307
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    319
    307)
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 13
  end
  object lbLog: TListBox
    Left = 8
    Top = 92
    Width = 303
    Height = 207
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object sedHeat: TSpinEdit
    Left = 223
    Top = 20
    Width = 49
    Height = 22
    MaxValue = 50
    MinValue = -50
    TabOrder = 1
    Value = 30
    OnChange = sedHeatChange
  end
  object sedRain: TSpinEdit
    Left = 223
    Top = 48
    Width = 49
    Height = 22
    MaxValue = 100
    MinValue = 0
    TabOrder = 2
    Value = 5
    OnChange = sedRainChange
  end
  object btnAddLabel: TButton
    Left = 8
    Top = 38
    Width = 75
    Height = 19
    Caption = 'Pripojit Label'
    TabOrder = 3
    OnClick = btnAddLabelClick
  end
  object btnRemLabel: TButton
    Left = 8
    Top = 63
    Width = 75
    Height = 19
    Caption = 'Odpojit Label'
    TabOrder = 4
    OnClick = btnRemLabelClick
  end
  object btnAddLog: TButton
    Left = 96
    Top = 38
    Width = 75
    Height = 19
    Caption = 'Pripojit Log'
    TabOrder = 5
    OnClick = btnAddLogClick
  end
  object btnRemLog: TButton
    Left = 96
    Top = 63
    Width = 75
    Height = 19
    Caption = 'Odpojit Log'
    TabOrder = 6
    OnClick = btnRemLogClick
  end
end
