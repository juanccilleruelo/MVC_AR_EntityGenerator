unit MainForm;

interface

uses
  Data.DB,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBGrids, Vcl.Buttons, Vcl.ActnList, Vcl.Menus, Vcl.StdActns,
  Vcl.ExtActns, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.ValEdit,
  VCL.Themes,
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
    DialogOpenProject: TFileOpenDialog;
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
    ActionConnectDatabase: TAction;
    dsTablesDECLARE_AS_ABSTRACT: TStringField;
    dsTablesREGISTER_ENTITY: TStringField;
    PopupMenuGridTables: TPopupMenu;
    MenuItemEditTable: TMenuItem;
    ActionEditTable: TAction;
    PopupMenuEditField: TPopupMenu;
    MenuItemEditRow: TMenuItem;
    ActionEditField: TAction;
    PopupMenuDeclareAsAbstract: TPopupMenu;
    MenuItemMarkAllDeclareAsAbstract: TMenuItem;
    MenuItemUnmarkAllDelcareAsAbstract: TMenuItem;
    MenuItemInvertDeclareAsAbstract: TMenuItem;
    PopupMenuRegisterEntity: TPopupMenu;
    MenuItemMarkAllRegisterEntity: TMenuItem;
    MenuItemUnmarkAllRegisterEntity: TMenuItem;
    MenuItemInvertMarksRegisterEntity: TMenuItem;
    ActionMarkAllDeclareAsAbstract: TAction;
    ActionUnmarkAllDeclareAsAbstract: TAction;
    ActionInvertMarksDeclareAsAbstract: TAction;
    ActionMarkAllRegisterEntity: TAction;
    ActionUnmarkAllRegisterEntity: TAction;
    ActionInvertMarksRegisterEntity: TAction;
    MenuItemOpenRecent: TMenuItem;
    MenuItemReopenLastOneOnEnter: TMenuItem;
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

    procedure ActionSaveProjectAsUpdate(Sender: TObject);
    procedure MenuItemEditTableClick(Sender: TObject);
    procedure ActionEditTableExecute(Sender: TObject);
    procedure ActionEditFieldExecute(Sender: TObject);
    procedure GridTablesTitleClick(Column: TColumn);
    procedure ActionMarkAllDeclareAsAbstractExecute(Sender: TObject);
    procedure ActionUnmarkAllDeclareAsAbstractExecute(Sender: TObject);
    procedure ActionInvertMarksDeclareAsAbstractExecute(Sender: TObject);
    procedure ActionMarkAllRegisterEntityExecute(Sender: TObject);
    procedure ActionUnmarkAllRegisterEntityExecute(Sender: TObject);
    procedure ActionInvertMarksRegisterEntityExecute(Sender: TObject);
  private
    RegRoot       :string;  {Windows Registry Root}
    FRecentlyOpen :TStringList;
    FFileName     :string; {The complete path of the poject. With file name.}
    FModified     :Boolean; {Changes not saved on disk}
    Log           :ILogWriter;
    Controller    :TARGeneratorController; {Controller of this project}
    procedure ResetAllData;
    procedure LoadProject;
    procedure SetOnViewDataFromMemory;
    procedure DisableVisualEvents;
    procedure EnableVisualEvents;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure UpdateOpenRecentSubItems;
    procedure MenuItemOpenRecent_OnClick(Sender: TObject);
    procedure SetLastOpened(AFileName :string);
    function GetProjectName:string;

    property ProjectName :string read GetProjectName; {The name of the project. Without path.}
  public
  end;

var
  Main: TMain;

