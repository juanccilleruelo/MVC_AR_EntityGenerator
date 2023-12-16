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
        TabOrder = 0
      end
      object BtnGenerateAll: TButton
        AlignWithMargins = True
        Left = 407
        Top = 3
        Width = 182
        Height = 37
        Action = ActionGenerateAll
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
        DesignSize = (
          429
          105)
        object Label5: TLabel
          Left = 31
          Top = 29
          Width = 324
          Height = 42
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            'Declare classes as abstract (MVCTable must be redeclared on desc' +
            'endant classes)'
          WordWrap = True
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
      object btnGetTables: TButton
        AlignWithMargins = True
        Left = 183
        Top = 5
        Width = 163
        Height = 36
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Action = ActionRefreshDBInfo
        Constraints.MinWidth = 160
        TabOrder = 0
      end
      object BtnConnectDatabase: TButton
        AlignWithMargins = True
        Left = 10
        Top = 5
        Width = 163
        Height = 36
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Action = ActionConnectDatabase
        Constraints.MinWidth = 160
        TabOrder = 1
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
        end
        object PanelSource: TPanel
          Left = 0
          Top = 0
          Width = 1150
          Height = 41
          Align = alTop
          Caption = 'PanelSource'
          TabOrder = 1
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
    FileTypes = <
      item
        DisplayName = 'DMVC Entities Generator Project'
        FileMask = '*.entgen'
      end>
    Options = []
    Left = 672
    Top = 80
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
        Action = ActionOpenProject
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
        Action = ActionRefreshDBInfo
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
  object ActionList: TActionList
    Images = ImageListMainMenu
    Left = 412
    Top = 20
    object ActionNewProject: TAction
      Caption = 'New Project'
      ImageIndex = 0
      OnExecute = ActionNewProjectExecute
    end
    object ActionOpenProject: TAction
      Caption = 'Open Project'
      ImageIndex = 1
      OnExecute = ActionOpenProjectExecute
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
    object ActionRefreshDBInfo: TAction
      Caption = 'Refresh DB Info'
      ImageIndex = 6
      ShortCut = 116
      OnExecute = ActionRefreshDBInfoExecute
      OnUpdate = ActionRefreshDBInfoUpdate
    end
    object ActionConnectDatabase: TAction
      Caption = 'Connect Database'
      OnExecute = ActionConnectDatabaseExecute
      OnUpdate = ActionConnectDatabaseUpdate
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
    Left = 312
    Top = 76
    Bitmap = {
      494C010101000800040020002000FFFFFFFF0510FFFFFFFFFFFFFFFF424D7600
      0000000000007600000028000000800000002000000001000400000000000008
      0000000000000000000000000000000000000000000000008000008000000080
      8000800000008000800080800000C0C0C000808080000000FF0000FF000000FF
      FF00FF000000FF00FF00FFFF0000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000078000000000000870000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000800000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007008F0000000000F800700
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000000000080800
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F00000000000000F0000
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
      00000000000000000000000000000000000000000000000000000000000F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F80000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000800
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007000F00700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000F008000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000F000F000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F0000000000F000F0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008000000000F000F00000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000007008F0000F00000F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000008000000000008F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000070000000087000000000
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
      2800000080000000200000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FF0000FF000000000000000000000000
      FE00007F000000000000000000000000FC1FF83F000000000000000000000000
      FC7FFE3F000000000000000000000000FC7FFE3F000000000000000000000000
      FCFFFF3F000000000000000000000000FCFFFF3F000000000000000000000000
      FCFFFF3F000000000000000000000000FCFFFF3F000000000000000000000000
      FCFFFF3F000000000000000000000000FCFFFF3F000000000000000000000000
      FCFFFF3F000000000000000000000000FCFFFF3F000000000000000000000000
      FCFFFE3F000000000000000000000000FCFF003F000000000000000000000000
      FCFF003F000000000000000000000000FCFF1C3F000000000000000000000000
      FCFF387F000000000000000000000000FCFF307F000000000000000000000000
      FC7F20FF000000000000000000000000FC7F01FF000000000000000000000000
      FC1E03FF000000000000000000000000FE0007FF000000000000000000000000
      FF001FFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF00000000000000000000000000000000000000000000000000000000
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
  object FDSQLiteBackup1: TFDSQLiteBackup
    DriverLink = FDPhysSQLiteDriverLink1
    Catalog = 'MAIN'
    DestCatalog = 'MAIN'
    Left = 288
    Top = 486
  end
end
