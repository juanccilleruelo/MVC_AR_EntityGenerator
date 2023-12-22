unit ARGeneratorController;

interface

uses System.Classes, System.Generics.Collections, System.Rtti, System.DateUtils,
     System.SysUtils, System.Types, System.UITypes, System.Variants,
     Data.DB, VCL.ComCtrls,
     FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
     FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
     FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
     FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
     FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.FBDef,
     FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Phys.PGDef, FireDAC.Phys.PG,
     FireDAC.Phys.IBDef, FireDAC.Phys.IB, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
     FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Moni.RemoteClient,
     FireDAC.Moni.Custom, FireDAC.Moni.Base, FireDAC.Moni.FlatFile, FireDAC.Phys.SQLiteWrapper,
     System.JSON, Data.DBXJSONReflect, VCL.ExtCtrls, VCL.StdCtrls,
     LoggerPro.FileAppender,
     LoggerPro.VCLListBoxAppender,
     LoggerPro;

type
  TARGeneratorController = class
  private
    FLog        :ILogWriter;
    FARDB       :TFDConnection; {Link to the Database of the component editor                      }
    FConnection :TFDConnection; {Link to the Database of work. From which we extract ActiverRecords}

    FNameCase            :TRadioGroup;{ This                        }
    FFieldNameFormatting :TRadioGroup;{       are                   }

    function IsReservedKeyword(const Value: String): Boolean;
    function GetProjectGroup: string; //IOTAProjectGroup;
    function GetFolderName(const ATableName : string):string;
    function GetDeployPath(const AFolderName: string):string;

    procedure ClearAllExists;
    procedure SaveVisualData;
    procedure RestoreVisualData;
    procedure SaveDBConnectionInfo;
    procedure RestoreDBConnectionInfo;

    function  Col(Text :string; Spaces :Integer):string;
    procedure InsertComment(IntfCode :TStringStream);
    procedure InitAllCode(IntfCode, ImplCode, InitCode :TStringStream; const UnitName: string);
    procedure InsertClass(IntfCode :TStringStream;
                          InitCode :TStringStream;
                          const ATableName          :string;
                          const AClassName          :string;
                          const ANameCase           :string;
                          const IsAbstract          :Boolean;
                          const WithMappingRegistry :Boolean);
    function GetUniqueIdentifiers(const MetaData           :TFDMetaInfoQuery;   {Generates the Pascal Identifers for each Table column}
                                  const FormatAsPascalCase :Boolean): TArray<string>;
    function GetMaxLengthFieldName(FieldNames :TArray<string>):Integer;
    function GetCurrentColumnAttribute(MetaData :TFDMetaInfoQuery):TFDDataAttributes;
    procedure InsertField(IntfCode :TStringStream;
                          const CW                :Integer; {Column Width}
                          const ColType           :string;
                          const DatabaseFieldName :string;
                          const UniqueFieldName   :string;
                          const FieldDataType     :TFDDataType;
                          const ColumnAttrib      :TFDDataAttributes;
                          const IsPK              :Boolean);
    function GetDelphiType(const FireDACType   :TFDDataType;
                           const ColumnAttrib  :TFDDataAttributes;
                           const ForceNullable :Boolean = False):string;
    function GetFieldName(const Value :string):string;
    procedure InsertProperty(IntfCode :TStringStream;
                             const CW            :Integer; {Column Width}
                             const FieldName     :string;
                             const ColumnAttrib  :TFDDataAttributes;
                             const FieldDataType :TFDDataType;
                             const IsPK          :Boolean);
  protected

  public
    constructor Create;
    destructor  Destroy; override;

    function GetClassName(const ATableName : string):string;
    function GetUnitName(ClassName :string):string;

    procedure GenerateCode(OutputText :TStrings;
                           const TableName           :string;
                           const AClassName          :string;
                           const dsFields            :TFDMemTable;
                           const AsAbstract          :Boolean;
                           const NameCase            :string;
                           const WithMappingRegistry :Boolean;
                           const FormatAsPascalCase  :Boolean);

    function CreateEntGenDB:Boolean;
    function RefreshMetadata(FormatAsPascalCase :Boolean):Boolean;
    procedure FillViewData(Tables, Fields :TFDMemTable);
    procedure EmptyEntGenDB;
    {***}procedure SavePendantData(Tables, Fields :TFDMemTable);
    procedure SaveCurrentViewTableToMemory(Tables :TFDMemTable);
    procedure SaveCurrentViewFieldToMemory(Fields :TFDMemTable);
    function SaveProject(ProjectFile :string):Boolean;
    function LoadProject(ProjectFile :string):Boolean;
  public
    property ARDB        :TFDConnection read FARDB        write FARDB;
    property Connection  :TFDConnection read FConnection  write FConnection;
    property Log         :ILogWriter    read FLog         write Flog;

    property NameCase            :TRadioGroup read FNameCase            write FNameCase           ;
    property FieldNameFormatting :TRadioGroup read FFieldNameFormatting write FFieldNameFormatting;
  end;

implementation

uses System.TypInfo,
     VCL.Dialogs,
     MVCFramework.Commons,
     {--- FireDAC ---}

     {---------------}
     System.IOUtils,
     UtilsU;

const
   LOG_TAG                  = 'Controller';
   CONNECTION_INDEX         = 1;

   META_F_TABLE_NAME        = 'TABLE_NAME';
   META_F_COLUMN_NAME       = 'COLUMN_NAME';
   META_F_COLUMN_DATATYPE   = 'COLUMN_DATATYPE';
   META_F_COLUMN_TYPENAME   = 'COLUMN_TYPENAME';
   META_F_COLUMN_ATTRIBUTES = 'COLUMN_ATTRIBUTES';
   META_F_COLUMN_PRECISION  = 'COLUMN_PRECISION';
   META_F_COLUMN_SCALE      = 'COLUMN_SCALE';
   META_F_COLUMN_LENGTH     = 'COLUMN_LENGTH';

  INDENT = '   ';

{ TARGeneratorController }
constructor TARGeneratorController.Create;
begin
   inherited;
end;

destructor TARGeneratorController.Destroy;
begin
   inherited;
end;

