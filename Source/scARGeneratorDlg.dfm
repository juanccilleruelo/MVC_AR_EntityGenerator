object ViewARGenerator: TViewARGenerator
  Left = 0
  Top = 0
  Caption = 'senCille Active Record Generator'
  ClientHeight = 487
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    718
    487)
  TextHeight = 13
  object Label1: TLabel
    Left = 432
    Top = 117
    Width = 215
    Height = 13
    Caption = 'Double click assign a AR class to Detail items.'
  end
  object Label6: TLabel
    Left = 40
    Top = 294
    Width = 155
    Height = 13
    Caption = 'Singular Form of the Class Name'
  end
  object Label2: TLabel
    Left = 40
    Top = 319
    Width = 153
    Height = 13
    Caption = 'AR Class name for Detail items. '
  end
  object Label3: TLabel
    Left = 40
    Top = 342
    Width = 132
    Height = 13
    Caption = 'Detail Items Property Name'
  end
  object EditSingularForm: TEdit
    Left = 203
    Top = 290
    Width = 195
    Height = 21
    TabOrder = 0
    OnChange = EditSingularFormChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 689
    Height = 105
    Caption = ' Information '
    TabOrder = 1
    object StaticText1: TStaticText
      Left = 15
      Top = 20
      Width = 273
      Height = 22
      Caption = 'AR Definitions of the whole project: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object TextProjectFileName: TStaticText
      Left = 301
      Top = 20
      Width = 73
      Height = 22
      Caption = 'File Name.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object StaticText2: TStaticText
      Left = 15
      Top = 39
      Width = 199
      Height = 22
      Caption = 'Path for the target AR File'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object TextTargetFilePath: TStaticText
      Left = 301
      Top = 39
      Width = 33
      Height = 22
      Caption = 'Path'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object StaticText3: TStaticText
      Left = 15
      Top = 58
      Width = 157
      Height = 22
      Caption = 'Target AR File Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object TextTargetFileName: TStaticText
      Left = 301
      Top = 58
      Width = 73
      Height = 22
      Caption = 'File Name.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object StaticText5: TStaticText
      Left = 15
      Top = 80
      Width = 169
      Height = 22
      Caption = 'Target AR Class Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object TextTargetClassName: TStaticText
      Left = 301
      Top = 80
      Width = 73
      Height = 22
      Caption = 'File Name.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
  end
  object TreeViewARs: TTreeView
    Left = 432
    Top = 136
    Width = 239
    Height = 309
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    RowSelect = True
    ShowButtons = False
    ShowLines = False
    ShowRoot = False
    SortType = stText
    TabOrder = 2
    OnDblClick = TreeViewARsDblClick
  end
  object BtnCancel: TButton
    Left = 571
    Top = 454
    Width = 98
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = BtnCancelClick
  end
  object BtnAccept: TButton
    Left = 452
    Top = 454
    Width = 98
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'Accept'
    TabOrder = 4
    OnClick = BtnAcceptClick
  end
  object EditDetailClassName: TEdit
    Left = 203
    Top = 315
    Width = 195
    Height = 21
    TabStop = False
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 5
    OnChange = EditDetailClassNameChange
  end
  object BtnDeleteDetailClassName: TButton
    Left = 300
    Top = 456
    Width = 98
    Height = 21
    Caption = 'Delete Value'
    TabOrder = 6
    OnClick = BtnDeleteDetailClassNameClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 119
    Width = 418
    Height = 146
    BorderStyle = bsNone
    Color = clBtnFace
    Lines.Strings = (
      
        '    The name of a Table in a Database is often expressed as the ' +
        'plural of the items '
      
        'that each row represents. If each row represents a "Customer", t' +
        'he table is named as '
      
        '"Customers".  If each row represents a "Book Entry" the table is' +
        ' named as '
      
        '"BookEntries". In other cases, each row represents a list of "Pa' +
        'rameters", and the '
      'table is called "Parameters".'
      ''
      
        '   It is not trivial to deduce the "singular" name of the repres' +
        'ented item based on the '
      'Table Name, the Dataset Name or others. '
      ''
      
        'Is a user task to inform the ActiveRecord Generator which name s' +
        'hould be used to '
      'create the ActiveRecord class.')
    TabOrder = 7
  end
  object BtnDeleteAR: TButton
    Left = 677
    Top = 136
    Width = 34
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Del.'
    TabOrder = 8
    OnClick = BtnDeleteARClick
  end
  object EditDetailPropName: TEdit
    Left = 203
    Top = 338
    Width = 195
    Height = 21
    Color = cl3DLight
    TabOrder = 9
    OnChange = EditSingularFormChange
  end
end
