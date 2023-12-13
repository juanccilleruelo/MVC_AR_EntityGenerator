object EditFieldForm: TEditFieldForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edit Field'
  ClientHeight = 164
  ClientWidth = 364
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
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
    Top = 93
    Width = 77
    Height = 15
    Caption = 'Custom Name'
  end
  object Label2: TLabel
    Left = 56
    Top = 69
    Width = 69
    Height = 15
    Caption = 'Field Name : '
  end
  object LabelFieldName: TLabel
    Left = 133
    Top = 69
    Width = 87
    Height = 15
    Caption = 'LabelTableName'
  end
  object EditCustomName: TEdit
    Left = 167
    Top = 90
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'EditCustomName'
  end
  object BtnCancel: TBitBtn
    Left = 154
    Top = 131
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object BtnOK: TBitBtn
    Left = 235
    Top = 131
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