const
   DEFAULT_PROJECT_NAME   = 'EntitiesDB.entgen';
   LOG_TAG                = 'generator';
   NOT_SAVED_PROJECT_NAME = 'Untitled.entgen';

   REG_REOPEN_LAST = 'ReopenLast';
   REG_LAST_0      = 'Last Opened 0';
   REG_LAST_1      = 'Last Opened 1';
   REG_LAST_2      = 'Last Opened 2';
   REG_LAST_3      = 'Last Opened 3';
   REG_LAST_4      = 'Last Opened 4';
   REG_LAST_5      = 'Last Opened 5';
   REG_LAST_6      = 'Last Opened 6';
   REG_LAST_7      = 'Last Opened 7';
   REG_LAST_8      = 'Last Opened 8';
   REG_LAST_9      = 'Last Opened 9';

implementation

uses System.IOUtils,
     System.TypInfo,
     System.UITypes,
     System.DateUtils,
     System.Win.Registry,
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
    i           :Integer;
begin
   FModified    := False;
   FFileName    := ExtractFilePath(ParamStr(0)) + NOT_SAVED_PROJECT_NAME;

   FRecentlyOpen := TStringList.Create;
   for i := 0 to 9 do FRecentlyOpen.Add('');

   DialogOpenProject.DefaultExtension := 'entgen';

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
   Controller.CreateEntGenDB;

   RegRoot := '\Software\'+TPath.GetFileNameWithoutExtension(ParamStr(0));
   LoadSettings;
   UpdateOpenRecentSubItems;



   { Open the last project used, if configured }
   if (MenuItemOpenRecent.Count > 0) and (MenuItemReopenLastOneOnEnter.Checked) then begin
      FFileName := FRecentlyOpen[0];

      LoadProject;
   end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   SaveSettings;
   FRecentlyOpen.Free;
   Controller.Free;
end;

procedure TMain.DisableVisualEvents;
begin
   RadioGroupNameCase.OnClick            := nil;
   RadioGroupFieldNameFormatting.OnClick := nil;
end;

procedure TMain.EnableVisualEvents;
begin
   RadioGroupNameCase.OnClick            := RadioGroupNameCaseClick;
   RadioGroupFieldNameFormatting.OnClick := RadioGroupFieldNameFormattingClick;
end;

