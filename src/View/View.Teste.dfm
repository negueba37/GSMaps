object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 432
    Top = 120
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 65
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    object Button1: TButton
      Left = 264
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 624
    Height = 224
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 1
    object WebBrowser1: TWebBrowser
      Left = 1
      Top = 1
      Width = 622
      Height = 222
      Align = alClient
      TabOrder = 0
      SelectedEngine = EdgeOnly
      ExplicitTop = -4
      ControlData = {
        4C00000049400000F21600000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 289
    Width = 624
    Height = 152
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 2
    object EdgeBrowser1: TEdgeBrowser
      Left = 1
      Top = 1
      Width = 622
      Height = 150
      Align = alClient
      TabOrder = 0
    end
  end
end
