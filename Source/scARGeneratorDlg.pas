unit scARGeneratorDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  {Vcl.Controls,} Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ToolsAPI, Vcl.ComCtrls,
  Data.DB,
  scARGeneratorController, Vcl.Controls;

type
  TViewARGenerator = class(TForm)
    Label1: TLabel;
    Label6: TLabel;
    EditSingularForm: TEdit;
    GroupBox1: TGroupBox;
    StaticText1: TStaticText;
    TextProjectFileName: TStaticText;
    StaticText2: TStaticText;
    TextTargetFilePath: TStaticText;
    StaticText3: TStaticText;
    TextTargetFileName: TStaticText;
    StaticText5: TStaticText;
    TextTargetClassName: TStaticText;
    TreeViewARs: TTreeView;
    BtnCancel: TButton;
    BtnAccept: TButton;
    Label2: TLabel;
    EditDetailClassName: TEdit;
    BtnDeleteDetailClassName: TButton;
    Memo1: TMemo;
    BtnDeleteAR: TButton;
    Label3: TLabel;
    EditDetailPropName: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnAcceptClick(Sender: TObject);
    procedure EditSingularFormChange(Sender: TObject);
    procedure BtnDeleteDetailClassNameClick(Sender: TObject);
    procedure EditDetailClassNameChange(Sender: TObject);
    procedure TreeViewARsDblClick(Sender: TObject);
    procedure BtnDeleteARClick(Sender: TObject);
  private
    FDataSet :TDataSet;
    FARGenerator :TscARGeneratorController;
    FEditPropNameEnabled: Boolean;
    function GetCurrentUnitPath :string;
    function GetCurrentUnitName :string;
    function GetProjectGroup: IOTAProjectGroup;
    function GetCurrentProjectName: string;
    procedure SetDataSet(Value :TDataSet);
    procedure SetEditPropNameEnabled(const Value: Boolean);
    property EditPropNameEnabled :Boolean read FEditPropNameEnabled write SetEditPropNameEnabled;
  public
    property DataSet :TDataSet read FDataSet write SetDataSet;
  end;

var
  ViewARGenerator: TViewARGenerator;

implementation

uses System.IOUtils, scARFileGenerator;

{$R *.dfm}

