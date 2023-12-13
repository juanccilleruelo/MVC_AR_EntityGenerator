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
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Moni.FlatFile,
  JsonDataObjects, System.Actions,
  LoggerPro.FileAppender,
  LoggerPro.VCLListBoxAppender,
  LoggerPro,
  FireDAC.Moni.RemoteClient, FireDAC.Moni.Custom, FireDAC.Moni.Base,
  ARGeneratorController;

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
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    ActionLoadProject: TAction;
    ActionSaveProject: TAction;
    ActionSaveProjectAs: TAction;
    File1: TMenuItem;
    LoadProject1: TMenuItem;
    SaveProject1: TMenuItem;
    Saveprojectas1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    ActionRefreshTableList: TAction;
    DialogSaveProject: TFileSaveDialog;
    ActionNewProject: TAction;
    NewProject1: TMenuItem;
    ImageListMainMenu: TImageList;
    ImageListButtons: TImageList;
    Entities1: TMenuItem;
    RefreshCatalog1: TMenuItem;
    RefreshTableList1: TMenuItem;
    GenerateCode1: TMenuItem;
    SaveGeneratedCode1: TMenuItem;
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
    CheckBoxWithMappingRegistry: TCheckBox;
    RadioGroupNameCase: TRadioGroup;
    RadioGroupFieldNameFormatting: TRadioGroup;
    gbOptions: TGroupBox;
    Label5: TLabel;
    CheckBoxClassAsAbstract: TCheckBox;
    Panel10: TPanel;
    btnGetTables: TButton;
    BtnEditConnection: TButton;
    PageControl: TPageControl;
    TabSheetTables: TTabSheet;
    Splitter2: TSplitter;
    Panel7: TPanel;
    GridTables: TDBGrid;
    GridFields: TDBGrid;
    TabSheetSource: TTabSheet;
    MemoOutputCode: TMemo;
    PanelSource: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionLoadProjectExecute(Sender: TObject);
    procedure ActionSaveProjectExecute(Sender: TObject);
    procedure ActionSaveProjectAsExecute(Sender: TObject);
    procedure ActionNewProjectExecute(Sender: TObject);
    procedure BtnEditConnectionClick(Sender: TObject);
    procedure GridTablesDblClick(Sender: TObject);
    procedure GridFieldsDblClick(Sender: TObject);
    procedure ActionSaveProjectUpdate(Sender: TObject);
    procedure GridTablesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridFieldsDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ActionGenerateCurrentExecute(Sender: TObject);
    procedure ActionGenerateAllExecute(Sender: TObject);
    procedure ActionGenerateCurrentUpdate(Sender: TObject);
    procedure ActionGenerateAllUpdate(Sender: TObject);
  private
    FProjectName     :string;
    FModified        :Boolean;

    FConfig          :TJSONObject;
    FHistoryFileName :string;
    Log              :ILogWriter;
    Controller       :TARGeneratorController; {Controller of this project}
    procedure ResetUI;
    {***} procedure LoadProjectFromFile;
    {***} procedure SaveProject;
    procedure SetProjectName(const Value: String);
  public
    property ProjectName :string read FProjectName write SetProjectName;
  end;

var
  Main: TMain;

const
   CONFIG_FILE          = 'lastConfig.json';
   DEFAULT_PROJECT_NAME = 'EntitiesDB.entgen';
   LOG_TAG              = 'generator';

implementation

uses System.IOUtils,
     System.TypInfo,
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

   {Configures LoggerPro}
   UILogFormat := '%0:s [%2:-10s] %3:s';
   Log := BuildLogWriter([
      TLoggerProFileAppender.Create,
      TVCLListBoxAppender.Create(lbLog, 2000, UILogFormat)
   ]);

   FConfig          := TJSONObject.Create;
   FHistoryFileName := TPath.Combine(TPath.GetDocumentsPath, TPath.GetFileNameWithoutExtension(ParamStr(0)) + '.history');

   Log.Info('Selecting ConnectionDef: ' + DBConnection.Params.Database, LOG_TAG);
   //DBConnection.Open;

   ARDB.DriverName := 'SQLite';
   ARDB.Params.Add('OpenMode = CreateUTF8');
   ARDB.Params.Add('CharacterSet = UTF8');

   //Controller.ProjectName := 'ARGenerator';
   //ARDB.Params.Database   := Controller.DBName;

   Controller := TARGeneratorController.Create;
   Controller.Log := Log;

   (*Creation of the Database
   Controller.Connection := ARDB;
   Controller.OpenDB;

   Controller.PopulateDB(DBConnection, RadioGroupFieldNameFormatting.ItemIndex = 1);
   ARDB.Open;

   dsTables.Open;
   dsFields.Open;
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

   dsTables.Open;      *)

   ActionRefreshTableList.Execute;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FConfig.Free;
   Controller.Free;
