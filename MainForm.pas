unit MainForm;

interface

uses
  Data.DB,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBGrids, Vcl.Buttons, Vcl.ActnList, Vcl.Menus, Vcl.StdActns,
  Vcl.ExtActns, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.ValEdit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.FBDef, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Phys.PGDef,
  FireDAC.Phys.PG, FireDAC.Phys.IBDef, FireDAC.Phys.IB, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Moni.FlatFile, FireDAC.Phys.SQLiteWrapper,
  JsonDataObjects, System.Actions,
  LoggerPro.FileAppender,
  LoggerPro.VCLListBoxAppender,
  LoggerPro,
  FireDAC.Moni.RemoteClient, FireDAC.Moni.Custom, FireDAC.Moni.Base,
  ARGeneratorController, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef;

type
  TMain = class(TForm)
    DBConnection: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDPhysFBDriverLink2: TFDPhysFBDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDPhysMySQLDriverLink2: TFDPhysMySQLDriverLink;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    Panel8: TPanel;
    BtnSaveProject: TButton;
    ProjectOpenDialog: TFileOpenDialog;
    MainMenu: TMainMenu;
    ActionList: TActionList;
    ActionOpenProject: TAction;
    ActionSaveProject: TAction;
    ActionSaveProjectAs: TAction;
    MenuItemFile: TMenuItem;
    MenuItemLoadProject: TMenuItem;
    MenuItemSaveProject: TMenuItem;
    MenuItemSaveProjectAs: TMenuItem;
    MenuItemExit: TMenuItem;
    N1: TMenuItem;
    ActionRefreshMetadata: TAction;
    DialogSaveProject: TFileSaveDialog;
    ActionNewProject: TAction;
    MenuItemNewProject: TMenuItem;
    ImageListMainMenu: TImageList;
    MenuItemEntities: TMenuItem;
    MenuItemRefreshMetaData: TMenuItem;
    MenuItemGenerateCodeCurrent: TMenuItem;
    Panel12: TPanel;
    lbLog: TListBox;
    Splitter1: TSplitter;
    Panel5: TPanel;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    FDMoniCustomClientLink1: TFDMoniCustomClientLink;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    ARDB: TFDConnection;
    dsTables: TFDMemTable;
    dsTablesTABLE_NAME: TStringField;
    dsTablesCLASS_NAME: TStringField;
    dsTablesDEPLOY_PATH: TStringField;
    dsTablesTARGET_CLASS_NAME: TStringField;
    dsTablesTARGET_FILE_NAME: TStringField;
    dsTablesWITH_DETAIL: TStringField;
    dsTablesDETAIL_CLASS_NAME: TStringField;
    dsTablesDETAIL_PROP_NAME: TStringField;
    dsTablesDETAIL_UNIT_NAME: TStringField;
    srcTables: TDataSource;
    dsFields: TFDMemTable;
    dsFieldsTABLE_NAME: TStringField;
    dsFieldsFIELD_NAME: TStringField;
    srcFields: TDataSource;
    dsFieldsCUSTOM_NAME: TStringField;
    BtnGenerateCurrent: TButton;
    BtnGenerateAll: TButton;
    ActionGenerateCurrent: TAction;
    ActionGenerateAll: TAction;
    Panel3: TPanel;
    Panel4: TPanel;
    btnGenEntities: TButton;
    RadioGroupNameCase: TRadioGroup;
    RadioGroupFieldNameFormatting: TRadioGroup;
    gbOptions: TGroupBox;
    CheckBoxClassAsAbstract: TCheckBox;
    Panel10: TPanel;
    btnGetTables: TButton;
    BtnConnectDatabase: TButton;
    PageControl: TPageControl;
    TabSheetTables: TTabSheet;
    Splitter2: TSplitter;
    Panel7: TPanel;
    GridTables: TDBGrid;
    GridFields: TDBGrid;
    TabSheetSource: TTabSheet;
    MemoOutputCode: TMemo;
    PanelSource: TPanel;
    FDSQLiteBackup1: TFDSQLiteBackup;
    ActionConnectDatabase: TAction;
    CheckBoxWithMappingRegistry: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionOpenProjectExecute(Sender: TObject);
    procedure ActionSaveProjectExecute(Sender: TObject);
    procedure ActionSaveProjectAsExecute(Sender: TObject);
    procedure ActionNewProjectExecute(Sender: TObject);
    procedure GridTablesDblClick(Sender: TObject);
    procedure GridFieldsDblClick(Sender: TObject);
    procedure ActionSaveProjectUpdate(Sender: TObject);
    procedure GridTablesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridFieldsDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ActionGenerateCurrentExecute(Sender: TObject);
    procedure ActionGenerateAllExecute(Sender: TObject);
    procedure ActionGenerateCurrentUpdate(Sender: TObject);
    procedure ActionGenerateAllUpdate(Sender: TObject);
    procedure ActionConnectDatabaseExecute(Sender: TObject);
    procedure ActionConnectDatabaseUpdate(Sender: TObject);
    procedure ActionRefreshMetadataExecute(Sender: TObject);
    procedure ActionRefreshMetadataUpdate(Sender: TObject);
    procedure RadioGroupNameCaseClick(Sender: TObject);
    procedure RadioGroupFieldNameFormattingClick(Sender: TObject);
    procedure CheckBoxClassAsAbstractClick(Sender: TObject);
    procedure CheckBoxWithMappingRegistryClick(Sender: TObject);
    procedure ActionSaveProjectAsUpdate(Sender: TObject);
  private
    FProjectName :string;
    FModified    :Boolean; {Changes not saved on disk}
    Log          :ILogWriter;
    Controller   :TARGeneratorController; {Controller of this project}
    procedure ResetUI;
    procedure SetOnViewDataFromMemory;
    procedure DisableVisualEvents;
    procedure EnableVisualEvents;
  public
  end;