procedure TMain.LoadSettings;
var Reg :TRegistry;
begin
   Reg := TRegistry.Create;
   Reg.RootKey := HKEY_CURRENT_USER;
   try
      if not Reg.KeyExists(RegRoot) then begin
         Reg.CreateKey(RegRoot);
         try
            { Second param is True, because we want to create it if it doesn't exist }
            Reg.OpenKey(RegRoot, True);
            Reg.WriteString(REG_REOPEN_LAST, 'Y');
            Reg.WriteString(REG_LAST_0     , '');
            Reg.WriteString(REG_LAST_1     , '');
            Reg.WriteString(REG_LAST_2     , '');
            Reg.WriteString(REG_LAST_3     , '');
            Reg.WriteString(REG_LAST_4     , '');
            Reg.WriteString(REG_LAST_5     , '');
            Reg.WriteString(REG_LAST_6     , '');
            Reg.WriteString(REG_LAST_7     , '');
            Reg.WriteString(REG_LAST_8     , '');
            Reg.WriteString(REG_LAST_9     , '');
         finally
            Reg.CloseKey;
         end;
      end
      else begin
         Reg.OpenKey(RegRoot, False);
         try
            MenuItemReopenLastOneOnEnter.Checked := Reg.ReadString(REG_REOPEN_LAST) = 'Y';
            FRecentlyOpen[0] := Reg.ReadString(REG_LAST_0);
            FRecentlyOpen[1] := Reg.ReadString(REG_LAST_1);
            FRecentlyOpen[2] := Reg.ReadString(REG_LAST_2);
            FRecentlyOpen[3] := Reg.ReadString(REG_LAST_3);
            FRecentlyOpen[4] := Reg.ReadString(REG_LAST_4);
            FRecentlyOpen[5] := Reg.ReadString(REG_LAST_5);
            FRecentlyOpen[6] := Reg.ReadString(REG_LAST_6);
            FRecentlyOpen[7] := Reg.ReadString(REG_LAST_7);
            FRecentlyOpen[8] := Reg.ReadString(REG_LAST_8);
            FRecentlyOpen[9] := Reg.ReadString(REG_LAST_9);
         finally
            Reg.CloseKey;
         end;
      end;
   finally
      Reg.Free;
   end;
end;

procedure TMain.SaveSettings;
var Reg :TRegistry;
begin
   Reg := TRegistry.Create;
   Reg.RootKey := HKEY_CURRENT_USER;
   try
      Reg.OpenKey(RegRoot, False);
      try
         if MenuItemReopenLastOneOnEnter.Checked then
            Reg.WriteString(REG_REOPEN_LAST, 'Y')
         else
            Reg.WriteString(REG_REOPEN_LAST, 'N');

         Reg.WriteString(REG_LAST_0, FRecentlyOpen[0]);
         Reg.WriteString(REG_LAST_1, FRecentlyOpen[1]);
         Reg.WriteString(REG_LAST_2, FRecentlyOpen[2]);
         Reg.WriteString(REG_LAST_3, FRecentlyOpen[3]);
         Reg.WriteString(REG_LAST_4, FRecentlyOpen[4]);
         Reg.WriteString(REG_LAST_5, FRecentlyOpen[5]);
         Reg.WriteString(REG_LAST_6, FRecentlyOpen[6]);
         Reg.WriteString(REG_LAST_7, FRecentlyOpen[7]);
         Reg.WriteString(REG_LAST_8, FRecentlyOpen[8]);
         Reg.WriteString(REG_LAST_9, FRecentlyOpen[9]);
      finally
         Reg.CloseKey;
      end;
   finally
      Reg.Free;
   end;
end;

procedure TMain.UpdateOpenRecentSubItems;
var i        :Integer;
    FileName :string;
    MenuItem :TMenuItem;
begin
   { Delete all MenuItems owned by MenuItemOpenRecent }
   MenuItemOpenRecent.Clear; // removes submenu items

   {Insert the new Menu Items}
   for i := 0 to 9 do begin
      FileName := FRecentlyOpen[i];
      if not FileName.IsEmpty then begin
         MenuItem := TMenuItem.Create(MenuItemOpenRecent);
         MenuItem.Caption := Format('%d %s', [i, FileName]);
         MenuItem.OnClick := MenuItemOpenRecent_OnClick;
         MenuItemOpenRecent.Add(MenuItem);
      end;
  end;
end;

procedure TMain.MenuItemOpenRecent_OnClick(Sender: TObject);
begin
   {The project has not modifications}
   if (FModified) or (ProjectName <> NOT_SAVED_PROJECT_NAME) or (not DBConnection.Params.IsEmpty) then begin
      case MessageDlg(Format('Current changes in the project will be lost. Continue?', [ProjectName]), mtConfirmation, [mbYes, mbCancel], 0) of
         mrCancel: Exit;
      end;
   end;
   FFileName := TMenuItem(Sender).Caption.SubString(3);
   LoadProject;
end;

function TMain.GetProjectName:string;
begin
   Result := ExtractFileName(FFileName);
end;

procedure TMain.SetLastOpened(AFileName :string);
var i     :Integer;
    Index :Integer;
begin
   // Set this file as the last opened by the user.

   { If the file is in the first position, nothing to do}
   if FRecentlyOpen[0] = AFileName then Exit;

   { if the file is in the list }
   Index := FRecentlyOpen.IndexOf(AFileName);
   if Index <> -1 then begin
      { Move the downpart of the list to fill the gap }
      for i := Index downto 1 do FRecentlyOpen[i] := FRecentlyOpen[i -1];

      //Put AFileName in the first position.
      FRecentlyOpen[0] := AFileName;
   end
   { Move all to the next position, loosing the last and
     put the new in the first position }
   else begin
      { Move all to the next position }
      for i := 9 downto 1 do FRecentlyOpen[i] := FRecentlyOpen[i-1];

      //Put AFileName in the first position.
      FRecentlyOpen[0] := AFileName;
   end;
end;

procedure TMain.GridTablesDblClick(Sender: TObject);
begin
   ActionEditTable.Execute;
end;

procedure TMain.GridTablesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const CtrlState   :array[Boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var CheckBoxRectangle :TRect;
begin
   GridTables.DrawingStyle := gdsClassic;
   GridTables.Columns[0].Title.Color := clBtnShadow;
   GridTables.Columns[1].Title.Color := clBtnShadow;

   GridTables.Columns[0].Color := clBtnShadow;

   if (Column.FieldName = 'REGISTER_ENTITY') or (Column.FieldName = 'DECLARE_AS_ABSTRACT') then begin
      Column.Title.Alignment := taCenter;
      Column.Alignment       := taCenter;
      TDBGrid(Sender).Canvas.FillRect(Rect);

      CheckBoxRectangle.Left   := Rect.Left   + 2;
      CheckBoxRectangle.Right  := Rect.Right  - 2;
      CheckBoxRectangle.Top    := Rect.Top    + 2;
      CheckBoxRectangle.Bottom := Rect.Bottom - 2;
      if Column.Field.AsString = 'Y' then begin
         DrawFrameControl(TDBGrid(Sender).Canvas.Handle, CheckBoxRectangle, DFC_BUTTON, CtrlState[True]);
      end
      else begin
         DrawFrameControl(TDBGrid(Sender).Canvas.Handle, CheckBoxRectangle, DFC_BUTTON, CtrlState[False]);
      end;
   end;
end;

procedure TMain.GridTablesTitleClick(Column: TColumn);
var Point :TPoint;
begin
   if Column.FieldName = 'DECLARE_AS_ABSTRACT' then begin
      if GetCursorPos(Point) then PopupMenuDeclareAsAbstract.Popup(Point.X, Point.Y);
   end else
   if Column.FieldName = 'REGISTER_ENTITY' then begin
      if GetCursorPos(Point) then PopupMenuRegisterEntity.Popup(Point.X, Point.Y);
   end;
end;

procedure TMain.MenuItemEditTableClick(Sender: TObject);
var EditTable :TEditTableForm;
begin
   if ProjectName.IsEmpty then Exit;

   EditTable := TEditTableForm.Create(nil);
   try
      { Configure the properties of the form before show it. }
      EditTable.TableName         := dsTablesTABLE_NAME.AsString;
      EditTable.ClassName         := dsTablesCLASS_NAME.AsString;
      EditTable.DeployPath        := dsTablesDEPLOY_PATH.AsString;
      EditTable.DeclareAsAbstract := dsTablesDECLARE_AS_ABSTRACT.AsString;
      EditTable.RegisterEntity    := dsTablesREGISTER_ENTITY.AsString;

      { Show the form in Modal state }
      if EditTable.ShowModal = mrOK then begin
         { Recover the data modified after close the form. }
         dsTables.Edit;
         dsTablesCLASS_NAME.AsString          := EditTable.ClassName;
         dsTablesDEPLOY_PATH.AsString         := EditTable.DeployPath;
         dsTablesDECLARE_AS_ABSTRACT.AsString := EditTable.DeclareAsAbstract;
         dsTablesREGISTER_ENTITY.AsString     := EditTable.RegisterEntity;
         dsTables.Post;
         Controller.SaveCurrentViewTableToMemory(dsTables);
         FModified := True;
      end;
   finally
      EditTable.Free;
   end;
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

procedure TMain.ActionEditFieldExecute(Sender: TObject);
var EditField :TEditFieldForm;
begin
   if ProjectName.IsEmpty then Exit;

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

procedure TMain.ActionEditTableExecute(Sender: TObject);
var EditTable :TEditTableForm;
begin
   if ProjectName.IsEmpty then Exit;

   EditTable := TEditTableForm.Create(nil);
   try
      { Configure the properties of the form before show it. }
      EditTable.TableName         := dsTablesTABLE_NAME.AsString;
      EditTable.ClassName         := dsTablesCLASS_NAME.AsString;
      EditTable.DeployPath        := dsTablesDEPLOY_PATH.AsString;
      EditTable.DeclareAsAbstract := dsTablesDECLARE_AS_ABSTRACT.AsString;
      EditTable.RegisterEntity    := dsTablesREGISTER_ENTITY.AsString;

      { Show the form in Modal state }
      if EditTable.ShowModal = mrOK then begin
         { Recover the data modified after close the form. }
         dsTables.Edit;
         dsTablesCLASS_NAME.AsString          := EditTable.ClassName;
         dsTablesDEPLOY_PATH.AsString         := EditTable.DeployPath;
         dsTablesDECLARE_AS_ABSTRACT.AsString := EditTable.DeclareAsAbstract;
         dsTablesREGISTER_ENTITY.AsString     := EditTable.RegisterEntity;
         dsTables.Post;
         Controller.SaveCurrentViewTableToMemory(dsTables);
         FModified := True;
      end;
   finally
      EditTable.Free;
   end;
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
   { Save current positions }
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
                                 dsTablesDECLARE_AS_ABSTRACT.AsString = 'Y',
                                 RadioGroupNameCase.Items[RadioGroupNameCase.ItemIndex],
                                 dsTablesREGISTER_ENTITY.AsString = 'Y',
                                 RadioGroupFieldNameFormatting.ItemIndex = 1);
         Log.Info('Code for table '+dsTablesTABLE_NAME.AsString +' has been generated', LOG_TAG);

         { Generates the FileName where to save the code }
         FileName := dsTablesDEPLOY_PATH.AsString + PathDelim + Controller.GetUnitName(dsTABLESCLASS_NAME.AsString) + '.pas';
         { Verify if the file exists previously }
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
                  mrNo: begin { Do not overwrite. Continue with the next iteration }
                     Log.Info('File '+FileName+' has not been generated.', LOG_TAG);
                     dsTables.Next;
                     Continue;
                  end;
                  mrCancel: begin { Abort the saving process }
                     Log.Info('Operation of save file canceled by the user', LOG_TAG);
                     Break;
                  end;
               end;
            end
            else begin
               { Save the file because the user decided to overwrite all }
               MemoOutputCode.Lines.SaveToFile(FileName);
               Inc(EntityCount);
               Log.Info('File '+FileName+' has been saved', LOG_TAG);
            end;
         end
         else begin
            { Save the file without issues }
            MemoOutputCode.Lines.SaveToFile(FileName);
            Inc(EntityCount);
            Log.Info('File '+FileName+' has been saved', LOG_TAG);
         end;
         dsTables.Next;
      end;
      { Restore previous positons }
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
   ActionGenerateAll.Enabled := not ProjectName.IsEmpty;
end;

procedure TMain.ActionGenerateCurrentExecute(Sender: TObject);
var FileName :string;
begin
   Controller.GenerateCode(MemoOutputCode.Lines,
                           dsTablesTABLE_NAME.AsString,
                           dsTablesCLASS_NAME.AsString,
                           dsFields,
                           dsTablesDECLARE_AS_ABSTRACT.AsString = 'Y',
                           RadioGroupNameCase.Items[RadioGroupNameCase.ItemIndex],
                           dsTablesREGISTER_ENTITY.AsString = 'Y',
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
   ActionGenerateCurrent.Enabled := not ProjectName.IsEmpty;
end;

procedure TMain.ActionInvertMarksDeclareAsAbstractExecute(Sender: TObject);
var MarkTable   :TBookmark;
    MarkField   :TBookmark;
begin
   { Save current positions }
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      dsTables.First;
      while not dsTables.EOF do begin
         dsTables.Edit;
         if dsTablesDECLARE_AS_ABSTRACT.AsString = 'N' then
            dsTablesDECLARE_AS_ABSTRACT.AsString := 'Y'
         else
            dsTablesDECLARE_AS_ABSTRACT.AsString := 'N';
         dsTables.Post;
         dsTables.Next;
      end;

      { Restore previous positons }
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
      Log.Info('Marked all the Tables as Declare As Abstract', [],  LOG_TAG);
   end;
end;

procedure TMain.ActionInvertMarksRegisterEntityExecute(Sender: TObject);
var MarkTable   :TBookmark;
    MarkField   :TBookmark;
begin
   { Save current positions }
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      dsTables.First;
      while not dsTables.EOF do begin
         dsTables.Edit;
         if dsTablesREGISTER_ENTITY.AsString = 'N' then
            dsTablesREGISTER_ENTITY.AsString := 'Y'
         else
            dsTablesREGISTER_ENTITY.AsString := 'N';
         dsTables.Post;
         dsTables.Next;
      end;

      { Restore previous positons }
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
      Log.Info('Marked all the Tables as Declare As Abstract', [],  LOG_TAG);
   end;
end;

procedure TMain.ActionMarkAllDeclareAsAbstractExecute(Sender: TObject);
var MarkTable   :TBookmark;
    MarkField   :TBookmark;
begin
   { Save current positions }
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      dsTables.First;
      while not dsTables.EOF do begin
         dsTables.Edit;
         dsTablesDECLARE_AS_ABSTRACT.AsString := 'Y';
         dsTables.Post;
         dsTables.Next;
      end;

      { Restore previous positons }
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
      Log.Info('Marked all the Tables as Declare As Abstract', [],  LOG_TAG);
   end;
end;

procedure TMain.ActionMarkAllRegisterEntityExecute(Sender: TObject);
var MarkTable   :TBookmark;
    MarkField   :TBookmark;
begin
   { Save current positions }
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      dsTables.First;
      while not dsTables.EOF do begin
         dsTables.Edit;
         dsTablesREGISTER_ENTITY.AsString := 'Y';
         dsTables.Post;
         dsTables.Next;
      end;

      { Restore previous positons }
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
      Log.Info('Marked all the Tables as Declare As Abstract', [],  LOG_TAG);
   end;
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
   if FModified then begin
      case MessageDlg(Format('Current changes in the project will be lost. Continue?', [ProjectName]), mtConfirmation, [mbYes, mbCancel], 0) of
         mrCancel: Exit;
      end;
   end;

   ResetAllData;
   FFileName := ExtractFilePath(ParamStr(0)) + NOT_SAVED_PROJECT_NAME;
   FModified := False;
   Caption   := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [ProjectName, DMVCFRAMEWORK_VERSION]);
   Log.Info('Created a new empty project', LOG_TAG);
end;

procedure TMain.ActionSaveProjectAsExecute(Sender: TObject);
begin
   {Get the desired project name}
   if DialogSaveProject.Execute then begin
      FFileName := DialogSaveProject.FileName;
      Caption   := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [ProjectName, DMVCFRAMEWORK_VERSION]);
      Log.Info('Project '+ProjectName+' ready to be saved.', LOG_TAG);
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
   if ProjectName = NOT_SAVED_PROJECT_NAME then begin
      DialogSaveProject.DefaultFolder := ExtractFilePath(ParamStr(0));
      DialogSaveProject.FileName      := DEFAULT_PROJECT_NAME;
      ActionSaveProjectAs.Execute;
   end
   else begin
      if Controller.SaveProject(FFileName) then begin
         FModified := False;
         ActionRefreshMetadata.Execute;
         Caption := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [ProjectName, DMVCFRAMEWORK_VERSION]);
         Log.Info(Format('Database %s saved on disk', [ProjectName]), LOG_TAG);
         SetLastOpened(FFileName);
         UpdateOpenRecentSubItems;
      end
      else begin
         Log.Info('Project '+ProjectName+' failed to be saved on disk.', LOG_TAG);
         raise Exception.Create('Error saving data');
      end;
   end;
