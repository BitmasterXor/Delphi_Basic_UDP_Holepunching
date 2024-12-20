object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'UDP Hole Punching Tool'
  ClientHeight = 461
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 120
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object lblStatus: TLabel
      Left = 8
      Top = 97
      Width = 668
      Height = 15
      Align = alBottom
      Caption = 'Ready'
      OnClick = lblStatusClick
      ExplicitWidth = 32
    end
    object edtRemoteHost: TLabeledEdit
      Left = 16
      Top = 32
      Width = 201
      Height = 23
      EditLabel.Width = 72
      EditLabel.Height = 15
      EditLabel.Caption = 'Remote Host:'
      TabOrder = 0
      Text = ''
    end
    object rbRole: TRadioGroup
      Left = 232
      Top = 8
      Width = 185
      Height = 73
      Caption = 'Mode'
      ItemIndex = 0
      Items.Strings = (
        'Your PC'
        'Another PC')
      TabOrder = 1
      OnClick = rbRoleClick
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 120
    Width = 684
    Height = 282
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 1
    object memLog: TMemo
      Left = 8
      Top = 8
      Width = 668
      Height = 266
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 402
    Width = 684
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 4
    Padding.Right = 8
    Padding.Bottom = 4
    TabOrder = 2
    object btnStart: TButton
      Left = 8
      Top = 4
      Width = 75
      Height = 32
      Align = alLeft
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 83
      Top = 4
      Width = 75
      Height = 32
      Align = alLeft
      Caption = 'Stop'
      Enabled = False
      TabOrder = 1
      OnClick = btnStopClick
    end
    object btnClear: TButton
      Left = 158
      Top = 4
      Width = 75
      Height = 32
      Align = alLeft
      Caption = 'Clear Log'
      TabOrder = 2
      OnClick = btnClearClick
    end
  end
  object statusBar: TStatusBar
    Left = 0
    Top = 442
    Width = 684
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 528
    Top = 24
  end
  object IdUDPServer1: TIdUDPServer
    BufferSize = 32768
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 600
    Top = 24
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 464
    Top = 24
  end
end