var
  Main: TMain;

const
   DEFAULT_PROJECT_NAME   = 'EntitiesDB.entgen';
   LOG_TAG                = 'generator';
   NOT_SAVED_PROJECT_NAME = 'Untitled.entgen';

implementation

uses System.IOUtils,
     System.TypInfo,
     System.UITypes,
     System.DateUtils,
     LoggerPro.GlobalLogger,
     System.Generics.Collections,
     MVCFramework.Commons,
     FireDAC.VCLUI.ConnEdit, {To allow executing the connection Editor}
     EditTable,
     EditField,
     UtilsU;

{$R *.dfm}

procedure TMain.FormCreate(Sender: TObject);
var UILogFormat :string;
begin
   FModified    := False;
   FProjectName := '';

   ProjectOpenDialog.DefaultExtension := 'entgen';

   {Configures LoggerPro}
   UILogFormat := '%0:s [%2:-10s] %3:s';
   Log := BuildLogWriter([
      TLoggerProFileAppender.Create,
      TVCLListBoxAppender.Create(lbLog, 2000, UILogFormat)
   ]);

   ARDB.DriverName := 'SQLite';
   ARDB.Params.Add('OpenMode = CreateUTF8');
   ARDB.Params.Add('CharacterSet = UTF8');

   Controller := TARGeneratorController.Create;
   Controller.Log        := Log;
   Controller.ARDB       := ARDB;

   {Initializes the Connection to avoid the design-time values}
   DBConnection.Params.Text := '';
   DBConnection.DriverName  := '';
   DBConnection.LoginPrompt := False;

   Controller.Connection          := DBConnection;
   Controller.NameCase            := RadioGroupNameCase;
   Controller.FieldNameFormatting := RadioGroupFieldNameFormatting;
   Controller.ClassAsAbstract     := CheckBoxClassAsAbstract;
   Controller.WithMappingRegistry := CheckBoxWithMappingRegistry;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Controller.Free;
end;

procedure TMain.DisableVisualEvents;
begin
   RadioGroupNameCase.OnClick            := nil;
   RadioGroupFieldNameFormatting.OnClick := nil;
   CheckBoxClassAsAbstract.OnClick       := nil;
   CheckBoxWithMappingRegistry.OnClick   := nil;
end;

procedure TMain.EnableVisualEvents;
begin
   RadioGroupNameCase.OnClick            := RadioGroupNameCaseClick;
   RadioGroupFieldNameFormatting.OnClick := RadioGroupFieldNameFormattingClick;
   CheckBoxClassAsAbstract.OnClick       := CheckBoxClassAsAbstractClick;
   CheckBoxWithMappingRegistry.OnClick   := CheckBoxWithMappingRegistryClick;
end;