end;

procedure TMain.LoadProject;
begin
   DisableVisualEvents;
   {Before Load a project we need to delete the current}
   ResetAllData;
   try
      if Controller.LoadProject(FFileName) then begin
         SetOnViewDataFromMemory;
         if not DBConnection.Params.IsEmpty then begin
            DBConnection.Open;
         end;
         FModified := False;
         SetLastOpened(FFileName);
         UpdateOpenRecentSubItems;
         Caption := Format('DMVCFramework Entities Generator :: [%0:s] - DMVCFramework-%1:s', [ProjectName, DMVCFRAMEWORK_VERSION]);
      end;
   finally
      EnableVisualEvents;
   end;
end;

procedure TMain.ActionOpenProjectExecute(Sender: TObject);
begin
   {The project has not modifications}
   if (FModified) or (ProjectName <> NOT_SAVED_PROJECT_NAME) or (not DBConnection.Params.IsEmpty) then begin
      case MessageDlg(Format('Current changes in the project will be lost. Continue?', [ProjectName]), mtConfirmation, [mbYes, mbCancel], 0) of
         mrCancel: Exit;
      end;
   end;

   {The project name was never saved}
   if DialogOpenProject.Execute then begin
      FFileName := DialogOpenProject.FileName;
      LoadProject;
   end;