end;

procedure TMain.GridTablesDblClick(Sender: TObject);
var EditTable :TEditTableForm;
begin
   if FProjectName.IsEmpty then Exit;

   EditTable := TEditTableForm.Create(nil);
   try
      // Configure the properties of the form before show it.
      EditTable.TableName := dsTablesTABLE_NAME.AsString;
      EditTable.ClassName := dsTablesCLASS_NAME.AsString;

      // Show the form in Modal state
      if EditTable.ShowModal = mrOK then begin
         // Recover the data modified after close the form.
         dsTables.Edit;
         dsTablesCLASS_NAME.AsString := EditTable.ClassName;
         dsTables.Post;
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

(*mbOK       mrOk
mbCancel   mrCancel
mbYes      mrYes
mbNo       mrNo
mbAbort    mrAbort
mbRetry    mrRetry
mbIgnore   mrIgnore
mbAll      mrAll
mbNoToAll  mrNoToAll
mbYesToAll mrYesToAll
mbClose    mrClose
*)

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
                                  DBConnection,
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
                           DBConnection,
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

procedure TMain.ActionLoadProjectExecute(Sender: TObject);
begin
   ProjectOpenDialog.DefaultExtension := 'entgen';
   if ProjectOpenDialog.Execute then begin
      ProjectName := ProjectOpenDialog.FileName;
      LoadProjectFromFile;
   end;
end;

procedure TMain.ActionNewProjectExecute(Sender: TObject);
begin
   DialogSaveProject.DefaultFolder := ExtractFilePath(ParamStr(0));
   DialogSaveProject.FileName      := DEFAULT_PROJECT_NAME;
   if DialogSaveProject.Execute then begin
      ProjectName := DialogSaveProject.FileName;
      //LoadProjectFromFile;
   end;
end;

procedure TMain.ActionSaveProjectAsExecute(Sender: TObject);
begin
   if DialogSaveProject.Execute then begin
      ProjectName := DialogSaveProject.FileName;
      SaveProject;
   end;
end;

procedure TMain.ActionSaveProjectExecute(Sender: TObject);
var MarkTable :TBookmark;
    MarkField :TBookmark;
begin
   // Save current positions
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      Controller.SaveProject(dsTables, dsFields);

      // Restore previous positons
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
   end;
end;

procedure TMain.ActionSaveProjectUpdate(Sender: TObject);
begin
   ActionSaveProject.Enabled := FModified;
end;

procedure TMain.BtnEditConnectionClick(Sender: TObject);
var FDConnEditor :TfrmFDGUIxFormsConnEdit;
begin
    FDConnEditor := TfrmFDGUIxFormsConnEdit.Create(Self);
    try
       FDConnEditor.Execute(DBConnection, 'Caption', nil);
    finally
       FDConnEditor.Free;
    end;
end;

procedure TMain.GridFieldsDblClick(Sender: TObject);
var EditField :TEditFieldForm;
begin
   if FProjectName.IsEmpty then Exit;

   EditField := TEditFieldForm.Create(nil);
   try
      // Configure the properties of the form before show it.
      EditField.TableName  := dsFieldsTABLE_NAME.AsString;
      EditField.FieldName  := dsFieldsFIELD_NAME.AsString;
      EditField.CustomName := dsFieldsCUSTOM_NAME.AsString;

      // Show the form in Modal state
      if EditField.ShowModal = mrOK then begin
         // Recover the data modified after close the form.
         dsFields.Edit;
         dsFieldsCUSTOM_NAME.AsString := EditField.CustomName;
         dsFields.Post;
         FModified := True;
      end;
   finally
      EditField.Free;
   end;