procedure TMain.GridTablesDblClick(Sender: TObject);
var EditTable :TEditTableForm;
begin
   if FProjectName.IsEmpty then Exit;

   EditTable := TEditTableForm.Create(nil);
   try
      // Configure the properties of the form before show it.
      EditTable.TableName  := dsTablesTABLE_NAME.AsString;
      EditTable.ClassName  := dsTablesCLASS_NAME.AsString;
      EditTable.DeployPath := dsTablesDEPLOY_PATH.AsString;

      // Show the form in Modal state
      if EditTable.ShowModal = mrOK then begin
         // Recover the data modified after close the form.
         dsTables.Edit;
         dsTablesCLASS_NAME.AsString  := EditTable.ClassName;
         dsTablesDEPLOY_PATH.AsString := EditTable.DeployPath;
         dsTables.Post;
         Controller.SaveCurrentViewTableToMemory(dsTables);
         FModified := True;
      end;
   finally
      EditTable.Free;
   end;
end;

procedure TMain.GridTablesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   GridTables.DrawingStyle := gdsClassic;
   GridTables.Columns[0].Title.Color := clBtnShadow;
   GridTables.Columns[1].Title.Color := clBtnShadow;

   GridTables.Columns[0].Color := clBtnShadow;
end;

procedure TMain.ActionConnectDatabaseExecute(Sender: TObject);
var FDConnEditor :TfrmFDGUIxFormsConnEdit;
begin
   FDConnEditor := TfrmFDGUIxFormsConnEdit.Create(Self);
   try
      if FDConnEditor.Execute(DBConnection, 'Connect to Database', nil) then begin
         DBConnection.Open; {No exception management. The user is a programmer. Don't forget it!}
         ActionRefreshMetadata.Execute;
         FModified := True;
      end;
   finally
      FDConnEditor.Free;
   end;
end;

procedure TMain.ActionConnectDatabaseUpdate(Sender: TObject);
begin
   ActionConnectDatabase.Enabled := ARDB.Connected;
end;

procedure TMain.ActionGenerateAllExecute(Sender: TObject);
var FileName    :string;
    OverwriteIt :Boolean;
    MarkTable   :TBookmark;
    MarkField   :TBookmark;
    EntityCount :Integer;
begin
   EntityCount := 0;
   Log.Info('Starting entities generation and saving', LOG_TAG);
   // Save current positions
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      OverwriteIt := False;
      dsTables.First;
      while not dsTables.EOF do begin
         {Generate the code for each table in MemoOutputCode}
         Controller.GenerateCode(MemoOutputCode.Lines,
                                 dsTablesTABLE_NAME.AsString,
                                 dsTablesCLASS_NAME.AsString,
                                 dsFields,
                                 CheckBoxClassAsAbstract.Checked,
                                 RadioGroupNameCase.Items[RadioGroupNameCase.ItemIndex],
                                 CheckBoxWithMappingRegistry.Checked,
                                 RadioGroupFieldNameFormatting.ItemIndex = 1);
         Log.Info('Code for table '+dsTablesTABLE_NAME.AsString +' has been generated', LOG_TAG);

         // Generates the FileName where to save the code
         FileName := dsTablesDEPLOY_PATH.AsString + PathDelim + Controller.GetUnitName(dsTABLESCLASS_NAME.AsString) + '.pas';
         // Verify if the file exists previously
         if FileExists(FileName) then begin
            if not OverwriteIt then begin
               case MessageDlg(Format('The file "%s" preiously exists. Overwrite it?', [FileName]), mtConfirmation, [mbYes, mbYesToAll, mbNo, mbCancel], 0) of
                  mrYes: begin
                     MemoOutputCode.Lines.SaveToFile(FileName);
                     Inc(EntityCount);
                     Log.Info('File '+FileName+' rewrited.', LOG_TAG);
                  end;
                  mrYesToAll: begin
                     MemoOutputCode.Lines.SaveToFile(FileName); {Overwrite current and all the next}
                     Inc(EntityCount);
                     OverwriteIt := True;
                     Log.Info('All the next file are going to be overwrite if them exists previously.', LOG_TAG);
                  end;
                  mrNo: begin // Do not overwrite. Continue with the next iteration
                     Log.Info('File '+FileName+' has not been generated.', LOG_TAG);
                     dsTables.Next;
                     Continue;
                  end;
                  mrCancel: begin// Abortar el proceso de guardado
                     Log.Info('Operation of save file canceled by the user', LOG_TAG);
                     Break;
                  end;
               end;
            end
            else begin
               // Save the file because the user decided to overwrite all
               MemoOutputCode.Lines.SaveToFile(FileName);
               Inc(EntityCount);
               Log.Info('File '+FileName+' has been saved', LOG_TAG);
            end;
         end
         else begin
            // Save the file without issues
            MemoOutputCode.Lines.SaveToFile(FileName);
            Inc(EntityCount);
            Log.Info('File '+FileName+' has been saved', LOG_TAG);
         end;
         dsTables.Next;
      end;
      // Restore previous positons
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
      Log.Info('Generated %d entities', [EntityCount],  LOG_TAG);
   end;
end;

procedure TMain.ActionGenerateAllUpdate(Sender: TObject);
begin
   ActionGenerateAll.Enabled := not FProjectName.IsEmpty;
end;

procedure TMain.ActionGenerateCurrentExecute(Sender: TObject);
var FileName :string;
begin
   Controller.GenerateCode(MemoOutputCode.Lines,
                           dsTablesTABLE_NAME.AsString,
                           dsTablesCLASS_NAME.AsString,
                           dsFields,
                           CheckBoxClassAsAbstract.Checked,
                           RadioGroupNameCase.Items[RadioGroupNameCase.ItemIndex],
                           CheckBoxWithMappingRegistry.Checked,
                           RadioGroupFieldNameFormatting.ItemIndex = 1);
   Log.Info('Code for table '+dsTablesTABLE_NAME.AsString +' has been generated', LOG_TAG);

   FileName := dsTablesDEPLOY_PATH.AsString + PathDelim + Controller.GetUnitName(dsTABLESCLASS_NAME.AsString) + '.pas';
   if FileExists(FileName) then begin
      case MessageDlg('The File '+FileName+' previously exists. Rewrite it?', mtConfirmation, mbYesNo, 0) of
         mrYes: begin
            MemoOutputCode.Lines.SaveToFile(FileName);
            Log.Info('File '+FileName+' rewrited.', LOG_TAG);
         end;
         mrNo: Log.Info('Saving of file '+FileName +' aborted.', LOG_TAG);
      end;
   end
   else begin
      MemoOutputCode.Lines.SaveToFile(FileName);
      Log.Info('File '+FileName+' has been saved', LOG_TAG);
   end;
end;

procedure TMain.ActionGenerateCurrentUpdate(Sender: TObject);
begin
   ActionGenerateCurrent.Enabled := not FProjectName.IsEmpty;
end;

procedure TMain.ActionRefreshMetadataExecute(Sender: TObject);
begin
   Controller.RefreshMetadata(RadioGroupFieldNameFormatting.ItemIndex = 1);
   SetOnViewDataFromMemory;
end;

procedure TMain.SetOnViewDataFromMemory;
begin
   {Fill with data from Database}
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      Controller.FillViewData(dsTables, dsFields);
      TabSheetTables.Caption := 'Tables (' + dsTables.RecordCount.ToString + ')';
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
   end;
end;

procedure TMain.ActionRefreshMetadataUpdate(Sender: TObject);
begin
   ActionRefreshMetadata.Enabled := ARDB.Connected and DBConnection.Connected;
end;

procedure TMain.ActionNewProjectExecute(Sender: TObject);
begin
   {$Message Warn 'Be sure all is correct before create a new project'}
   {ARDB Connected means that there are a Database in Memory}
   if ARDB.Connected then begin
      {if there are changes not saved to disk}
      if FModified then begin


      end;
   end
   else begin
      {$Message Warn 'Initialize all the data'}
      Controller.CreateEntGenDB;
      dsTables.Open;
      dsFields.Open;
      FProjectName := NOT_SAVED_PROJECT_NAME;
      FModified    := True;
      Caption      := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [FProjectName, DMVCFRAMEWORK_VERSION]);
      Log.Info('Created and empty project', LOG_TAG);
   end;
