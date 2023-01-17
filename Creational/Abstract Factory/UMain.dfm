object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 248
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbLog: TListBox
    Left = 8
    Top = 8
    Width = 401
    Height = 193
    ItemHeight = 13
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 415
    Top = 8
    Width = 111
    Height = 97
    Caption = 'Elemet'
    TabOrder = 1
    object btnFire: TButton
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Fire'
      TabOrder = 0
      OnClick = btnFireClick
    end
    object btnWater: TButton
      Left = 16
      Top = 55
      Width = 75
      Height = 25
      Caption = 'Water'
      TabOrder = 1
      OnClick = btnWaterClick
    end
  end
  object btnAttack: TButton
    Left = 8
    Top = 207
    Width = 90
    Height = 33
    Caption = 'Attack'
    TabOrder = 2
    OnClick = btnAttackClick
  end
  object btnMove: TButton
    Left = 104
    Top = 207
    Width = 90
    Height = 33
    Caption = 'Move'
    TabOrder = 3
    OnClick = btnMoveClick
  end
end