function TARGeneratorController.CreateEntGenDB:Boolean;
begin
   {We use the prefix 'AR' in the table names and the suffix 'NAME' in
    some field names because of the high risk that the words Connection,
    Table, Field and others can't be used as identifiers in a DB definition}

   {Creates an Empty File for next times}
   ARDB.Connected := True;
   ARDB.ExecSQL('CREATE TABLE AR_CONNECTION (              ' +
                '  INDEX_ID                  INTEGER PRIMARY KEY, ' + {The table needs a PK }
                '  DRIVER_NAME               TEXT               , ' + {DriverName           }
                '  PARAMS                    TEXT               , ' + {Params               }
                '  GLB_NAME_CASE             INTEGER            , ' + {Visual               }
                '  GLB_FIELD_NAME_FORMATTING INTEGER              ' + {       properties    }
                ');                                        ');

   ARDB.ExecSQL('CREATE TABLE AR_TABLES (                 ' +
                '  TABLE_NAME          TEXT   PRIMARY KEY, ' +
                '  EXISTENCE           TEXT              , ' + {C = Continue; D = Deleted; N = New;}
                '  CLASS_NAME          TEXT              , ' + {Normally is a 'T' plus the singular versión of the TableName }
                '  DEPLOY_PATH         TEXT              , ' + {The path where the file is deployed }
                '  DECLARE_AS_ABSTRACT TEXT              , ' +
                '  REGISTER_ENTITY     TEXT              , ' +
                '  WITH_DETAIL         TEXT              , ' + {Indicates if this table has a detail related table}
                '  DETAIL_CLASS_NAME   TEXT              , ' + {The detail TABLE_CLASS_NAME ????? is not the Details_Table_name? }
                '  DETAIL_PROP_NAME    TEXT              , ' +
                '  DETAIL_UNIT_NAME    TEXT                ' +

                ');                                       ');

   ARDB.ExecSQL('CREATE TABLE AR_FIELDS (                                          ' +
                '  TABLE_NAME         TEXT                                       , ' +
                '  FIELD_NAME         TEXT                                       , ' +
                '  EXISTENCE          TEXT                                       , ' + {C = Continue; D = Deleted; N = New;}
                '  CUSTOM_NAME        TEXT                                       , ' +
                '  CONSTRAINT PK_AR_FIELDS PRIMARY KEY (TABLE_NAME, FIELD_NAME)    ' +
                ');                                           ');
end;

procedure TARGeneratorController.EmptyEntGenDB;
begin
   {Instead of Delete all the objects in database we'll delete all datas}
   {I think is more efficient and less problematic }

   ARDB.ExecSQL('DELETE FROM AR_FIELDS;     ');
   ARDB.ExecSQL('DELETE FROM AR_TABLES;     ');
   ARDB.ExecSQL('DELETE FROM AR_CONNECTION; ');
end;

procedure TARGeneratorController.SaveDBConnectionInfo;
var Q :TFDQuery;
begin
   Q := TFDQuery.Create(nil);
   Q.Connection := ARDB;
   Q.SQL.Add(Format('SELECT INDEX_ID FROM AR_CONNECTION WHERE INDEX_ID = %d', [CONNECTION_INDEX]));
   Q.Open;
   try
      { Still does not exists this row }
      if Q.IsEmpty then begin
         ARDB.ExecSQL(Format('INSERT INTO AR_CONNECTION (INDEX_ID       ,   '+
                             '                           DRIVER_NAME    ,   '+
                             '                           PARAMS         )   '+
                             'VALUES (%d, ''%s'', ''%s''                );  ',
                             [CONNECTION_INDEX      ,
                              Connection.DriverName ,
                              Connection.Params.Text]));
      end
      else begin
         ARDB.ExecSQL(Format('UPDATE AR_CONNECTION SET DRIVER_NAME     = ''%s'' ,  '+
                             '                         PARAMS          = ''%s''    '+
                             'WHERE INDEX_ID = %d;                                 ',
                             [Connection.DriverName,
                              Connection.Params.Text,
                              CONNECTION_INDEX]));
      end;
   finally
      {Seems to be a problem with this instruction.
       If I uncomment it the Connection will be not accessible.
       Is like if Q.Free liberates too Connection.
       I tried to communicate this bug to Embarcadero but the quality.embarcadero.com is not working
      }
      //Q.Free;
   end;
end;

procedure TARGeneratorController.RestoreDBConnectionInfo;
var Q  :TFDQuery;
    QS :TFDQuery;
begin

   Q := TFDQuery.Create(nil);
   Q.Connection := ARDB;
   Q.SQL.Add(Format('SELECT INDEX_ID FROM AR_CONNECTION WHERE INDEX_ID = %d', [CONNECTION_INDEX]));
   Q.Open;
   try
      { Still does not exists this row }
      if Q.IsEmpty then begin

      end
      else begin
         QS := TFDQuery.Create(nil);
         QS.Connection := ARDB;
         QS.SQL.Add(Format('SELECT DRIVER_NAME                    , ' +
                           '       PARAMS                           ' +
                           'FROM AR_CONNECTION WHERE INDEX_ID = %d  ', [CONNECTION_INDEX]));
         try
            QS.Open;
            Connection.DriverName  := QS.FieldByName('DRIVER_NAME').AsString;
            Connection.Params.Text := QS.FieldByName('PARAMS'     ).AsString;
         finally
            QS.Free;
         end;
      end;
   finally
      {Seems to be a problem with this instruction.
       If I uncomment it the Connection will be not accessible.
       Is like if Q.Free liberates too Connection.
       I tried to communicate this bug to Embarcadero but the quality.embarcadero.com is not working
      }
      //Q.Free;
   end;
end;

function TARGeneratorController.SaveProject(ProjectFile :string):Boolean;
var BackupDB :TFDSQLiteBackup;
    DLink    :TFDPhysSQLiteDriverLink;
begin
   SaveVisualData;
   SaveDBConnectionInfo;

   {We are sure that the target database does not exists or we want overwrite it}
   DLink    := TFDPhysSQLiteDriverLink.Create(nil);
   BackupDB := TFDSQLiteBackup.Create(nil);
   Result   := False;
   try
      BackupDB.DriverLink   := DLink;
      BackupDB.DatabaseObj  := ARDB.CliObj;
      BackupDB.DestMode     := TSQLiteDatabaseMode.smCreate;
      BackupDB.DestDatabase := ProjectFile;
      BackupDB.Backup;
      Result := True;
   finally
      BackupDB.Free;
   end;
end;

function TARGeneratorController.LoadProject(ProjectFile :string):Boolean;
var RestoreDB :TFDSQLiteBackup;
    DLink     :TFDPhysSQLiteDriverLink;
begin
   {We are sure that the target database does not exists or we want overwrite it}
   DLink     := TFDPhysSQLiteDriverLink.Create(nil);
   RestoreDB := TFDSQLiteBackup.Create(nil);
   Result    := False;
   try
      RestoreDB.DriverLink      := DLink;
      RestoreDB.DestDatabaseObj := ARDB.CliObj;
      RestoreDB.DestMode        := TSQLiteDatabaseMode.smCreate;
      RestoreDB.Database        := ProjectFile;
      RestoreDB.Backup;
      Result := True;
   finally
      RestoreDB.Free;
   end;

   RestoreVisualData;
   RestoreDBConnectionInfo;
end;

procedure TARGeneratorController.ClearAllExists;
begin
   ARDB.ExecSQL('UPDATE AR_TABLES SET EXISTENCE = ''D''');
   ARDB.ExecSQL('UPDATE AR_FIELDS SET EXISTENCE = ''D''');
end;

function TARGeneratorController.RefreshMetadata(FormatAsPascalCase :Boolean):Boolean;
var Qt          :TFDQuery;
    Qf          :TFDQuery;
    Tables      :TStringList;
    Table       :string;
    ClassName   :string;
    MetaData    :TFDMetaInfoQuery;
    FolderName  :string;
    DeployPath  :string;
    FieldName   :string;
    Identifiers :TArray<string>;
    MaxLength   :Integer;
    i           :Integer;
begin
   ClearAllExists; {Mark all tables and fields as not existing}

   Qt := TFDQuery.Create(nil);
   Qt.Connection := ARDB;
   Qt.SQL.Add('SELECT TABLE_NAME FROM AR_TABLES WHERE TABLE_NAME = :prmTableName');

   Qf := TFDQuery.Create(nil);
   Qf.Connection := ARDB;
   Qf.SQL.Add('SELECT FIELD_NAME FROM AR_FIELDS WHERE TABLE_NAME = :prmTableName AND FIELD_NAME = :prmFieldName');

   Tables := TStringList.Create;
   try
      {Recover all the tables of the database}
      Connection.GetTableNames('', '', '', Tables);
      for Table in Tables do begin
          {Insert each table data into the table of ARDB}
          FolderName := GetFolderName(Table);
          ClassName  := GetClassName(FolderName);
          DeployPath := GetDeployPath(FolderName);
          Qt.ParamByName('prmTableName').AsString := Table;
          Qt.Open;
          try
             { Still does not exists this row }
             if Qt.IsEmpty then begin
                ARDB.ExecSQL(Format('INSERT INTO AR_TABLES (TABLE_NAME         , ' +
                                    '                       CLASS_NAME         , ' +
                                    '                       DEPLOY_PATH        , ' +
                                    '                       DECLARE_AS_ABSTRACT, ' +
                                    '                       REGISTER_ENTITY    , ' +
                                    '                       EXISTENCE          ) ' +
                                    'VALUES (''%s'', ''%s'', ''%s'', ''N'', ''N'', ''N'');', [Table, ClassName, DeployPath]));
             end
             else begin
                ARDB.ExecSQL(Format('UPDATE AR_TABLES SET EXISTENCE = ''C''  '+
                                    'WHERE TABLE_NAME = ''%s'';              ', [Table]));
             end;

          finally
             Qt.Close;
          end;

          {Recover all fields of the current table}
          MetaData := TFDMetaInfoQuery.Create(nil);
          MetaData.Connection   := Connection;
          MetaData.ObjectScopes := [osMy]; {Objects created by the current login user.} {osSystem Objects belonging to the DBMS. osOther All other objects.}
          MetaData.MetaInfoKind := mkTableFields;
          MetaData.ObjectName   := Table;
          try
             MetaData.Open;

             Identifiers := GetUniqueIdentifiers(MetaData, FormatAsPascalCase);
             MaxLength := GetMaxLengthFieldName(Identifiers);

             i := 0;
             MetaData.First;
             while not MetaData.EOF do begin
                FieldName := MetaData.FieldByName(META_F_COLUMN_NAME).AsString;
                //ShowMessage('TABLE_NAME        = ' + MetaData.FieldByName(META_F_TABLE_NAME       ).AsString);
                //ShowMessage('COLUMN_NAME       = ' + MetaData.FieldByName(META_F_COLUMN_NAME      ).AsString);
                //ShowMessage('COLUMN_DATATYPE   = ' + MetaData.FieldByName(META_F_COLUMN_DATATYPE  ).AsString);
                //ShowMessage('COLUMN_ATTRIBUTES = ' + MetaData.FieldByName(META_F_COLUMN_ATTRIBUTES).AsString);
                //ShowMessage('COLUMN_PRECISION  = ' + MetaData.FieldByName(META_F_COLUMN_PRECISION ).AsString);
                //ShowMessage('COLUMN_SCALE      = ' + MetaData.FieldByName(META_F_COLUMN_SCALE     ).AsString);
                //ShowMessage('COLUMN_LENGTH     = ' + MetaData.FieldByName(META_F_COLUMN_LENGTH    ).AsString);
                {Insert each field data into the table of ARDB}
                Qf.ParamByName('prmTableName').AsString := Table;
                Qf.ParamByName('prmFieldName').AsString := FieldName;
                Qf.Open;
                try
                   if Qf.IsEmpty then begin
                      ARDB.ExecSQL(Format('INSERT INTO AR_FIELDS (TABLE_NAME,  '+
                                          '                       FIELD_NAME,  '+
                                          '                       CUSTOM_NAME, '+
                                          //'                       JSON_NAME  , '+
                                          '                       EXISTENCE )  '+
                                          'VALUES (''%s'', ''%s'', ''%s'', ''N'');', [Table, FieldName, Identifiers[i]]));
                   end
                   else begin
                      ARDB.ExecSQL(Format('UPDATE AR_FIELDS SET EXISTENCE = ''C''  '+
                                          'WHERE TABLE_NAME = ''%s''               '+
                                          'AND   FIELD_NAME = ''%s'';              ', [Table, FieldName]));
                   end;
                finally
                   Qf.Close;
                end;

                Inc(i);
                MetaData.Next;
             end;
          finally
             MetaData.Free;
          end;
      end;
   finally
      Tables.Free;
      Qt.Free;
   end;
end;

procedure TARGeneratorController.FillViewData(Tables, Fields :TFDMemTable);
var Qt :TFDQuery;
    Qf :TFDQuery;
begin
   Qt := TFDQuery.Create(nil);
   Qt.Connection := ARDB;
   Qt.SQL.Add('SELECT TABLE_NAME         , ' +
              '       CLASS_NAME         , ' +
              '       DEPLOY_PATH        , ' +
              '       DECLARE_AS_ABSTRACT, ' +
              '       REGISTER_ENTITY      ' +
              'FROM AR_TABLES            ; ');

   Qf := TFDQuery.Create(nil);
   Qf.Connection := ARDB;
   Qf.SQL.Add('SELECT TABLE_NAME,                 '+
              '       FIELD_NAME,                 '+
              '       CUSTOM_NAME                 '+
              'FROM AR_FIELDS                     '+
              'WHERE TABLE_NAME = :prmTABLE_NAME; ' );
   try
      Qt.Open;
      while not Qt.EOF do begin
         Tables.Insert;
         Tables.FieldByName('TABLE_NAME'         ).AsString := Qt.FieldByName('TABLE_NAME'         ).AsString;
         Tables.FieldByName('CLASS_NAME'         ).AsString := Qt.FieldByName('CLASS_NAME'         ).AsString;
         Tables.FieldByName('DEPLOY_PATH'        ).AsString := Qt.FieldByName('DEPLOY_PATH'        ).AsString;
         Tables.FieldByName('DECLARE_AS_ABSTRACT').AsString := Qt.FieldByName('DECLARE_AS_ABSTRACT').AsString;
         Tables.FieldByname('REGISTER_ENTITY'    ).AsString := Qt.FieldByName('REGISTER_ENTITY'    ).AsString;
         Tables.Post;

         Qf.ParamByName('prmTABLE_NAME').AsString := Qt.FieldByName('TABLE_NAME').AsString;
         Qf.Open;
         try
            while not Qf.EOF do begin
               Fields.Insert;
               Fields.FieldByName('TABLE_NAME' ).AsString := Qf.FieldByName('TABLE_NAME' ).AsString;
               Fields.FieldByName('FIELD_NAME' ).AsString := Qf.FieldByName('FIELD_NAME' ).AsString;
               Fields.FieldByName('CUSTOM_NAME').AsString := Qf.FieldByName('CUSTOM_NAME').AsString;
               Fields.Post;
               Qf.Next;
            end;
         finally
            Qf.Close;
         end;
         Qt.Next;
      end;
      Tables.First;
   finally
      Qf.Free;
      Qt.Free;
   end;
end;

procedure TARGeneratorController.SaveVisualData;
var Q :TFDQuery;
begin
   Q := TFDQuery.Create(nil);
   Q.Connection := ARDB;
   Q.SQL.Add(Format('SELECT INDEX_ID FROM AR_CONNECTION WHERE INDEX_ID = %d', [CONNECTION_INDEX]));
   Q.Open;
   try
      { Still does not exists this row }
      if Q.IsEmpty then begin
         ARDB.ExecSQL(Format('INSERT INTO AR_CONNECTION (INDEX_ID                  , ' +
                             '                           GLB_NAME_CASE             , ' +
                             '                           GLB_FIELD_NAME_FORMATTING ) ' +
                             'VALUES (%d, %d, %d                                   );  ',
                             [CONNECTION_INDEX              ,
                              FNameCase.ItemIndex           ,
                              FFieldNameFormatting.ItemIndex]));
      end
      else begin
         ARDB.ExecSQL(Format('UPDATE AR_CONNECTION SET GLB_NAME_CASE             = %d ,  '+
                             '                         GLB_FIELD_NAME_FORMATTING = %d    '+
                             'WHERE INDEX_ID = %d;                                       ',
                             [FNameCase.ItemIndex           ,
                              FFieldNameFormatting.ItemIndex,
                              CONNECTION_INDEX    ]));
      end;
   finally
      {Seems to be a problem with this instruction.
       If I uncomment it the Connection will be not accessible.
       Is like if Q.Free liberates too Connection.
       I tried to communicate this bug to Embarcadero but the quality.embarcadero.com is not working
      }
      //Q.Free;
   end;
end;

procedure TARGeneratorController.RestoreVisualData;
var Q  :TFDQuery;
    QS :TFDQuery;
begin
   Q := TFDQuery.Create(nil);
   Q.Connection := ARDB;
   Q.SQL.Add(Format('SELECT INDEX_ID FROM AR_CONNECTION WHERE INDEX_ID = %d', [CONNECTION_INDEX]));
   Q.Open;
   try
      { Still does not exists this row }
      if Q.IsEmpty then begin
         NameCase.ItemIndex            := 0;
         FieldNameFormatting.ItemIndex := 0;
      end
      else begin
         QS := TFDQuery.Create(nil);
         QS.Connection := ARDB;
         QS.SQL.Add(Format('SELECT GLB_NAME_CASE            ,      ' +
                           '       GLB_FIELD_NAME_FORMATTING       ' +
                           'FROM AR_CONNECTION WHERE INDEX_ID = %d', [CONNECTION_INDEX]));
         try
            QS.Open;
            NameCase.ItemIndex            := QS.FieldByName('GLB_NAME_CASE'            ).AsInteger;
            FieldNameFormatting.ItemIndex := QS.FieldByName('GLB_FIELD_NAME_FORMATTING').AsInteger;
         finally
            QS.Free;
         end;
      end;
   finally
      {Seems to be a problem with this instruction.
       If I uncomment it the Connection will be not accessible.
       Is like if Q.Free liberates too Connection.
       I tried to communicate this bug to Embarcadero but the quality.embarcadero.com is not working
      }
      //Q.Free;
   end;
end;

procedure TARGeneratorController.SavePendantData(Tables, Fields :TFDMemTable);
var Qt :TFDQuery;
    Qf :TFDQuery;
begin
   Exit;

   {Thist method is not going to be necessary.
    But I can reuse it to clean modifications on DB before save project next time}

   Qt := TFDQuery.Create(nil);
   Qt.Connection := ARDB;
   Qt.SQL.Add('SELECT TABLE_NAME FROM AR_TABLES WHERE TABLE_NAME = :prmTableName');

   Qf := TFDQuery.Create(nil);
   Qf.Connection := ARDB;
   Qf.SQL.Add('SELECT FIELD_NAME FROM AR_FIELDS WHERE TABLE_NAME = :prmTableName AND FIELD_NAME = :prmFieldName');

   Tables.First;
   try
      {Traverse all the tables in Tables DataSet}
      while not Tables.EOF do begin
         {Insert each table data into the table of ARDB}
         Qt.ParamByName('prmTableName').AsString := Tables.FieldByName('TABLE_NAME').AsString;
         Qt.Open;
         try
            { Still does not exists this row }
            if Qt.IsEmpty then begin
               ARDB.ExecSQL(Format('INSERT INTO AR_TABLES (TABLE_NAME         , ' +
                                   '                       CLASS_NAME         , ' +
                                   '                       DEPLOY_PATH        , ' +
                                   '                       DECLARE_AS_ABSTRACT, ' +
                                    '                      REGISTER_ENTITY    , ' +
                                   '                       EXISTENCE          ) '+
                                   'VALUES (''%s'', ''%s'', ''%s'', ''C'');', [Tables.FieldByName('TABLE_NAME'         ).AsString,
                                                                               Tables.FieldByName('CLASS_NAME'         ).AsString,
                                                                               Tables.FieldByName('DEPLOY_PATH'        ).AsString,
                                                                               Tables.FieldByName('DECLARE_AS_ABSTRACT').AsString,
                                                                               Tables.FieldByName('REGISTER_ENTITY'    ).AsString]));
            end
            else begin
               ARDB.ExecSQL(Format('UPDATE AR_TABLES SET EXISTENCE           = ''C''  ,  ' +
                                   '                     CLASS_NAME          = ''%s'' ,  ' +
                                   '                     DEPLOY_PATH         = ''%s'' ,  ' +
                                   '                     DECLARE_AS_ABSTRACT = ''%s'' ,  ' +
                                   '                     REGISTER_ENTITY     = ''%s''    ' +
                                   'WHERE TABLE_NAME = ''%s'';               ', [Tables.FieldByName('CLASS_NAME'         ).AsString,
                                                                                 Tables.FieldByName('DEPLOY_PATH'        ).AsString,
                                                                                 Tables.FieldByName('DECLARE_AS_ABSTRACT').AsString,
                                                                                 Tables.FieldByName('REGISTER_ENTITY'    ).AsString,
                                                                                 Tables.FieldByName('TABLE_NAME'         ).AsString]));
            end;

         finally
            Qt.Close;
         end;

         {Traverse all the fields of the current table}
         Fields.First;
         while not Fields.EOF do begin
            {Insert each field data into the table of ARDB}
            Qf.ParamByName('prmTableName').AsString := Fields.FieldByName('TABLE_NAME').AsString;
            Qf.ParamByName('prmFieldName').AsString := Fields.FieldByName('FIELD_NAME').AsString;
            Qf.Open;
            try
               if Qf.IsEmpty then begin
                  ARDB.ExecSQL(Format('INSERT INTO AR_FIELDS (TABLE_NAME,  '+
                                      '                       FIELD_NAME,  '+
                                      '                       CUSTOM_NAME, '+
                                      '                       EXISTENCE )  '+
                                      'VALUES (''%s'', ''%s'', ''%s'', ''C'');', [Fields.FieldByName('TABLE_NAME' ).AsString,
                                                                                  Fields.FieldByName('FIELD_NAME' ).AsString,
                                                                                  Fields.FieldByName('CUSTOM_NAME').AsString]));
               end
               else begin
                  ARDB.ExecSQL(Format('UPDATE AR_FIELDS SET EXISTENCE   = ''C'' ,  '+
                                      '                     CUSTOM_NAME = ''%s''   '+
                                      'WHERE TABLE_NAME = ''%s''                   '+
                                      'AND   FIELD_NAME = ''%s'';                  ', [Fields.FieldByName('CUSTOM_NAME').AsString,
                                                                                       Fields.FieldByName('TABLE_NAME' ).AsString,
                                                                                       Fields.FieldByName('FIELD_NAME' ).AsString]));
               end;
            finally
               Qf.Close;
            end;

            Fields.Next;
         end;
         Tables.Next;
      end;
   finally
      Qt.Free;
   end;
end;

procedure TARGeneratorController.SaveCurrentViewTableToMemory(Tables :TFDMemTable);
var Q :TFDQuery;
begin
   Q := TFDQuery.Create(nil);
   Q.Connection := ARDB;
   Q.SQL.Add('SELECT TABLE_NAME FROM AR_TABLES WHERE TABLE_NAME = :prmTableName');

   {Insert each table data into the table of ARDB}
   Q.ParamByName('prmTableName').AsString := Tables.FieldByName('TABLE_NAME').AsString;
   Q.Open;
   try
      { Still does not exists this row }
      if Q.IsEmpty then begin
         {Currently we don´t allow to add tables to the Tables}
         raise Exception.Create(Format('There is a problem. The Table %s does''t exists on memory DB',
                                [Tables.FieldByName('TABLE_NAME').AsString]));
      end
      else begin
         ARDB.ExecSQL(Format('UPDATE AR_TABLES SET CLASS_NAME          = ''%s'' ,  ' +
                             '                     DEPLOY_PATH         = ''%s'' ,  ' +
                             '                     DECLARE_AS_ABSTRACT = ''%s'' ,  ' +
                             '                     REGISTER_ENTITY     = ''%s''    ' +
                             'WHERE TABLE_NAME = ''%s'';               ', [Tables.FieldByName('CLASS_NAME'         ).AsString,
                                                                           Tables.FieldByName('DEPLOY_PATH'        ).AsString,
                                                                           Tables.FieldByName('DECLARE_AS_ABSTRACT').AsString,
                                                                           Tables.FieldByName('REGISTER_ENTITY'    ).AsString,
                                                                           Tables.FieldByName('TABLE_NAME'         ).AsString]));
      end;

   finally
      Q.Close;
   end;
end;

procedure TARGeneratorController.SaveCurrentViewFieldToMemory(Fields :TFDMemTable);
var Q :TFDQuery;
begin
   Q := TFDQuery.Create(nil);
   Q.Connection := ARDB;
   Q.SQL.Add('SELECT FIELD_NAME FROM AR_FIELDS WHERE TABLE_NAME = :prmTableName AND FIELD_NAME = :prmFieldName');

   {Insert each field data into the table of ARDB}
   Q.ParamByName('prmTableName').AsString := Fields.FieldByName('TABLE_NAME').AsString;
   Q.ParamByName('prmFieldName').AsString := Fields.FieldByName('FIELD_NAME').AsString;
   Q.Open;
   try
      if Q.IsEmpty then begin
         {Currently we don´t allow to add fields to the Fields}
         raise Exception.Create(Format('There is a problem. The Field %s %s does''t exists on memory DB',
                                [Fields.FieldByName('TABLE_NAME').AsString,
                                 Fields.FieldByName('FIELD_NAME').AsString]));
      end
      else begin
         ARDB.ExecSQL(Format('UPDATE AR_FIELDS SET CUSTOM_NAME = ''%s''   '+
                             'WHERE TABLE_NAME = ''%s''                   '+
                             'AND   FIELD_NAME = ''%s'';                  ', [Fields.FieldByName('CUSTOM_NAME').AsString,
                                                                              Fields.FieldByName('TABLE_NAME' ).AsString,
                                                                              Fields.FieldByName('FIELD_NAME' ).AsString]));
      end;
   finally
      Q.Free;
   end;
end;

procedure TARGeneratorController.GenerateCode(OutputText :TStrings;
                                              const TableName           :string;
                                              const AClassName          :string;
                                              const dsFields            :TFDMemTable;
                                              const AsAbstract          :Boolean;
                                              const NameCase            :string;
                                              const WithMappingRegistry :Boolean;
                                              const FormatAsPascalCase  :Boolean);
var i                      :Integer;
    ClassName              :string;
    F                      :Integer;
    FieldNamesToInitialize :TArray<string>;
    MaxLength              :Integer;  //Number of Characters the Field Name more long.

    KeyFields              :TStringList;
    Identifiers            :TArray<string>;
    FieldDataType          :TFDDataType;
    FieldName              :string;
    ColAttrib              :TFDDataAttributes;
    OutputFileName         :string;
    UnitName               :string;
    ColType                :string;
    IsPK                   :Boolean;

    InterfaceCode          :TStringStream;
    PropertiesCode         :TStringStream;
    ImplementationCode     :TStringStream;
    InitializationCode     :TStringStream;
    TypesName              :TArray<string>;
    MetaData               :TFDMetaInfoQuery;
begin
   Log.Info('Starting entity generation', LOG_TAG);

   InterfaceCode      := TStringStream.Create;
   PropertiesCode     := TStringStream.Create;
   ImplementationCode := TStringStream.Create;
   InitializationCode := TStringStream.Create;
   KeyFields          := TStringList.Create;

   MetaData := TFDMetaInfoQuery.Create(nil);
   MetaData.Connection   := Connection;
   MetaData.MetaInfoKind := mkTableFields;
   MetaData.ObjectName   := TableName;
   MetaData.Open;
   try
      {Assigns the name of the class}
      ClassName := AClassName;
      Log.Info('Generating entity [%s] for table [%s]', [ClassName, TableName], LOG_TAG);
      if AsAbstract then begin
         ClassName := ClassName.Chars[0] + 'Custom' + ClassName.Substring(1);
      end;

      UnitName := GetUnitName(ClassName);

      {Insert in each section of the source code the init lines}
      InitAllCode(InterfaceCode, ImplementationCode, InitializationCode, UnitName);

      InsertClass(InterfaceCode, InitializationCode,
                  TableName, ClassName, NameCase,
                  AsAbstract,
                  WithMappingRegistry);

      {Retrieve a list of primary key fields in a table}
      Connection.GetKeyFieldNames('', '', TableName, '', KeyFields);

      FieldNamesToInitialize := [];
      TypesName              := [];

      InterfaceCode.WriteString('  private' + sLineBreak);

{---- Use of the MetaData ----}

      Identifiers := GetUniqueIdentifiers(MetaData, FormatAsPascalCase);
      MaxLength   := GetMaxLengthFieldName(Identifiers);

      {for each field in the table insert Insert private field definition in the class}
      i := 0;
      MetaData.First;
      while not MetaData.EOF do begin
         FieldDataType := TFDDataType(MetaData.FieldByName(META_F_COLUMN_DATATYPE).AsInteger);
         ColAttrib     := GetCurrentColumnAttribute(MetaData);
         FieldName     := MetaData.FieldByName(META_F_COLUMN_NAME).AsString;
         ColType       := MetaData.FieldByName(META_F_COLUMN_TYPENAME).AsString.ToLower;
         IsPk          := KeyFields.IndexOf(MetaData.FieldByName(META_F_COLUMN_NAME).AsString) > -1;

         {$Message Warn 'Indentifers[i] must be CUSTOM_NAME from dsTFields Table'}
         InsertField(InterfaceCode , {Returned value}     //IntfCode :TStringStream;
                     MaxLength     ,                      //const CW                :Integer; {Column Width}

                     ColType       ,                      //const ColType           :string;
                     FieldName     ,                      //const DatabaseFieldName :string;

                     Identifiers[i],                      //const UniqueFieldName   :string;
                     FieldDataType ,                      //const FieldDataType     :TFDDataType;
                     ColAttrib     ,                      //const ColumnAttrib      :TFDDataAttributes;
                     IsPK          );                     //const IsPK              :Boolean);

         InsertProperty(PropertiesCode, {Returned value}  //IntfCode :TStringStream;
                        MaxLength     ,                   //const CW            :Integer; {Column Width}

                        Identifiers[i],                   //const FieldName     :string;
                        ColAttrib     ,                   //const ColumnAttrib  :TFDDataAttributes;
                        FieldDataType ,                   //const FieldDataType :TFDDataType;
                        IsPK          );                  //const IsPK          :Boolean);

         if GetDelphiType(FieldDataType, ColAttrib) = 'TStream' then begin
            FieldNamesToInitialize := FieldNamesToInitialize + [GetFieldName(Identifiers[i])];
            TypesName              := TypesName + ['TMemoryStream'];
         end;

         Inc(i);

         MetaData.Next;
      end;

{---- End of use of the MetaData ----}


      {Insert the 'end;' at the end of the class definition, After all the properties}
      PropertiesCode.WriteString('  end;' + sLineBreak + sLineBreak);

      InterfaceCode.WriteString('  public' + sLineBreak);
      InterfaceCode.WriteString('    constructor Create; override;' + sLineBreak);
      InterfaceCode.WriteString('    destructor  Destroy; override;' + sLineBreak);

      {Inserts Constructor in implementation}
      ImplementationCode.WriteString('constructor ' + ClassName + '.Create;' + sLineBreak);
      ImplementationCode.WriteString('begin' + sLineBreak);
      ImplementationCode.WriteString('   inherited Create;' + sLineBreak);

      for F := low(FieldNamesToInitialize) to high(FieldNamesToInitialize) do begin
         ImplementationCode.WriteString('  ' + FieldNamesToInitialize[F] + ' := ' + TypesName[F] + '.Create;' + sLineBreak);
      end;
      ImplementationCode.WriteString('end;' + sLineBreak + sLineBreak);

      {Inserts Destructor in implementation}
      ImplementationCode.WriteString('destructor ' + ClassName + '.Destroy;' + sLineBreak);
      ImplementationCode.WriteString('begin' + sLineBreak);

      for F := low(FieldNamesToInitialize) to high(FieldNamesToInitialize) do begin
         ImplementationCode.WriteString('  ' + FieldNamesToInitialize[F] + '.Free;' + sLineBreak);
      end;
      ImplementationCode.WriteString('   inherited;' + sLineBreak);
      ImplementationCode.WriteString('end;' + sLineBreak + sLineBreak);

      {Insert the 'end.' at the end of the file}
      InitializationCode.WriteString(sLineBreak + 'end.');

      OutputText.Text := InterfaceCode.DataString      +
                         PropertiesCode.DataString     +
                         ImplementationCode.DataString +
                         InitializationCode.DataString;

      //TFile.WriteAllText(OutputFileName, FInterfaceCode.DataString +
      //                                   FImplementationCode.DataString +
      //                                   FInitializationCode.DataString);
   finally
      KeyFields.Free;
      FreeAndNil(InterfaceCode);
      FreeAndNil(PropertiesCode);
      FreeAndNil(ImplementationCode);
      FreeAndNil(InitializationCode);
      MetaData.Free;
   end;
   Log.Info('Generated %s entity', [ClassName],  LOG_TAG);
end;

function TARGeneratorController.GetProjectGroup:string;// IOTAProjectGroup;
//var IModuleServices :IOTAModuleServices;
//    IModule         :IOTAModule;
//    i               :Integer;
begin
   Result := 'Pendant of be developed, read more';
{When converting the project to a component editor we need to reactivate this}

(*   Assert(Assigned(BorlandIDEServices));
   IModuleServices := BorlandIDEServices as IOTAModuleServices;
   Assert(Assigned(IModuleServices));
   Result := nil;
   for i := 0 to IModuleServices.ModuleCount - 1 do begin
      IModule := IModuleServices.Modules[i];
      if IModule.QueryInterface(IOTAProjectGroup, Result) = S_OK then begin
         Break;
      end;
   end;*)
end;

function TARGeneratorController.GetFolderName(const ATableName : string):string;
var TableName      :string;
    NextLetter     :Integer;
    NextLetterChar :string;
begin
   TableName := ATableName.ToLower.DeQuotedString('"').Replace(' ', '_', [rfReplaceAll]);
   TableName := TableName.ToLower.DeQuotedString('"').Replace('.', '__', [rfReplaceAll]);
   Result := TableName.Substring(0, 1).ToUpper + TableName.Substring(1).ToLower;

   while Result.IndexOf('_') > -1 do begin
      NextLetter := Result.IndexOf('_') + 1;
      NextLetterChar := UpperCase(Result.Chars[NextLetter]);
      Result := Result.Remove(Result.IndexOf('_') + 1, 1);
      Result := Result.Insert(Result.IndexOf('_') + 1, NextLetterChar);
      Result := Result.Remove(Result.IndexOf('_'), 1);
   end;
end;

function TARGeneratorController.GetClassName(const ATableName: string):string;
begin
   Result := 'T' + GetFolderName(ATableName);
end;

function TARGeneratorController.GetDeployPath(const AFolderName: string):string;
var CurrentFolder :string;
begin
   CurrentFolder := ExtractFilePath(ParamStr(0));
   if DirectoryExists(CurrentFolder + PathDelim + AFolderName) then
      Result := CurrentFolder + AFolderName
   else
      Result := CurrentFolder;
end;

function TARGeneratorController.GetUnitName(ClassName :string):string;
begin
   {Is the name of the class without the normalized T and with the 'AR' added. For ActiveRecord}
   Result := ClassName.Substring(1, Length(ClassName)) + 'AR';
end;

{Insert in each section of the source code the init lines}
procedure TARGeneratorController.InitAllCode(IntfCode, ImplCode, InitCode :TStringStream; const UnitName: string);
begin
   InsertComment(IntfCode);

   IntfCode.WriteString('unit ' + UnitName + ';'                + sLineBreak);
   IntfCode.WriteString(''                                      + sLineBreak);
   IntfCode.WriteString('interface'                             + sLineBreak);
   IntfCode.WriteString(''                                      + sLineBreak);
   IntfCode.WriteString('uses MVCFramework.Serializer.Commons,' + sLineBreak);
   IntfCode.WriteString('     MVCFramework.Nullables,         ' + sLineBreak);
   IntfCode.WriteString('     MVCFramework.ActiveRecord,      ' + sLineBreak);
   IntfCode.WriteString('     System.Classes;                 ' + sLineBreak);
   IntfCode.WriteString(''                                      + sLineBreak);
   IntfCode.WriteString('type'                                  + sLineBreak);

   ImplCode.WriteString('implementation' + sLineBreak + sLineBreak);

   InitCode.WriteString('initialization' + sLineBreak + sLineBreak);
end;

procedure TARGeneratorController.InsertClass(IntfCode :TStringStream;
                                             InitCode :TStringStream;
                                             const ATableName          :string;
                                             const AClassName          :string;
                                             const ANameCase           :string;
                                             const IsAbstract          :Boolean;
                                             const WithMappingRegistry :Boolean);
var TextAbstract :string;
begin
   if trim(AClassName) = '' then raise Exception.Create('Invalid class name');

   IntfCode.WriteString('  [MVCNameCase(nc' + ANameCase + ')]' + sLineBreak);
   IntfCode.WriteString('  '+Format('[MVCTable(''%s'')]', [ATableName]) + sLineBreak);

   TextAbstract := '';
   if IsAbstract then TextAbstract := ' abstract';

   IntfCode.WriteString('  ' + AClassName + ' = class' + TextAbstract + '(TMVCActiveRecord)' + sLineBreak);


   if WithMappingRegistry then begin
      InitCode.WriteString(Format('   ActiveRecordMappingRegistry.AddEntity(''%s'', %s);', [ATableName.ToLower, AClassName]) + sLineBreak);
   end;
end;

function TARGeneratorController.GetUniqueIdentifiers(const MetaData           :TFDMetaInfoQuery;
                                                     const FormatAsPascalCase :Boolean): TArray<string>;
var i         :Integer;
    List      :TStringList;
    Field     :string;
    FTemp     :string;
    Count     :Integer;
    FieldName :string;
begin
   MetaData.First;
   SetLength(Result, MetaData.RecordCount);
   List := TStringList.Create;
   try
      List.Sorted := True;
      i := 0;
      while not MetaData.EOF do begin
         FieldName := MetaData.FieldByName(META_F_COLUMN_NAME).AsString;

         if FormatAsPascalCase then
            Field := CamelCase(FieldName, True)
         else Field := FieldName;

         {if the Field exists previously...}
         if List.IndexOf(Field) > -1 then Field := FieldName;
         FTemp := Field;

         {If the FieldName is a Pascal Reserved keyword...}
         if IsReservedKeyword(FTemp) then begin
            FTemp := '_' + FTemp;
         end;

         {Add a number at the end of field number to assure the FieldName is Unique}
         Count := 0;
         while List.IndexOf(FTemp) > -1 do begin
            Inc(Count);
            FTemp := Field + '_' + IntToStr(Count);
         end;

         Field := FTemp;

         List.Add(Field);
         Result[i] := Field;
         Inc(i);
         MetaData.Next;
      end;
   finally
      List.Free;
   end;
end;

function TARGeneratorController.GetMaxLengthFieldName(FieldNames :TArray<string>):Integer;
var i :Integer;
begin
   Result := 0;
   for i := 0 to Length(FieldNames) - 1 do begin
      if Length(FieldNames[i]) > Result then begin
         Result := Length(FieldNames[i]);
      end;
   end;

   Result := Result + 1;
end;

function TARGeneratorController.GetCurrentColumnAttribute(MetaData :TFDMetaInfoQuery):TFDDataAttributes;
var i :Integer;
begin
   { TFDDataAttribute = (caSearchable, caAllowNull, caFixedLen  ,
                         caBlobData  , caReadOnly , caAutoInc   , caROWID   , caDefault,
                         caRowVersion, caInternal , caCalculated, caVolatile, caUnnamed,
                         caVirtual   , caBase     , caExpr);
   }
   i := MetaData.FieldByName('COLUMN_ATTRIBUTES').AsInteger;
   Result := TFDDataAttributes(Pointer(@i)^);
end;

procedure TARGeneratorController.InsertField(IntfCode :TStringStream;
                                             const CW                :Integer; {Column Width}
                                             const ColType           :string;
                                             const DatabaseFieldName :string;
                                             const UniqueFieldName   :string;
                                             const FieldDataType     :TFDDataType;
                                             const ColumnAttrib      :TFDDataAttributes;
                                             const IsPK              :Boolean);
var RTTIAttrib :string;
    Field      :string;
begin
   if IsPK then begin
      if caAutoInc in ColumnAttrib then
         RTTIAttrib := Format('[MVCTableField(''%s'', [foPrimaryKey, foAutoGenerated])]', [DatabaseFieldName])
      else
         RTTIAttrib := Format('[MVCTableField(''%s'', [foPrimaryKey])]', [DatabaseFieldName])
   end
   else begin
      if ColType.Contains('json') or ColType.Contains('xml') then
         RTTIAttrib := Format('[MVCTableField(''%s'', [], ''%s'')]', [DatabaseFieldName, ColType])
      else
         RTTIAttrib := Format('[MVCTableField(''%s'')]', [DatabaseFieldName])
   end;

   if IsPK and (caAutoInc in ColumnAttrib) then
      Field := Col(GetFieldName(UniqueFieldName), CW) + ' :' + GetDelphiType(FieldDataType, ColumnAttrib, True) + ';' + sLineBreak
   else
      Field := Col(GetFieldName(UniqueFieldName), CW) + ' :' + GetDelphiType(FieldDataType, ColumnAttrib) + ';' + sLineBreak;


   {if the field is not supported by MVC, add a comment}
   if GetDelphiType(FieldDataType, ColumnAttrib).ToUpper.Contains('UNSUPPORTED TYPE') then begin
      RTTIAttrib := '//' + RTTIAttrib;
      Field      := '//' + Field;
   end
   else begin
      Field      := '  ' + Field;
      RTTIAttrib := '  ' + RTTIAttrib;
   end;

   IntfCode.WriteString('  ' + RTTIAttrib + sLineBreak + '  ' + Field);
end;

function TARGeneratorController.GetDelphiType(const FireDACType: TFDDataType; const ColumnAttrib: TFDDataAttributes; const ForceNullable: Boolean): string;
begin
   case FireDACType of
      dtWideString, dtWideMemo    :Result := 'String';
      dtAnsiString, dtMemo        :Result := 'String';
      dtByte                      :Result := 'Byte';
      dtInt16                     :Result := 'Int16';
      dtUInt16                    :Result := 'UInt16';
      dtInt32                     :Result := 'Int32';
      dtUInt32                    :Result := 'UInt32';
      dtInt64                     :Result := 'Int64';
      dtUInt64                    :Result := 'UInt64';
      dtBoolean                   :Result := 'Boolean';
      dtDouble,  dtExtended       :Result := 'Double';
      dtSingle                    :Result := 'Single';
      dtCurrency, dtBCD, dtFmtBCD :Result := 'Currency';
      dtDate                      :Result := 'TDate';
      dtTime                      :Result := 'TTime';
      dtDateTime                  :Result := 'TDateTime';
      dtTimeIntervalFull          :Result := 'TDateTime {dtTimeIntervalFull}';
      dtDateTimeStamp             :Result := 'TDateTime {dtDateTimeStamp}';
      //dtAutoInc                   :Result := 'Integer {autoincrement}';
      dtBlob                      :Result := 'TStream'; //, { ftMemo, } dtGraphic, { ftFmtMemo, ftWideMemo, } dtStream:
      //dtFixedChar                 :Result := 'String {fixedchar}';
      //ftWideString              :Result := 'String';
      dtXML                       :Result := 'String {XML}';
      dtGuid                      :Result := 'TGuid';
      //dtDBaseOle                :Result := 'String {ftDBaseOle}';
   else
      Result := '<UNSUPPORTED TYPE: ' + GetEnumName(TypeInfo(TFDDataType), Ord(FireDACType)) + '>';
   end;

   if ForceNullable or ((Result <> 'TStream') and (caAllowNull in ColumnAttrib)) then begin
      Result := 'Nullable' + Result;
   end;
end;

function TARGeneratorController.GetFieldName(const Value :string):string;
begin
   if Value.Length <= 2 then
      Result := 'F' + Value.ToUpper
   else
      Result := 'F' + Value;
end;

procedure TARGeneratorController.InsertProperty(IntfCode :TStringStream;
                                                const CW            :Integer; {Column Width}
                                                const FieldName     :string;
                                                const ColumnAttrib  :TFDDataAttributes;
                                                const FieldDataType :TFDDataType;
                                                const IsPK          :Boolean);
var Prop: string;
begin
   if IsPK then begin
      Prop := Prop + 'property ' + Col(GetFieldName(FieldName).Substring(1), CW) { remove f } + ' :' +
         Col(GetDelphiType(FieldDataType, ColumnAttrib, [caAllowNull,caAutoInc] * ColumnAttrib <> []), 20)
         + ' read ' + Col(GetFieldName(FieldName), CW) + ' write ' + Col(GetFieldName(FieldName), CW) + ';' + sLineBreak;
   end
   else begin
      Prop := Prop + 'property ' + Col(GetFieldName(FieldName).Substring(1), CW) { remove f } + ' :' +
         Col(GetDelphiType(FieldDataType, ColumnAttrib), 20)
         + ' read ' + Col(GetFieldName(FieldName), CW) + ' write ' + Col(GetFieldName(FieldName), CW) + ';' + sLineBreak;
   end;

   if GetDelphiType(FieldDataType, ColumnAttrib).ToUpper.Contains('UNSUPPORTED TYPE') then
      Prop := '  //' + Prop
   else
      Prop := '  ' + Prop;

   IntfCode.WriteString('  ' + Prop)
end;

procedure TARGeneratorController.InsertComment(IntfCode :TStringStream);
begin
   IntfCode.WriteString('(***************************************************************************  ' + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + ' Delphi MVC Framework' + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + 'Copyright (c) 2010-' + YearOf(Date).ToString + ' Daniele Teti and the DMVCFramework Team' + sLineBreak);
   IntfCode.WriteString(INDENT + 'https://github.com/danieleteti/delphimvcframework'                                        + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + 'This component editor Copyright (c) 2023-' + YearOf(Date).ToString + ' Juan C.Cilleruelo' + sLineBreak);
   IntfCode.WriteString(INDENT + 'https://github.com/juanccilleruelo/senCilleMVCActiveRecordAdds'                           + sLineBreak);
   IntfCode.WriteString(INDENT + 'http://www.sencille.es'                                                                   + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + '***************************************************************************' + sLineBreak);
   IntfCode.WriteString(INDENT + '******************   A T T E N T I O N   ! ! !   **************************' + sLineBreak);
   IntfCode.WriteString(INDENT + '***************************************************************************' + sLineBreak);
   IntfCode.WriteString(INDENT + 'This code has been generated automatically from the property editor'         + sLineBreak);
   IntfCode.WriteString(INDENT + 'of the TFDConnection component.'                                             + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + 'Please, modify it with care and be aware that if you generate it again,'     + sLineBreak);
   IntfCode.WriteString(INDENT + 'your modifications will be lost. '                                           + sLineBreak);
   IntfCode.WriteString(INDENT + '***************************************************************************' + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + 'Licensed under the Apache License, Version 2.0 (the "License");'  + sLineBreak);
   IntfCode.WriteString(INDENT + 'you may not use this file except in compliance with the License.' + sLineBreak);
   IntfCode.WriteString(INDENT + 'You may obtain a copy of the License at'                          + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + 'http://www.apache.org/licenses/LICENSE-2.0'                       + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString(INDENT + 'Unless required by applicable law or agreed to in writing, software'      + sLineBreak);
   IntfCode.WriteString(INDENT + 'distributed under the License is distributed on an "AS IS" BASIS,'        + sLineBreak);
   IntfCode.WriteString(INDENT + 'WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.' + sLineBreak);
   IntfCode.WriteString(INDENT + 'See the License for the specific language governing permissions and'      + sLineBreak);
   IntfCode.WriteString(INDENT + 'limitations under the License.' + sLineBreak);
   IntfCode.WriteString(INDENT + sLineBreak);
   IntfCode.WriteString('***************************************************************************)' + sLineBreak);
   IntfCode.WriteString(sLineBreak);
end;

function TARGeneratorController.Col(Text :string; Spaces :Integer):string;
begin
   Result := Trim(Text) + StringOfChar(' ', Spaces - Length(Text));
end;

function TARGeneratorController.IsReservedKeyword(const Value: String): Boolean;
const PASCAL_KEYWORDS = ';and;array;as;as;asm;begin;break;case;class;class;const;' +
  'constref;constref;constructor;continue;destructor;dispose;dispose;div;do;downto;' +
  'else;end;except;except;exit;exit;exports;false;file;finalization;finally;for;function;' +
  'goto;if;implementation;in;inherited;initialization;inline;interface;is;label;' +
  'library;mod;new;nil;not;object;of;on;on;operator;or;out;packed;procedure;program;' +
  'property;raise;record;reference;repeat;self;set;shl;shr;string;then;threadvar;to;' +
  'true;try;type;unit;until;uses;var;while;with;xor;';
begin
   Result := PASCAL_KEYWORDS.Contains(';' + Value.ToLower + ';');
end;


end.