end;

procedure TMain.ActionSaveProjectAsExecute(Sender: TObject);
begin
   {Get the desired project name}
   DialogSaveProject.FileName := FProjectName;
   if DialogSaveProject.Execute then begin
      FProjectName := ExtractFileName(DialogSaveProject.FileName);
      Caption      := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [FProjectName, DMVCFRAMEWORK_VERSION]);
      Log.Info('Project '+FProjectName+' ready to be saved.', LOG_TAG);
      ActionSaveProject.Execute;
   end
   else Exit;
end;

procedure TMain.ActionSaveProjectAsUpdate(Sender: TObject);
begin
   ActionSaveProjectAs.Enabled := FModified;
end;

procedure TMain.ActionSaveProjectExecute(Sender: TObject);
begin
   {Saves all the pendant changes to memory database}
   if FProjectName = NOT_SAVED_PROJECT_NAME then begin
      DialogSaveProject.DefaultFolder := ExtractFilePath(ParamStr(0));
      FProjectName := DEFAULT_PROJECT_NAME;
      ActionSaveProjectAs.Execute;
   end
   else begin
      if Controller.SaveProject(FProjectName) then begin
         FModified    := False;
         ActionRefreshMetadata.Execute;
         Caption := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [FProjectName, DMVCFRAMEWORK_VERSION]);
         Log.Info(Format('Database %s saved on disk', [FProjectName]), LOG_TAG);
      end
      else begin
         Log.Info('Project '+FProjectName+' failed to be saved on disk.', LOG_TAG);
         raise Exception.Create('Error saving data');
      end;
   end;
