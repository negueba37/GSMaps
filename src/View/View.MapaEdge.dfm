object frmEdge: TfrmEdge
  Left = 0
  Top = 0
  Caption = 'frmEdge'
  ClientHeight = 441
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object EdgeBrowser: TEdgeBrowser
    Left = 0
    Top = 145
    Width = 709
    Height = 296
    Align = alClient
    TabOrder = 0
    OnExecuteScript = EdgeBrowserExecuteScript
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 709
    Height = 145
    Align = alTop
    ShowCaption = False
    TabOrder = 1
    object Button3: TButton
      Left = 40
      Top = 169
      Width = 75
      Height = 25
      Caption = 'Execute JS'
      TabOrder = 0
    end
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 707
      Height = 143
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Buscar Endere'#231'o'
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 699
          Height = 160
          Align = alTop
          TabOrder = 0
          object Panel2: TPanel
            Left = 1
            Top = 1
            Width = 697
            Height = 32
            Align = alTop
            Caption = 'Panel2'
            TabOrder = 0
            object Button1: TButton
              Left = 1
              Top = 1
              Width = 88
              Height = 30
              Align = alLeft
              Caption = 'Mostrar Mapa'
              TabOrder = 0
              OnClick = Button1Click
            end
            object Button2: TButton
              Left = 89
              Top = 1
              Width = 96
              Height = 30
              Align = alLeft
              Caption = 'Criar Poligono'
              TabOrder = 1
            end
            object edtUf: TEdit
              Left = 560
              Top = 1
              Width = 61
              Height = 30
              Align = alRight
              TabOrder = 2
              Text = 'PR'
              TextHint = 'UF'
              ExplicitHeight = 23
            end
            object Button6: TButton
              Left = 621
              Top = 1
              Width = 75
              Height = 30
              Align = alRight
              Caption = 'Buscar'
              TabOrder = 3
              OnClick = Button6Click
            end
            object edtEndereco: TEdit
              Left = 333
              Top = 1
              Width = 123
              Height = 30
              Align = alRight
              TabOrder = 4
              Text = 'Rua Parecis 662'
              TextHint = 'Endere'#231'o'
              ExplicitHeight = 23
            end
            object edtCidade: TEdit
              Left = 456
              Top = 1
              Width = 104
              Height = 30
              Align = alRight
              TabOrder = 5
              Text = 'Cianorte'
              TextHint = 'Cidade'
              ExplicitHeight = 23
            end
            object Button8: TButton
              Left = 185
              Top = 1
              Width = 112
              Height = 30
              Align = alLeft
              Caption = 'GoToLocalization'
              TabOrder = 6
              OnClick = Button8Click
            end
          end
          object Panel4: TPanel
            Left = 1
            Top = 33
            Width = 280
            Height = 126
            Align = alLeft
            Caption = 'Panel4'
            TabOrder = 1
            object ListBox: TListBox
              Left = 1
              Top = 25
              Width = 278
              Height = 100
              Align = alClient
              ItemHeight = 15
              TabOrder = 0
            end
            object Panel5: TPanel
              Left = 1
              Top = 1
              Width = 278
              Height = 24
              Align = alTop
              Caption = 'Panel5'
              TabOrder = 1
              object edtLongitude: TEdit
                Left = 122
                Top = 1
                Width = 121
                Height = 22
                Align = alLeft
                TabOrder = 0
                TextHint = 'Longitude'
                ExplicitHeight = 23
              end
              object edtLatitude: TEdit
                Left = 1
                Top = 1
                Width = 121
                Height = 22
                Align = alLeft
                TabOrder = 1
                TextHint = 'Latitude'
                ExplicitHeight = 23
              end
              object Button4: TButton
                Left = 243
                Top = 1
                Width = 34
                Height = 22
                Align = alClient
                Caption = 'OK'
                TabOrder = 2
                OnClick = Button4Click
              end
            end
          end
          object MemoResult: TMemo
            Left = 377
            Top = 33
            Width = 321
            Height = 126
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 2
          end
          object Panel6: TPanel
            Left = 281
            Top = 33
            Width = 96
            Height = 126
            Align = alLeft
            Caption = 'Panel6'
            TabOrder = 3
            object Button5: TButton
              Left = 1
              Top = 1
              Width = 94
              Height = 25
              Align = alTop
              Caption = 'Button5'
              TabOrder = 0
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Tra'#231'ar rota'
        ImageIndex = 1
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 699
          Height = 129
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 0
            Top = 37
            Width = 699
            Height = 15
            Align = alTop
            Alignment = taCenter
            Caption = 'Destino'
            ExplicitWidth = 40
          end
          object Label2: TLabel
            Left = 0
            Top = 0
            Width = 699
            Height = 15
            Align = alTop
            Alignment = taCenter
            Caption = 'Origem'
            ExplicitWidth = 40
          end
          object pnlOrigem: TPanel
            Left = 0
            Top = 15
            Width = 699
            Height = 22
            Align = alTop
            TabOrder = 0
            OnClick = pnlOrigemClick
            object Edit1: TEdit
              Left = 637
              Top = 1
              Width = 61
              Height = 20
              Align = alRight
              TabOrder = 0
              Text = 'PR'
              TextHint = 'UF'
              ExplicitHeight = 23
            end
            object Edit2: TEdit
              Left = 410
              Top = 1
              Width = 123
              Height = 20
              Align = alRight
              TabOrder = 1
              Text = 'Zona 06'
              ExplicitHeight = 23
            end
            object Edit3: TEdit
              Left = 533
              Top = 1
              Width = 104
              Height = 20
              Align = alRight
              TabOrder = 2
              Text = 'Cianorte'
              TextHint = 'Cidade'
              ExplicitHeight = 23
            end
            object Edit4: TEdit
              Left = 101
              Top = 1
              Width = 248
              Height = 20
              Align = alClient
              TabOrder = 3
              Text = 'Parecis'
              ExplicitHeight = 23
            end
            object Edit5: TEdit
              Left = 349
              Top = 1
              Width = 61
              Height = 20
              Align = alRight
              TabOrder = 4
              Text = '662'
              ExplicitHeight = 23
            end
            object Edit6: TEdit
              Left = 1
              Top = 1
              Width = 100
              Height = 20
              Align = alLeft
              TabOrder = 5
              Text = 'Rua'
              ExplicitHeight = 23
            end
          end
          object pnlDestino: TPanel
            Left = 0
            Top = 52
            Width = 699
            Height = 22
            Align = alTop
            TabOrder = 1
            object Edit7: TEdit
              Left = 637
              Top = 1
              Width = 61
              Height = 20
              Align = alRight
              TabOrder = 0
              Text = 'PR'
              TextHint = 'UF'
              ExplicitHeight = 23
            end
            object Edit8: TEdit
              Left = 410
              Top = 1
              Width = 123
              Height = 20
              Align = alRight
              TabOrder = 1
              Text = 'Bela vista'
              ExplicitHeight = 23
            end
            object Edit9: TEdit
              Left = 533
              Top = 1
              Width = 104
              Height = 20
              Align = alRight
              TabOrder = 2
              Text = 'Cianorte'
              TextHint = 'Cidade'
              ExplicitHeight = 23
            end
            object Edit10: TEdit
              Left = 101
              Top = 1
              Width = 248
              Height = 20
              Align = alClient
              TabOrder = 3
              Text = 'Curruila'
              ExplicitHeight = 23
            end
            object Edit11: TEdit
              Left = 349
              Top = 1
              Width = 61
              Height = 20
              Align = alRight
              TabOrder = 4
              Text = '59'
              ExplicitHeight = 23
            end
            object Edit12: TEdit
              Left = 1
              Top = 1
              Width = 100
              Height = 20
              Align = alLeft
              TabOrder = 5
              Text = 'Rua'
              ExplicitHeight = 23
            end
          end
          object Button7: TButton
            Left = 0
            Top = 74
            Width = 699
            Height = 23
            Align = alTop
            Caption = 'Buscar'
            TabOrder = 2
            OnClick = Button7Click
          end
        end
      end
    end
  end
end
