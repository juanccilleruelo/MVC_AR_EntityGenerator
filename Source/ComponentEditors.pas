unit ComponentEditors;

interface

uses System.Classes,
     VCL.Controls, VCL.Forms, VCL.Dialogs,
     DesignIntf, DesignEditors;

type
  TscARGeneratorCompEditor = class (TComponentEditor)
  private
    FOldEditor: IComponentEditor;
  public
    { Called to create the component editor. AComponent is the component to be edited by the editor.         }
    { ADesigner is an interface to the designer to find controls and create methods (this is not used often).}
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    destructor Destroy;                                               override;
    {Called when the component is being copied to the clipboard. The component's filed image is already on the   }
    {clipboard. This gives the component editor a chance to paste a different type of format which is ignored by }
    {the designer but might be recoginised by another application.                                               }

    {The number of valid indexes to GetVerb and ExecuteVerb. The index is assumed to be zero based (i.e. 0..GetVerbCount - 1).}
    function GetVerbCount: Integer;                                   override;
    {The component editor should return a string that will be displayed in the context menu. It is the responsibility of }
    {the component editor to place the & character and the '...' characters as appropriate.                              }
    function GetVerb(Index: Integer):string;                         override;
    {The Index'ed verb was selected by the user of the context menu. The meaning of this is determined by the component editor.}
    procedure ExecuteVerb(Index: Integer);                            override;
    {Called when the user double-clicks the component. The component editor can bring up a dialog in response }
    {to this method, for example, or some kind of design expert. If GetVerbCount is greater than zero, edit   }
    {will execute the first verb in the list (ExecuteVerb(0)).                                                }
    procedure Edit;                                                   override;
    procedure Copy;                                                   override;
    procedure ShowEditor;
  end;

implementation

uses Data.DB, scARGeneratorDlg,
     DataSnap.DBClient,
     FireDAC.Comp.Client;
     {IBX.IBQuery, IBX.IBTable, IBX.IBSQL, IBX.IBCustomDataSet;}

     {We need to get the path of the File that contains the current component. This is for save there the resulting ARFile.}
     {We need to know the project path, to load from where the configuration for this components, including:
     { the path,
     { DataSet    := DataModuleIRConnection.QPedidos;

       TableName  := 'PEDIDOS';
       Singular   := 'Pedido';
       Plural     := 'Pedidos';
       FileName   := senCilleFolder+'irConnection\ARPedido.pas';

       WithDetail := True;
       DetailData := TDetailDataClass.Create;
       DetailData.UnitName   := 'ARLinPedido' ;
       DetailData.TypeName   := 'TLinPedidoAR';
       DetailData.PropName   := 'Lines'        ;
       DetailData.MemberName := 'Line'         ;}

var PrevEditorFDQueryClass       :TComponentEditorClass = nil;
var PrevEditorFDTableClass       :TComponentEditorClass = nil;
var PrevEditorFDMemTableClass    :TComponentEditorClass = nil;
var PrevEditorFDStoredProcClass  :TComponentEditorClass = nil;
var PrevEditorClientDataSetClass :TComponentEditorClass = nil;
var PrevEditorIBQueryClass       :TComponentEditorClass = nil;
var PrevEditorIBTableClass       :TComponentEditorClass = nil;
var PrevEditorIBSQLClass         :TComponentEditorClass = nil;
var PrevEditorIBDataSetClass     :TComponentEditorClass = nil;

constructor TscARGeneratorCompEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
   inherited Create(AComponent, ADesigner);
   if AComponent is TFDQuery then begin
      if Assigned(PrevEditorFDQueryClass) then begin
         FOldEditor := TComponentEditor(PrevEditorFDQueryClass.Create(AComponent, ADesigner));
      end;
   end else
   if AComponent is TFDTable then begin
      if Assigned(PrevEditorFDTableClass) then begin
         FOldEditor := TComponentEditor(PrevEditorFDTableClass.Create(AComponent, ADesigner));
      end;
   end else
   if AComponent is TFDMemTable then begin
      if Assigned(PrevEditorFDMemTableClass) then begin
         FOldEditor := TComponentEditor(PrevEditorFDMemTableClass.Create(AComponent, ADesigner));
      end;
   end else
   if AComponent is TFDStoredProc then begin
      if Assigned(PrevEditorFDStoredProcClass) then begin
         FOldEditor := TComponentEditor(PrevEditorFDStoredProcClass.Create(AComponent, ADesigner));
      end;
   end else
   if AComponent is TClientDataSet then begin
      if Assigned(PrevEditorClientDataSetClass) then begin
         FOldEditor := TComponentEditor(PrevEditorClientDataSetClass.Create(AComponent, ADesigner));
      end;
   end(*else
   if AComponent is TIBQuery then begin
      if Assigned(PrevEditorIBQueryClass) then begin
         FOldEditor := TComponentEditor(PrevEditorIBQueryClass.Create(AComponent, ADesigner));
      end;
   end else
   if AComponent is TIBTable then begin
      if Assigned(PrevEditorIBTableClass) then begin
         FOldEditor := TComponentEditor(PrevEditorIBTableClass.Create(AComponent, ADesigner));
      end;
   end else
   if AComponent is TIBSQL then begin
      if Assigned(PrevEditorIBSQLClass) then begin
         FOldEditor := TComponentEditor(PrevEditorIBSQLClass.Create(AComponent, ADesigner));
      end;
   end else
   if AComponent is TIBDataSet then begin
      if Assigned(PrevEditorIBDataSetClass) then begin
         FOldEditor := TComponentEditor(PrevEditorIBDataSetClass.Create(AComponent, ADesigner));
      end;
   end*);
end;

destructor TscARGeneratorCompEditor.Destroy;
begin
   inherited;
end;

procedure TscARGeneratorCompEditor.ExecuteVerb(Index: Integer);
begin
   if Index = 0 then ShowEditor
   else begin
      if Assigned(FOldEditor) then begin
         FOldEditor.ExecuteVerb(Index - 1);
      end;
   end;
end;

function TscARGeneratorCompEditor.GetVerb(Index: Integer):string;
begin
   if Index = 0 then Result := 'Active Record Generator (senCille.es)...'
   else begin
      if Assigned(FOldEditor) then begin
         Result := FOldEditor.GetVerb(Index - 1);
      end;
   end;
end;

function TscARGeneratorCompEditor.GetVerbCount: Integer;
begin
   Result := 1;
   if Assigned(FOldEditor) then begin
      Inc(Result, FOldEditor.GetVerbCount);
   end;
end;

procedure TscARGeneratorCompEditor.Edit;
begin
   ShowEditor;
end;

procedure  TscARGeneratorCompEditor.Copy;
begin
   if Assigned(FOldEditor) then begin
     FOldEditor.Copy;
   end;
end;

procedure TscARGeneratorCompEditor.ShowEditor;
var AQuery       :TDataSet;
    DesignerView :TViewARGenerator;
begin
   AQuery := Component as TDataSet;
   if Assigned(AQuery) then begin
      (*if not Assigned(AQuery.Connection) then begin
        ShowMessage('Assign Database first.');
      end
      else begin*)
        DesignerView := TViewARGenerator.Create(nil);
        try
           { Set curent value to designer view }
           DesignerView.DataSet := TDataSet(Component);
           { Show MordalForm, and then take result }
           if DesignerView.ShowModal = mrOK then begin
              {Really we don't need to check anything here}
           end;
        finally
          DesignerView.Free;
        end;
        Designer.Modified;
      //end;
   end
   else begin
      ShowMessage('Component not assigned!');
   end;
end;

procedure Register;
var FDQuery      :TFDQuery;
    FDTable      :TFDTable;
    FDMemTable   :TFDMemTable;
    FDStoredProc :TFDStoredProc;
    ClientDataSet :TClientDataSet;
    Editor  :IComponentEditor;
begin
   FDQuery := TFDQuery.Create(nil);
   try
      Editor := GetComponentEditor(FDQuery, nil);
      if Assigned(Editor) then begin
        PrevEditorFDQueryClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      FDQuery.Free;
   end;
   RegisterComponentEditor(TFDQuery, TscARGeneratorCompEditor);

   {------------------------------------------------------------------}
   FDTable := TFDTable.Create(nil);
   try
      Editor := GetComponentEditor(FDTable, nil);
      if Assigned(Editor) then begin
        PrevEditorFDTableClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      FDTable.Free;
   end;
   RegisterComponentEditor(TFDTable, TscARGeneratorCompEditor);

   {------------------------------------------------------------------}
   FDMemTable := TFDMemTable.Create(nil);
   try
      Editor := GetComponentEditor(FDMemTable, nil);
      if Assigned(Editor) then begin
        PrevEditorFDMemTableClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      FDMemTable.Free;
   end;
   RegisterComponentEditor(TFDMemTable, TscARGeneratorCompEditor);

   {------------------------------------------------------------------}
   FDStoredProc := TFDStoredProc.Create(nil);
   try
      Editor := GetComponentEditor(FDStoredProc, nil);
      if Assigned(Editor) then begin
        PrevEditorFDStoredProcClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      FDStoredProc.Free;
   end;
   RegisterComponentEditor(TFDStoredProc, TscARGeneratorCompEditor);

   {------------------------------------------------------------------}
   ClientDataSet := TClientDataSet.Create(nil);
   try
      Editor := GetComponentEditor(ClientDataSet, nil);
      if Assigned(Editor) then begin
        PrevEditorClientDataSetClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      ClientDataSet.Free;
   end;
   RegisterComponentEditor(TClientDataSet, TscARGeneratorCompEditor);

   {------------------------------------------------------------------}
   (*IBQuery := TIBQuery.Create(nil);
   try
      Editor := GetComponentEditor(IBQuery, nil);
      if Assigned(Editor) then begin
        PrevEditorIBQueryClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      IBQuery.Free;
   end;
   RegisterComponentEditor(TIBQuery, TscARGeneratorCompEditor);*)

   {------------------------------------------------------------------}
   (*IBTable := TIBTable.Create(nil);
   try
      Editor := GetComponentEditor(IBTable, nil);
      if Assigned(Editor) then begin
        PrevEditorIBTableClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      IBTable.Free;
   end;
   RegisterComponentEditor(TIBTable, TscARGeneratorCompEditor);*)

   {------------------------------------------------------------------}
   (*IBSQL := TIBSQL.Create(nil);
   try
      Editor := GetComponentEditor(IBSQL, nil);
      if Assigned(Editor) then begin
        PrevEditorIBSQLClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      IBSQL.Free;
   end;
   RegisterComponentEditor(TIBSQL, TscARGeneratorCompEditor);*)

   {------------------------------------------------------------------}
   (*IBDataSet := TIBDataSet.Create(nil);
   try
      Editor := GetComponentEditor(IBDataSet, nil);
      if Assigned(Editor) then begin
        PrevEditorIBDataSetClass := TComponentEditorClass((Editor as TObject).ClassType);
      end;
   finally
      Editor := nil;
      IBDataSet.Free;
   end;
   RegisterComponentEditor(TIBDataSet, TscARGeneratorCompEditor);*)
end;

initialization
   Register;
end.