end;

procedure TMain.ActionOpenProjectExecute(Sender: TObject);
begin
   {The project has not modifications}
   if (FModified) or (FProjectName <> NOT_SAVED_PROJECT_NAME) or (not DBConnection.Params.IsEmpty) then begin
      case MessageDlg(Format('Current changes in the project will be lost. Continue?', [TPath.GetFileName(FProjectName)]), mtConfirmation, [mbYes, mbCancel], 0) of
         mrCancel: Exit;
      end;
   end;

   {The project name was never saved}
   if ProjectOpenDialog.Execute then begin
      FProjectName := ExtractFileName(ProjectOpenDialog.FileName);
      DisableVisualEvents;
      try
         if Controller.LoadProject(FProjectName) then begin
            dsTables.Open;
            dsFields.Open;
            SetOnViewDataFromMemory;
            if not DBConnection.Params.IsEmpty then begin
               DBConnection.Open;
            end;
            FModified := False;
            Caption := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [FProjectName, DMVCFRAMEWORK_VERSION]);
         end;
      finally
         EnableVisualEvents;
      end;
   end;
end;

procedure TMain.ActionSaveProjectUpdate(Sender: TObject);
begin
   ActionSaveProject.Enabled := FModified;
end;

procedure TMain.CheckBoxClassAsAbstractClick(Sender: TObject);
begin
   FModified := True;
end;

procedure TMain.CheckBoxWithMappingRegistryClick(Sender: TObject);
begin
   FModified := True;
end;

procedure TMain.GridFieldsDblClick(Sender: TObject);
var EditField :TEditFieldForm;
begin
   if FProjectName.IsEmpty then Exit;

   EditField := TEditFieldForm.Create(nil);
   try
      { Configure the properties of the form before show it. }
      EditField.TableName  := dsFieldsTABLE_NAME.AsString;
      EditField.FieldName  := dsFieldsFIELD_NAME.AsString;
      EditField.CustomName := dsFieldsCUSTOM_NAME.AsString;

      { Show the form in Modal state }
      if EditField.ShowModal = mrOK then begin
         { Recover the data modified after close the form. }
         dsFields.Edit;
         dsFieldsCUSTOM_NAME.AsString := EditField.CustomName;
         dsFields.Post;
         Controller.SaveCurrentViewFieldToMemory(dsFields);
         FModified := True;
      end;
   finally
      EditField.Free;
   end;
end;

procedure TMain.GridFieldsDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   GridFields.DrawingStyle           := gdsClassic;
   GridFields.Columns[0].Title.Color := clBtnShadow;
   GridFields.Columns[1].Title.Color := clBtnShadow;
   GridFields.Columns[0].Color       := clBtnShadow;
end;

procedure TMain.RadioGroupFieldNameFormattingClick(Sender: TObject);
begin
   FModified := True;
end;

procedure TMain.RadioGroupNameCaseClick(Sender: TObject);
begin
   FModified := True;
end;

procedure TMain.ResetUI;
begin
   RadioGroupNameCase.ItemIndex            := 0;
   RadioGroupFieldNameFormatting.ItemIndex := 0;
   CheckBoxClassAsAbstract.Checked         := False;
   CheckBoxWithMappingRegistry.Checked     := False;

   dsFields.EmptyDataSet;
   dsTables.EmptyDataSet;
end;

end.
