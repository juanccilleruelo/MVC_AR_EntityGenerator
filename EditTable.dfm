object EditTableForm: TEditTableForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edit Table'
  ClientHeight = 151
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 56
    Top = 48
    Width = 71
    Height = 15
    Caption = 'Table Name : '
  end
  object LabelTableName: TLabel
    Left = 133
    Top = 48
    Width = 87
    Height = 15
    Caption = 'LabelTableName'
  end
  object Label3: TLabel
    Left = 56
    Top = 69
    Width = 62
    Height = 15
    Caption = 'Class Name'
  end
  object EditClassName: TEdit
    Left = 133
    Top = 66
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'EditClassName'
  end
  object BtnCancel: TBitBtn
    Left = 150
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object BtnOK: TBitBtn
    Left = 231
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