(*http://www.gexperts.org/open-tools-api-faq/*)

{TODO: Delete a Dataset information and optionally the File at disk}
{TODO: If necessary, include the file created in the project}
(*uses
  ToolsAPI;

var
  currentProject: IOTAProject;
begin
  currentProject := GetActiveProject();
  currentProject.AddFile('MyUnit.pas', True);*)

{TODO: When delete, exclude the file created from the project}

{TODO: With Plain Class for Grids and Serialization}
{TODO: With Serialization                          }

procedure TViewARGenerator.FormCreate(Sender: TObject);
begin
   FARGenerator := TscARGeneratorController.Create;
   FARGenerator.ARsFileName    := GetCurrentProjectName;
   FARGenerator.TargetFilePath := GetCurrentUnitPath;
   {Initialize view controls accordingly with the Data in ARDefine}
   EditSingularForm.Text         := FARGenerator.SingularName;
   EditDetailClassName.Text      := FARGenerator.Detail_ClassName;
   EditDetailPropName.Text       := FARGenerator.Detail_PropName;
   EditPropNameEnabled := FARGenerator.Detail_ClassName <> '';
end;

procedure TViewARGenerator.FormDestroy(Sender: TObject);
begin
   FARGenerator.Free;
end;

procedure TViewARGenerator.BtnAcceptClick(Sender: TObject);
begin
   if FARGenerator.Detail_ClassName <> '' then begin
      FARGenerator.Detail_ClassName  := EditDetailClassName.Text;
      FARGenerator.Detail_PropName   := EditDetailPropName.Text;
   end;

   FARGenerator.AcceptProcess;
   ModalResult := mrOK;
end;

procedure TViewARGenerator.BtnCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TViewARGenerator.BtnDeleteDetailClassNameClick(Sender: TObject);
begin
   EditDetailClassName.Text := '';
   EditDetailPropName.Text  := '';
   EditPropNameEnabled := False;
end;

procedure TViewARGenerator.BtnDeleteARClick(Sender: TObject);
begin
   //Delete a Class and if the user want, the file in the Disc.
end;

procedure TViewARGenerator.EditDetailClassNameChange(Sender: TObject);
begin
   FARGenerator.Detail_ClassName := EditDetailClassName.Text;
   EditPropNameEnabled := True;
end;

procedure TViewARGenerator.EditSingularFormChange(Sender: TObject);
begin
   FARGenerator.SingularName   := EditSingularForm.Text;
   TextTargetFileName.Caption  := FARGenerator.TargetFileName;
   TextTargetClassName.Caption := FARGenerator.TargetClassName;
end;

procedure TViewARGenerator.SetDataSet(Value: TDataSet);
begin
   FDataSet := Value;
   FARGenerator.DataSet         := FDataSet;
   FARGenerator.DataSetName     := FDataSet.Name;
   FARGenerator.HostingUnitName := GetCurrentUnitName;
   FARGenerator.FeedTreeView(TreeViewARs);

   {after assign DataSet, if exists an entry in ARs the controller has recovered values from it}

   EditSingularForm.OnChange := nil;
   try
      EditSingularForm.Text := FARGenerator.SingularName;
   finally
      EditSingularForm.OnChange := EditSingularFormChange;
   end;

   EditDetailClassName.OnChange := nil;
   try
      EditDetailClassName.Text := FARGenerator.Detail_ClassName;
      EditPropNameEnabled := Trim(FARGenerator.Detail_ClassName) <> '';
      if EditPropNameEnabled then begin
         EditDetailPropName.Text := FARGenerator.Detail_PropName;
      end;
   finally
      EditDetailClassName.OnChange := EditDetailClassNameChange;
   end;
end;

procedure TViewARGenerator.SetEditPropNameEnabled(const Value: Boolean);
begin
   FEditPropNameEnabled := Value;
   if FEditPropNameEnabled then begin
      EditDetailPropName.Color      := clWindow;
      EditDetailPropName.TabStop    := True;
      EditDetailPropName.Enabled    := True;
   end
   else begin
      EditDetailPropName.Text       := '';
      EditDetailPropName.Color      := cl3DLight;
      EditDetailPropName.TabStop    := False;
      EditDetailPropName.Enabled    := False;
   end;
end;

procedure TViewARGenerator.TreeViewARsDblClick(Sender: TObject);
var CurNode  :TTreeNode;
    ARDefine :TscARDefine;
begin
   CurNode  := TreeViewARs.Selected;
   ARDefine := TscARDefine(CurNode.Data);
   EditDetailClassName.Text := ARDefine.TargetClassName;
   EditDetailPropName.SetFocus;
end;

procedure TViewARGenerator.FormShow(Sender: TObject);
begin
   TextProjectFileName.Caption := FARGenerator.ARsFileName;
   TextTargetFilePath.Caption  := FARGenerator.TargetFilePath;
   EditSingularFormChange(Self);
end;

function TViewARGenerator.GetProjectGroup: IOTAProjectGroup;
var IModuleServices :IOTAModuleServices;
    IModule         :IOTAModule;
    i               :Integer;
begin
   Assert(Assigned(BorlandIDEServices));
   IModuleServices := BorlandIDEServices as IOTAModuleServices;
   Assert(Assigned(IModuleServices));
   Result := nil;
   for i := 0 to IModuleServices.ModuleCount - 1 do begin
      IModule := IModuleServices.Modules[i];
      if IModule.QueryInterface(IOTAProjectGroup, Result) = S_OK then begin
         Break;
      end;
   end;
end;

function TViewARGenerator.GetCurrentProjectName: string;
var  Project      :IOTAProject;
     ProjectGroup :IOTAProjectGroup;
     FileName     :string;
     Path         :string;
begin
   Result := '';
   ProjectGroup := GetProjectGroup;
   if Assigned(ProjectGroup) then begin
      Project := ProjectGroup.ActiveProject;
      if Assigned(Project) then begin
         FileName := TPath.GetFileNameWithoutExtension(ExtractFileName(Project.FileName));
         Path     := ExtractFilePath(Project.FileName);
         Result   := Path+FileName+'.ar';
      end;
   end;
end;

function TViewARGenerator.GetCurrentUnitPath: string;
var ModuleServices :IOTAModuleServices;
    Module         :IOTAModule;
    SourceEditor   :IOTASourceEditor;
    idx            :Integer;
begin
  Result       := '';
  SourceEditor := nil;
  if System.SysUtils.Supports(BorlandIDEServices, IOTAModuleServices, ModuleServices) then begin
     Module := ModuleServices.CurrentModule;

     if System.Assigned(Module) then begin
        idx := Module.GetModuleFileCount - 1;

        // Iterate over modules till we find a source editor or list exhausted
        while (idx >= 0) and not System.SysUtils.Supports(Module.GetModuleFileEditor(idx), IOTASourceEditor, SourceEditor) do begin
           System.Dec(idx);
        end;

        // Success if list wasn't ehausted.
        if idx >= 0 then begin
           Result := ExtractFilePath(SourceEditor.FileName);
        end;
     end;
  end;
end;

function TViewARGenerator.GetCurrentUnitName: string;
var ModuleServices :IOTAModuleServices;
    Module         :IOTAModule;
    SourceEditor   :IOTASourceEditor;
    idx            :Integer;
begin
  Result       := '';
  SourceEditor := nil;
  if System.SysUtils.Supports(BorlandIDEServices, IOTAModuleServices, ModuleServices) then begin
     Module := ModuleServices.CurrentModule;

     if System.Assigned(Module) then begin
        idx := Module.GetModuleFileCount - 1;

        // Iterate over modules till we find a source editor or list exhausted
        while (idx >= 0) and not System.SysUtils.Supports(Module.GetModuleFileEditor(idx), IOTASourceEditor, SourceEditor) do begin
           System.Dec(idx);
        end;

        // Success if list wasn't ehausted.
        if idx >= 0 then begin
           Result := ExtractFileName(SourceEditor.FileName);
        end;
     end;
  end;
end;

end.