end;

procedure TMain.GridFieldsDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   GridFields.DrawingStyle := gdsClassic;
   GridFields.Columns[0].Title.Color := clBtnShadow;
   GridFields.Columns[1].Title.Color := clBtnShadow;

   GridFields.Columns[0].Color := clBtnShadow;
end;

procedure TMain.LoadProjectFromFile;
var i :Integer;
    j :Integer;
begin
   ResetUI;

   if not TFile.Exists(FProjectName) then Exit;

   FConfig.LoadFromFile(FProjectName);

   ActionRefreshTableList.Execute;

   RadioGroupNameCase.ItemIndex            := FConfig.I[RadioGroupNameCase.Name];
   RadioGroupFieldNameFormatting.ItemIndex := FConfig.I[RadioGroupFieldNameFormatting.Name];
   CheckBoxWithMappingRegistry.Checked     := FConfig.B[CheckBoxWithMappingRegistry.Name];

(*   DTables.First;
   I := 0;
   while not DTables.EOF do begin
      lJObj := FConfig.A['tables'].Items[I].ObjectValue;
      if lJObj.S['TABLE_NAME'] = DTablesTABLE_NAME.AsString then begin
         DTables.Edit;
         try
            for j := 0 to lJObj.Count - 1 do begin
               if Assigned(DTables.FindField(lJObj.Names[J])) then begin
                  DTables.Fields[J].AsString := lJObj.S[lJObj.Names[J]];
               end;
            end;
            Inc(I);
         finally
            DTables.Post;
         end;
      end;
      DTables.Next;
   end;
   DTables.First;*)

   //EditOutputFileName.Text := fConfig.S[EditOutputFileName.Name];
end;

procedure TMain.ResetUI;
begin
   RadioGroupNameCase.ItemIndex            := 0;
   RadioGroupFieldNameFormatting.ItemIndex := 0;
   CheckBoxWithMappingRegistry.Checked     := False;
   dsTables.EmptyDataSet;
end;

procedure TMain.SaveProject;
var JObj  :TJSONObject;
    Field :TField;
begin
   FConfig.I[RadioGroupNameCase.Name           ] := RadioGroupNameCase.ItemIndex;
   FConfig.I[RadioGroupFieldNameFormatting.Name] := RadioGroupFieldNameFormatting.ItemIndex;
   FConfig.B[CheckBoxWithMappingRegistry.Name  ] := CheckBoxWithMappingRegistry.Checked;
   //FConfig.S[EditOutputFileName.Name] := EditOutputFileName.Text;

   (*fConfig.Remove('tables');
   DTables.First;
   while not DTables.Eof do begin
      JObj := fConfig.A['tables'].AddObject;
      for Field in DTables.Fields do begin
         JObj.S[Field.FieldName] := Field.AsString;
      end;
      DTables.Next;
   end;

   DTables.First;*)
   FConfig.SaveToFile(FProjectName, False);
end;

procedure TMain.SetProjectName(const Value: String);
begin
   FProjectName := Value;
   if not FileExists(FProjectName) then begin
      Controller.Connection := ARDB;
      Controller.CreateEntGenDB(FProjectName);
      Caption := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [FProjectName, DMVCFRAMEWORK_VERSION]);
      Log.Info('Project '+FProjectName+' created.', LOG_TAG);
   end
   else begin
      case MessageDlg(Format('The project "%s" preiously exists. Overwrite it?', [TPath.GetFileName(FProjectName)]), mtConfirmation, [mbYes, mbCancel], 0) of
         mrYes: begin

            Controller.CreateEntGenDB(FProjectName);
            Caption := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [FProjectName, DMVCFRAMEWORK_VERSION]);
            Log.Info('Project '+FProjectName+' rewrited.', LOG_TAG);
         end;
         mrCancel: begin// Abortar el proceso de guardado
            Log.Info('Operation of create a new Project canceled by thee user', LOG_TAG);
            FProjectName := '';
            Caption := Format('DMVCFramework Entities Generator :: (Without project open)', [FProjectName, DMVCFRAMEWORK_VERSION]);
         end;
      end;
   end;
end;

end.
