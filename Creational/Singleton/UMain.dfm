object FmMain: TFmMain
  Left = 0
  Top = 0
  Caption = 'Singleton Pattern'
  ClientHeight = 554
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 209
    Height = 554
    Align = alLeft
    TabOrder = 0
    object btnGlobalVariable: TButton
      Left = 16
      Top = 24
      Width = 177
      Height = 25
      Caption = 'Global Variable'
      TabOrder = 0
      OnClick = btnGlobalVariableClick
    end
    object btnNewInstance: TButton
      Left = 16
      Top = 55
      Width = 177
      Height = 25
      Caption = 'NewInstance Override'
      TabOrder = 1
      OnClick = btnNewInstanceClick
    end
    object btnNewInstanceRefCount: TButton
      Left = 16
      Top = 86
      Width = 177
      Height = 25
      Caption = 'NewInstance + Ref Count'
      TabOrder = 2
      OnClick = btnNewInstanceRefCountClick
    end
    object btnSingletonFactory: TButton
      Left = 16
      Top = 117
      Width = 177
      Height = 25
      Caption = 'Singleton Factory'
      TabOrder = 3
      OnClick = btnSingletonFactoryClick
    end
  end
  object lbLog: TListBox
    Left = 209
    Top = 0
    Width = 522
    Height = 554
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
end
