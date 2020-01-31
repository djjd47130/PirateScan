object frmCreditCard: TfrmCreditCard
  Left = 477
  Top = 614
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Credit Card'
  ClientHeight = 358
  ClientWidth = 239
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTotal: TLabel
    Left = 16
    Top = 272
    Width = 65
    Height = 19
    Caption = '$75,000'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object txtNameOnCard: TEdit
    Left = 16
    Top = 32
    Width = 201
    Height = 21
    TabOrder = 0
    TextHint = 'Name On Card'
  end
  object txtAddress: TEdit
    Left = 16
    Top = 72
    Width = 201
    Height = 21
    TabOrder = 1
    TextHint = 'Address'
  end
  object txtCity: TEdit
    Left = 16
    Top = 112
    Width = 201
    Height = 21
    TabOrder = 2
    TextHint = 'City'
  end
  object txtState: TEdit
    Left = 16
    Top = 152
    Width = 97
    Height = 21
    TabOrder = 3
    TextHint = 'State'
  end
  object txtZip: TEdit
    Left = 119
    Top = 152
    Width = 98
    Height = 21
    TabOrder = 4
    TextHint = 'Zip'
  end
  object Panel1: TPanel
    Left = 0
    Top = 312
    Width = 239
    Height = 46
    Align = alBottom
    TabOrder = 5
    DesignSize = (
      239
      46)
    object BitBtn2: TBitBtn
      Left = 130
      Top = 8
      Width = 98
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Pay Fine Now'
      Default = True
      TabOrder = 0
      OnClick = BitBtn2Click
    end
    object BitBtn1: TBitBtn
      Left = 26
      Top = 8
      Width = 98
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object txtCardNumber: TEdit
    Left = 16
    Top = 192
    Width = 201
    Height = 21
    TabOrder = 6
    TextHint = 'Card Number'
  end
  object txtExpirationDate: TEdit
    Left = 16
    Top = 232
    Width = 97
    Height = 21
    TabOrder = 7
    TextHint = 'Expiration Date'
  end
  object txtSecurityCode: TEdit
    Left = 119
    Top = 232
    Width = 98
    Height = 21
    TabOrder = 8
    TextHint = 'Security Code'
  end
end