end;

procedure TMain.ActionSaveProjectUpdate(Sender: TObject);
begin
   ActionSaveProject.Enabled := FModified;
end;

procedure TMain.ActionUnmarkAllDeclareAsAbstractExecute(Sender: TObject);
var MarkTable   :TBookmark;
    MarkField   :TBookmark;
begin
   { Save current positions }
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      dsTables.First;
      while not dsTables.EOF do begin
         dsTables.Edit;
         dsTablesDECLARE_AS_ABSTRACT.AsString := 'N';
         dsTables.Post;
         dsTables.Next;
      end;

      { Restore previous positons }
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
      Log.Info('Marked all the Tables as Declare As Abstract', [],  LOG_TAG);
   end;
end;

procedure TMain.ActionUnmarkAllRegisterEntityExecute(Sender: TObject);
var MarkTable   :TBookmark;
    MarkField   :TBookmark;
begin
   { Save current positions }
   MarkTable := dsTables.GetBookmark;
   MarkField := dsFields.GetBookmark;
   dsTables.DisableControls;
   dsFields.DisableControls;
   try
      dsTables.First;
      while not dsTables.EOF do begin
         dsTables.Edit;
         dsTablesREGISTER_ENTITY.AsString := 'N';
         dsTables.Post;
         dsTables.Next;
      end;

      { Restore previous positons }
      dsTables.GotoBookmark(MarkTable);
      dsFields.GotoBookmark(MarkField);
   finally
      dsTables.EnableControls;
      dsFields.EnableControls;
      dsTables.FreeBookmark(MarkTable);
      dsFields.FreeBookmark(MarkField);
      Log.Info('Marked all the Tables as Declare As Abstract', [],  LOG_TAG);
   end;
end;

procedure TMain.GridFieldsDblClick(Sender: TObject);
begin
   ActionEditField.Execute;
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

procedure TMain.ResetAllData;
begin
   dsTables.Open;
   dsFields.Open;

   {First the view data}
   dsFields.EmptyDataSet;
   dsTables.EmptyDataSet;

   {Now In memory DB data}
   Controller.EmptyEntGenDB;

   {Now the User Connection}
   DBConnection.Close;
   DBConnection.DriverName := '';
   DBConnection.Params.Clear;
   DBConnection.LoginPrompt := False;

   {Now visual controls}
   RadioGroupNameCase.ItemIndex            := 0;
   RadioGroupFieldNameFormatting.ItemIndex := 0;

   FModified := False;

   //FFileName := ExtractFilePath(ParamStr(0)) + NOT_SAVED_PROJECT_NAME;
end;

end.
