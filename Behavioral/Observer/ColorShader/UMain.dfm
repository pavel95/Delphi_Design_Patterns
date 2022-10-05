object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 370
  ClientWidth = 910
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
  object Label1: TLabel
    Left = 400
    Top = 96
    Width = 31
    Height = 13
    Caption = 'Label1'
    Color = clBtnFace
    ParentColor = False
    Transparent = False
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 529
    Height = 329
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      Left = 24
      Top = 88
      Width = 235
      Height = 209
      ParentBackground = False
      TabOrder = 0
      object Panel3: TPanel
        Left = 16
        Top = 56
        Width = 201
        Height = 129
        ParentBackground = False
        TabOrder = 0
      end
      object Edit1: TEdit
        Left = 16
        Top = 19
        Width = 201
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
      end
    end
  end
  object TrackBar1: TTrackBar
    Left = 606
    Top = 115
    Width = 296
    Height = 45
    Max = 50
    Position = 25
    TabOrder = 1
    OnChange = TrackBar1Change
  end
  object AColorBox1: TColorBox
    Left = 648
    Top = 32
    Width = 105
    Height = 22
    DefaultColorColor = clOlive
    NoneColorColor = clGreen
    Selected = clBlue
    TabOrder = 2
    OnChange = AColorBox1Change
  end
  object AColorBox2: TColorBox
    Left = 800
    Top = 32
    Width = 102
    Height = 22
    Selected = clRed
    TabOrder = 3
    OnChange = AColorBox2Change
  end
  object Memo1: TMemo
    Left = 328
    Top = 96
    Width = 185
    Height = 153
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object BColorBox1: TColorBox
    Left = 648
    Top = 60
    Width = 105
    Height = 22
    Selected = clLime
    TabOrder = 5
  end
  object BColorBox2: TColorBox
    Left = 800
    Top = 60
    Width = 102
    Height = 22
    Selected = clAqua
    TabOrder = 6
  end
  object ComboBox1: TComboBox
    Left = 328
    Top = 255
    Width = 145
    Height = 21
    TabOrder = 7
    Text = 'ComboBox1'
  end
end
