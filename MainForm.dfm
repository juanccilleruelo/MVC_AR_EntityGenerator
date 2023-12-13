object Main: TMain
  Left = 0
  Top = 0
  Caption = '[DMVCFramework] MVCActiveRecord Entity Generator'
  ClientHeight = 826
  ClientWidth = 1166
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poDesktopCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 21
  object Splitter1: TSplitter
    Left = 0
    Top = 681
    Width = 1166
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 543
    ExplicitWidth = 1196
  end
  object Panel8: TPanel
    Left = 0
    Top = 771
    Width = 1166
    Height = 55
    Margins.Right = 6
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BtnSaveProject: TButton
      AlignWithMargins = True
      Left = 960
      Top = 3
      Width = 203
      Height = 49
      Action = ActionSaveProject
      Align = alRight
      TabOrder = 0
    end
    object Panel5: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 622
      Height = 49
      Align = alLeft
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Panel5'
      ShowCaption = False
      TabOrder = 1
      object BtnGenerateCurrent: TButton
        AlignWithMargins = True
        Left = 195
        Top = 3
        Width = 182
        Height = 37
        Action = ActionGenerateCurrent
        Images = ImageListButtons
        TabOrder = 0
      end
      object BtnGenerateAll: TButton
        AlignWithMargins = True
        Left = 407
        Top = 3
        Width = 182
        Height = 37
        Action = ActionGenerateAll
        Images = ImageListButtons
        TabOrder = 1
      end
    end
  end
  object Panel12: TPanel
    Left = 0
    Top = 684
    Width = 1166
    Height = 87
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel12'
    TabOrder = 1
    object lbLog: TListBox
      Left = 0
      Top = 0
      Width = 1166
      Height = 87
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Consolas'
      Font.Style = []
      ItemHeight = 19
      ParentFont = False
      ScrollWidth = 5000
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 1166
    Height = 681
    Align = alClient
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 64
    ExplicitWidth = 1041
    ExplicitHeight = 589
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 1164
      Height = 151
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel4'
      ShowCaption = False
      TabOrder = 0
      ExplicitLeft = -23
      ExplicitWidth = 1153
      DesignSize = (
        1164
        151)
      object btnGenEntities: TButton
        AlignWithMargins = True
        Left = 1192
        Top = 0
        Width = 161
        Height = 35
        Anchors = [akRight, akBottom]
        Caption = 'Generate Entities'
        TabOrder = 0
        ExplicitLeft = 1184
      end
      object CheckBoxWithMappingRegistry: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 116
        Width = 1151
        Height = 32
        Margins.Left = 10
        Align = alBottom
        Caption = 
          'Register entities in ActiveRecordMappingRegistry (needed by TMVC' +
          'ActiveRecordController)'
        Checked = True
        State = cbChecked
        TabOrder = 1
        WordWrap = True
        ExplicitWidth = 1143
      end
      object RadioGroupNameCase: TRadioGroup
        Left = 7
        Top = 6
        Width = 354
        Height = 104
        Caption = 'Class MVCNameCase'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'LowerCase'
          'UpperCase'
          'CamelCase'
          'PascalCase'
          'SnakeCase'
          'AsIs')
        TabOrder = 2
      end
      object RadioGroupFieldNameFormatting: TRadioGroup
        Left = 367
        Top = 6
        Width = 355
        Height = 104
        Caption = 'Property Names Formatting'
        ItemIndex = 1
        Items.Strings = (
          'Leave names as is in database table'
          'Convert names to Pascal Case (eg FirstName)')
        TabOrder = 3
      end
      object gbOptions: TGroupBox
        Left = 728
        Top = 10
        Width = 429
        Height = 105
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Other Options'
        TabOrder = 4
        ExplicitWidth = 421
        DesignSize = (
          429
          105)
        object Label5: TLabel
          Left = 31
          Top = 29
          Width = 332
          Height = 42
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            'Declare classes as abstract (MVCTable must be redeclared on desc' +
            'endant classes)'
          WordWrap = True
          ExplicitWidth = 324
        end
        object CheckBoxClassAsAbstract: TCheckBox
          Left = 9
          Top = 32
          Width = 20
          Height = 17
          TabOrder = 0
        end
      end
    end
    object Panel10: TPanel
      Left = 1
      Top = 152
      Width = 1164
      Height = 51
      Align = alTop
      Caption = 'Panel10'
      ShowCaption = False
      TabOrder = 1
      ExplicitWidth = 1156
      object btnGetTables: TButton
        AlignWithMargins = True
        Left = 7
        Top = 8
        Width = 163
        Height = 36
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Action = ActionRefreshTableList
        Constraints.MinWidth = 160
        TabOrder = 0
      end
      object BtnEditConnection: TButton
        AlignWithMargins = True
        Left = 180
        Top = 8
        Width = 163
        Height = 36
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Action = ActionRefreshTableList
        Constraints.MinWidth = 160
        TabOrder = 1
        OnClick = BtnEditConnectionClick
      end
    end
    object PageControl: TPageControl
      AlignWithMargins = True
      Left = 4
      Top = 206
      Width = 1158
      Height = 471
      ActivePage = TabSheetTables
      Align = alClient
      TabOrder = 2
      ExplicitWidth = 1150
      ExplicitHeight = 435
      object TabSheetTables: TTabSheet
        Caption = 'Tables'
        object Splitter2: TSplitter
          Left = 513
          Top = 0
          Height = 394
          ExplicitLeft = 384
          ExplicitTop = 16
          ExplicitHeight = 358
        end
        object Panel7: TPanel
          Left = 0
          Top = 394
          Width = 1150
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitTop = 358
          ExplicitWidth = 1142
        end
        object GridTables: TDBGrid
          Left = 0
          Top = 0
          Width = 513
          Height = 394
          Align = alLeft
          DataSource = srcTables
          FixedColor = clBtnShadow
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDrawColumnCell = GridTablesDrawColumnCell
          OnDblClick = GridTablesDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'TABLE_NAME'
              ReadOnly = True
              Title.Caption = 'Table Name'
              Width = 180
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLASS_NAME'
              Title.Caption = 'Class Name'
              Width = 184
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DEPLOY_PATH'
              Title.Caption = 'Deploy Path'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TARGET_FILE_NAME'
              Width = 184
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'WITH_DETAIL'
              Width = 184
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DETAIL_CLASS_NAME'
              Width = 184
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DETAIL_PROP_NAME'
              Width = 184
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DETAIL_UNIT_NAME'
              Width = 184
              Visible = True
            end>
        end
        object GridFields: TDBGrid
          Left = 516
          Top = 0
          Width = 634
          Height = 394
          Align = alClient
          DataSource = srcFields
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDrawColumnCell = GridFieldsDrawColumnCell
          OnDblClick = GridFieldsDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'FIELD_NAME'
              Title.Caption = 'Field Name'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CUSTOM_NAME'
              Title.Caption = 'Custom Name'
              Visible = True
            end>
        end
      end
      object TabSheetSource: TTabSheet
        Caption = 'Source'
        ImageIndex = 1
        object MemoOutputCode: TMemo
          Left = 0
          Top = 41
          Width = 1150
          Height = 394
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
          ExplicitWidth = 1142
          ExplicitHeight = 358
        end
        object PanelSource: TPanel
          Left = 0
          Top = 0
          Width = 1150
          Height = 41
          Align = alTop
          Caption = 'PanelSource'
          TabOrder = 1
          ExplicitWidth = 1142
        end
      end
    end
  end
  object DBConnection: TFDConnection
    Params.Strings = (
      'Database=C:\Views\senCilleMVCActiveRecordAdds\db\chinook.db'
      'DriverID=SQLite')
    ResourceOptions.AssignedValues = [rvKeepConnection]
    ResourceOptions.KeepConnection = False
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 72
    Top = 296
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 504
    Top = 496
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 504
    Top = 344
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 632
    Top = 560
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 504
    Top = 560
  end
  object FDPhysFBDriverLink2: TFDPhysFBDriverLink
    Left = 632
    Top = 408
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 632
    Top = 496
  end
  object FDPhysMySQLDriverLink2: TFDPhysMySQLDriverLink
    Left = 508
    Top = 628
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 504
    Top = 408
  end
  object ProjectOpenDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileName = 'C:\DEV\dmvcframework\tools\entitygenerator'
    FileTypes = <
      item
        DisplayName = 'DMVC Entities Generator Project'
        FileMask = '*.entgen'
      end>
    Options = []
    Left = 360
    Top = 232
  end
  object MainMenu1: TMainMenu
    Images = ImageListMainMenu
    Left = 312
    Top = 16
    object File1: TMenuItem
      Caption = '&File'
      object NewProject1: TMenuItem
        Action = ActionNewProject
      end
      object LoadProject1: TMenuItem
        Action = ActionLoadProject
      end
      object SaveProject1: TMenuItem
        Action = ActionSaveProject
      end
      object Saveprojectas1: TMenuItem
        Action = ActionSaveProjectAs
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        Hint = 'Exit|Quits the application'
        ImageIndex = 43
      end
    end
    object Entities1: TMenuItem
      Caption = '&Entities'
      object RefreshCatalog1: TMenuItem
        Caption = 'Retrieve metadata'
        ImageIndex = 6
        ShortCut = 8308
      end
      object RefreshTableList1: TMenuItem
        Action = ActionRefreshTableList
      end
      object GenerateCode1: TMenuItem
        Caption = 'Generate Code OLD'
        ImageIndex = 5
        ShortCut = 120
      end
      object SaveGeneratedCode1: TMenuItem
        ImageIndex = 4
        ShortCut = 16467
      end
    end
  end
  object ActionList1: TActionList
    Images = ImageListMainMenu
    Left = 316
    Top = 76
    object ActionNewProject: TAction
      Caption = 'New Project'
      ImageIndex = 0
      OnExecute = ActionNewProjectExecute
    end
    object ActionLoadProject: TAction
      Caption = 'Load Project'
      ImageIndex = 1
      OnExecute = ActionLoadProjectExecute
    end
    object ActionSaveProject: TAction
      Caption = 'Save Project'
      ImageIndex = 2
      OnExecute = ActionSaveProjectExecute
      OnUpdate = ActionSaveProjectUpdate
    end
    object ActionSaveProjectAs: TAction
      ImageIndex = 3
      OnExecute = ActionSaveProjectAsExecute
    end
    object ActionGenerateCurrent: TAction
      Caption = 'Generate Current'
      ImageIndex = 5
      ShortCut = 120
      OnExecute = ActionGenerateCurrentExecute
      OnUpdate = ActionGenerateCurrentUpdate
    end
    object ActionGenerateAll: TAction
      Caption = 'Generate All'
      ImageIndex = 5
      ShortCut = 120
      OnExecute = ActionGenerateAllExecute
      OnUpdate = ActionGenerateAllUpdate
    end
    object ActionRefreshTableList: TAction
      Caption = 'Refresh Table List'
      ImageIndex = 6
      ShortCut = 116
    end
  end
  object DialogSaveProject: TFileSaveDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'DMVC Entities Generator'
        FileMask = '*.entgen'
      end>
    Options = [fdoOverWritePrompt, fdoStrictFileTypes, fdoPathMustExist]
    Left = 672
    Top = 24
  end
  object ImageListMainMenu: TImageList
    ColorDepth = cdDefault
    Height = 32
    Width = 32
    Left = 688
    Top = 156
    Bitmap = {
      494C010107000800040020002000FFFFFFFF0510FFFFFFFFFFFFFFFF424D7600
      0000000000007600000028000000800000004000000001000400000000000010
      0000000000000000000000000000000000000000000000008000008000000080
      800080000000800080008080000080808000C0C0C0000000FF0000FF000000FF
      FF00FF000000FF00FF00FFFF0000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000400000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFF09FFFFFFFF00FFF00000000
      FFFF3FFFE0CFFFFFFF8001FF00000000FFFE1FFFC7C3FFFFFE0FF07F00000000
      FFFC0FFF9FC0FFFFFC3FFC3F00000000FFF807FF1FCC7FFFF8FFFF1F00000000
      FFF123FF3FCE7FFFF1FFFF8F00000000FFFB37FF3FCF3FFFE3FFFFC700000000
      FFFF3FFF3FCF3FFFC7FFFFE300000000FFFF3FFF3FE79FFFCFFFFFF300000000
      FFFF3FFF1FE79FFF8FFFFFF100000000FFFFFFFF9FF3CFFF9FFFFFF900000000
      FFFFFFFFC7F3CEFF9FFFFFF900000000FF00003FE039E7033FFFFFFC00000000
      FE00003FF019E7013FFFFFFC00000000FC4CF33FFFFCF3F83FFFFFFC00000000
      FCCCF33FFFFCF3FC3FFFFFFC00000000FCCFF33FFFFE79FC3FFFFFFC00000000
      FCCFF33FFFFE79F83FFFFFFC00000000FCC0033FFFF33CE13FFFFFFC00000000
      FCC0033FFFF93CE33FFFFFFC00000000FCFFFF3FFFF99E7F9FFFFFF900000000
      FCFFFF3FFFFC9E7F9FFFFFF900000000FCC0033FFFFCCF3F8FFFFFF100000000
      FCC0033FFFFE4F3FCFFFFFF300000000FCCFF33FFFFE679FC7CFFFE300000000
      FCCFF33FFFFF279FE3CFFFC700000000FCCFF33FFFFF038FF1CFFF8F00000000
      FCCFF33FFFFF921FF8CFFF1F00000000FCCFF33FFFFFF84FFC0FFC3F00000000
      FCCFF33FFFFFF8CFFE0FF07F00000000FC00003FFFFFFE0FF00FF1FF00000000
      FE00007FFFFFFE3FF00FFFFF00000000F00000FFFFFFFFFFFFFFFFFFFFFCFFFF
      F000007FFFFFFFFFFFFF3FFFFFFC0FFFF3FFFE3FFFFFFFFFFFFE1FFFFFFE07FF
      F3FFFF1FFFFFFFFFFFFC0FFFFFFE63FFF3FFFF8F0000007FFFF807FFFFFE71FF
      F3FFFFCF0000003FFFF123FFFFFE38FFF3FFFFCF1FFFFF3FFFFB37FFF0071C7F
      F3FFFFCF1FFFFF9FFFFF3FFFE0038E3FF3FFFFCF0FFFFF9FFFFF3FFFC4CFC71F
      F3FFFFCF0FFFFFCFFFFF3FFFCCCFE38FF3FFFFCF27FFFFCFFFFFFFFFCCCFF1C7
      F3FFFFCF27FFFFE7FFFFFFFFCCCFF8E3F3FFFFCF33FFFFE7FF00003FCCFFDC71
      F3FFFFCF33FFFFF3FE00003FCCFFCE38F3FFFFCF39FFFFF3FC4CF33FCC000F1C
      F3FFFFCF39FFFFF9FCCCF33FCC000F8CF3FFFFCF3CFFFFF9FCCFF33FCFFFFFC0
      F3FFFFCF3CFFFFFCFCCFF33FCFFFFFE1F3FFFFCF3E000000FCC0033FCC00037F
      F3FFFFCF3E000001FCC0033FCC00033FF3FFFFCF3FFFFF3FFCFFFF3FCCFFF33F
      F3FFFFCF3FFFFF3FFCFFFF3FCCFFF33FF3FFFFCF3FFFFF3FFCC0033FCCFFF33F
      F3FFFFCF3FFFFF3FFCC0033FCCFFF33FF3FFFFCF3FC0003FFCCFF33FCCFFF33F
      F3FFFFCF3F80007FFCCFF33FCCFFF33FF3FFFFCF001FFFFFFCCFF33FCCFFF33F
      F1FFFFCF803FFFFFFCCFF33FCCFFF33FF8FFFFCFFFFFFFFFFCCFF33FC000003F
      FC7FFFCFFFFFFFFFFCCFF33FE000007FFE00000FFFFFFFFFFC00003FFFFFFFFF
      FF00000FFFFFFFFFFE00007FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageListButtons: TImageList
    ColorDepth = cdDefault
    Height = 24
    Width = 24
    Left = 2260
    Top = 400
    Bitmap = {
      494C010101000800040018001800FFFFFFFF0510FFFFFFFFFFFFFFFF424D7600
      0000000000007600000028000000600000001800000001000400000000008004
      0000000000000000000000000000000000000000000000008000008000000080
      800080000000800080008080000080808000C0C0C0000000FF0000FF000000FF
      FF00FF000000FF00FF00FFFF0000FFFFFF000000000009000090000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000999990099999000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000099000900900099000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000900099990009000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000009000000000090000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009000900000000009000900000000000000000000000000000000000000
      0000000000000000000000000000000000000999999000000000099999900000
      0000000000000000000000000000000000000000000000000000000000000000
      0000090000000000000000000090000000000000000000000000000000000000
      0000000000000000000000000000000000000900000009999990000000900000
      0000000000000000000000000000000000000000000000000000000000000000
      0000990000009900009900000099000000000000000000000000000000000000
      0000000000000000000000000000000000000999000090000009000099900000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000900009000000900009000000000000000000000000000000000000000
      0000000000000000000000000000000000000009000090000009000090000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000099900009000000900009990000000000000000000000000000000000000
      0000000000000000000000000000000000009900000099000099000000990000
      0000000000000000000000000000000000000000000000000000000000000000
      0000090000000999999000000090000000000000000000000000000000000000
      0000000000000000000000000000000000000900000000000000000000900000
      0000000000000000000000000000000000000000000000000000000000000000
      0000099999900000000009999990000000000000000000000000000000000000
      0000000000000000000000000000000000000090009000000000090009000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000900000000009000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000009000999900090000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000009900090090009900000000000000000000000000000000000000000
      0000000000000000000000000000000000000000009999900999990000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000900009000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000180000000100010000000000200100000000000000000000
      000000000000000000000000FFFFFF00FFBDFF000000000000000000FC183F00
      0000000000000000F9DB9F000000000000000000FDC3BF000000000000000000
      FDFFBF000000000000000000DDFFBB00000000000000000081FF810000000000
      00000000BFFFFD000000000000000000BF81FD0000000000000000003F3CFC00
      00000000000000008F7EF1000000000000000000EF7EF7000000000000000000
      EF7EF70000000000000000008F7EF10000000000000000003F3CFC0000000000
      00000000BF81FD000000000000000000BFFFFD00000000000000000081FF8100
      0000000000000000DDFFBB000000000000000000FDFFBF000000000000000000
      FDC3BF000000000000000000F9DB9F000000000000000000FC183F0000000000
      00000000FFBDFF00000000000000000000000000000000000000000000000000
      000000000000}
  end
  object FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink
    Left = 792
    Top = 400
  end
  object FDMoniCustomClientLink1: TFDMoniCustomClientLink
    Left = 792
    Top = 456
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    Left = 792
    Top = 512
  end
  object ARDB: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    ResourceOptions.AssignedValues = [rvKeepConnection]
    ResourceOptions.KeepConnection = False
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 224
    Top = 295
  end
  object dsTables: TFDMemTable
    IndexFieldNames = 'TABLE_NAME'
    FetchOptions.AssignedValues = [evItems]
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end>
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    Left = 224
    Top = 352
    object dsTablesTABLE_NAME: TStringField
      FieldName = 'TABLE_NAME'
      Origin = 'TABLE_NAME'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 200
    end
    object dsTablesCLASS_NAME: TStringField
      FieldName = 'CLASS_NAME'
      Origin = 'CLASS_NAME'
      Size = 200
    end
    object dsTablesDEPLOY_PATH: TStringField
      FieldName = 'DEPLOY_PATH'
      Origin = 'DEPLOY_PATH'
      Size = 200
    end
    object dsTablesTARGET_CLASS_NAME: TStringField
      FieldName = 'TARGET_CLASS_NAME'
      Origin = 'TARGET_CLASS_NAME'
      Size = 200
    end
    object dsTablesTARGET_FILE_NAME: TStringField
      FieldName = 'TARGET_FILE_NAME'
      Origin = 'TARGET_FILE_NAME'
      Size = 200
    end
    object dsTablesWITH_DETAIL: TStringField
      FieldName = 'WITH_DETAIL'
      Origin = 'WITH_DETAIL'
      Size = 200
    end
    object dsTablesDETAIL_CLASS_NAME: TStringField
      FieldName = 'DETAIL_CLASS_NAME'
      Origin = 'DETAIL_CLASS_NAME'
      Size = 200
    end
    object dsTablesDETAIL_PROP_NAME: TStringField
      FieldName = 'DETAIL_PROP_NAME'
      Origin = 'DETAIL_PROP_NAME'
      Size = 200
    end
    object dsTablesDETAIL_UNIT_NAME: TStringField
      FieldName = 'DETAIL_UNIT_NAME'
      Origin = 'DETAIL_UNIT_NAME'
      Size = 200
    end
  end
  object srcTables: TDataSource
    DataSet = dsTables
    Left = 296
    Top = 352
  end
  object dsFields: TFDMemTable
    IndexFieldNames = 'TABLE_NAME'
    MasterSource = srcTables
    MasterFields = 'TABLE_NAME'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 224
    Top = 408
    object dsFieldsTABLE_NAME: TStringField
      FieldName = 'TABLE_NAME'
    end
    object dsFieldsFIELD_NAME: TStringField
      FieldName = 'FIELD_NAME'
    end
    object dsFieldsCUSTOM_NAME: TStringField
      FieldName = 'CUSTOM_NAME'
    end
  end
  object srcFields: TDataSource
    DataSet = dsFields
    Left = 292
    Top = 406
  end
end
