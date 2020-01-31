object frmMain: TfrmMain
  Left = 530
  Top = 404
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'PirateScan'
  ClientHeight = 155
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    459
    155)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 428
    Height = 69
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Caption = 
      'PirateScan has detected that you have watched pirated movies wit' +
      'hin the past 30 days. An officer has been dispatched to your pla' +
      'ce of residence.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 477
    ExplicitHeight = 74
  end
  object Panel1: TPanel
    Left = 0
    Top = 109
    Width = 459
    Height = 46
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      459
      46)
    object BitBtn1: TBitBtn
      Left = 319
      Top = 8
      Width = 125
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Prison (10 Years)'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 152
      Top = 8
      Width = 154
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Pay Fine ($75,000)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
end
