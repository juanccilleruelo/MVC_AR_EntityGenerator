unit scARGeneratorController;

interface

uses System.Classes, System.Generics.Collections, System.Rtti, System.DateUtils,
     System.SysUtils, System.Types, System.UITypes, System.Variants,
     Data.DB,
     VCL.ComCtrls,
     System.JSON, Data.DBXJSONReflect,
     scARFileGenerator;

type
  TscARGeneratorController = class
  private
    FARConfigs        :TObjectList<TscARDefine>;
    FARDefine         :TscARDefine;
    FDataSetName      :string;
    FHostingUnitName  :string;
    FDataSet          :TDataSet;
    FSingularName     :string;
    FARsFileName      :string;
    FTargetFilePath   :string;
    FTargetFileName   :string;
    FTargetClassName  :string;
    {------------------------}
    FDetail_ClassName :string;
    FDetail_PropName  :string;
    {------------------------}
    FDetail_MemberName: string;
    function StringToARDefine(Value :string):TscARDefine;
    function ARDefineToString(Value :TscARDefine):string;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetSingularName(const Value :string);
    procedure SetDataSetName(const Value :string);
    procedure SetHostingUnitName(const Value :string);
    procedure SetARsFileName(const Value :string);
    procedure SetDetail_ClassName(const Value :string);

    procedure LoadARProjectFile; {Get from disk the file containing all the previously configured ARs in this application} {If not exists, creates a new one}
    procedure SaveARProjectFile;
    procedure AssignDataToARDefine;
    procedure SetDetail_PropName(const Value: string);
    procedure SetDetail_MemberName(const Value: string);
  protected
    {--- Serialization ---}
    procedure SetSerialized(Value :string);
  public
    constructor Create;
    destructor  Destroy; override;
    procedure AcceptProcess;
    procedure FeedTreeView(ATreeView :TTreeView);
  public
    property DataSetName       :string     read FDataSetName       write SetDataSetName;
    property HostingUnitName   :string     read FHostingUnitName   write SetHostingUnitName;
    property Detail_ClassName  :string     read FDetail_ClassName  write SetDetail_ClassName;
    property Detail_PropName   :string     read FDetail_PropName   write SetDetail_PropName;
    property Detail_MemberName :string     read FDetail_MemberName write SetDetail_MemberName;

    property DataSet         :TDataSet                         write SetDataSet;
    property ARsFileName     :string     read FARsFileName     write SetARsFileName;
    property TargetFilePath  :string     read FTargetFilePath  write FTargetFilePath;
    property TargetFileName  :string     read FTargetFileName;
    property TargetClassName :string     read FTargetClassName;
    property SingularName    :string     read FSingularName    write SetSingularName;
  end;

implementation

uses VCL.Dialogs;

{ TscARGeneratorController }

constructor TscARGeneratorController.Create;
begin
   inherited;
   FARConfigs := TObjectList<TscARDefine>.Create(True);
   FARDefine  := nil;
end;

destructor TscARGeneratorController.Destroy;
begin
   FARConfigs.Free;
   inherited;
end;

procedure TscARGeneratorController.AcceptProcess;
var FileGenerator :TscARFileGenerator;
begin
    AssignDataToARDefine;
    SaveARProjectFile;
    FileGenerator := TscARFileGenerator.Create;
    try
       FileGenerator.ARDefine := FARDefine;
       FileGenerator.DataSet  := FDataSet;
       FileGenerator.Run;
       FileGenerator.Lines.SaveToFile(FTargetFilePath+FTargetFileName);
    finally
       FileGenerator.Free;
    end;
end;

procedure TscARGeneratorController.FeedTreeView(ATreeView :TTreeView);
var i :TscARDefine;
begin
   for i in FARConfigs do begin
      {The commented lines avoid that himself was included in the list, but in our projects, }
      { we discover that recursive owner is possible and very useful.                        }
      {if i.DataSetName <> FARDefine.DataSetName then begin}
         ATreeView.Items.AddChildObject(nil, i.TargetClassName + ' => '+i.HostingUnitName, i);
      {end;}
   end;
end;

{This method is called exclusivelly from AcceptProcess method}
procedure TscARGeneratorController.AssignDataToARDefine;
begin
   FARDefine.DataSetName       := FDataSetName    ; {This is the Key value to search, save and modify the values on the project}
   FARDefine.HostingUnitName   := FHostingUnitName;
   FARDefine.SingularName      := FSingularName   ;
   FARDefine.TargetFileName    := FTargetFileName ;
   {-------------------------------------------------}
   FARDefine.Detail_ClassName  := FDetail_ClassName;
   FARDefine.Detail_PropName   := FDetail_PropName ;
   //FARDefine.WithDetail := FARDefine.Detail_ClassName.Trim  <> '';
end;

procedure TscARGeneratorController.LoadARProjectFile;
var TextFile  :TStringList;
    i         :string;
    ARDefine :TscARDefine;
begin
   TextFile := TStringList.Create;
   if FileExists(FARsFileName) then begin
      TextFile.LoadFromFile(FARsFileName);
      for i in TextFile do begin
         if i.Trim <> '' then begin
            {Convert the string in a ARDefine}
            ARDefine := StringToARDefine(i);
            {Add the string to the list of Objects}
            FARConfigs.Add(ARDefine);
         end;
      end;
   end
   else begin
      {Creates an Empty File for next times}
      TextFile.SaveToFile(FARsFileName);
      ShowMessage('File '+FARsFileName+' created.'+#13+'Do not forget to include this file as part of your project configuration management policy.');
   end;
end;

procedure TscARGeneratorController.SaveARProjectFile;
var TextFile :TStringList;
    i        :TscARDefine;
begin
   TextFile := TStringList.Create;
   if not FileExists(FARsFileName) then begin
      ShowMessage('File '+FARsFileName+' does not exists.'+#13+'There was a problem in the creation of the file, Close the editor and try to open again.');
   end
   else begin
      for i in FARConfigs do begin
          TextFile.Add(ARDefineToString(i));
      end;
      TextFile.SaveToFile(FARsFileName);
   end;
end;

procedure TscARGeneratorController.SetDataSet(const Value: TDataSet);
begin
   FDataSet := Value;
end;

procedure TscARGeneratorController.SetSingularName(const Value: string);
begin
   FSingularName    := Value;
   FTargetFileName  := 'AR'+Value+'.pas';
   FTargetClassName := 'T'+Value+'AR';
   FARDefine.TargetClassName := FTargetClassName;
   FARDefine.TargetFileName  := FTargetFileName;
   FARDefine.HostingUnitName := FHostingUnitName;
end;

procedure TscARGeneratorController.SetDataSetName(const Value: string);
var i :TscARDefine;
begin
   FDataSetName := Value;
   {Goes througth the List searching a member with the same DataSetName}
   for i in FARConfigs do begin
      if i.DataSetName = DataSetName then begin
         FARDefine := i;
         Break;
      end;
   end;

   {if not found }
   if FARDefine = nil then begin
      FARDefine := TscARDefine.Create;
      FARDefine.DataSetName := Value;
      FARConfigs.Add(FARDefine);
   end;

   FDataSetName      := FARDefine.DataSetName    ; {This is the Key value to search, save and modify the values on the project}
   FHostingUnitName  := FARDefine.HostingUnitName;
   FSingularName     := FARDefine.SingularName   ;
   FTargetFileName   := FARDefine.TargetFileName ;
   {----------------------------------------------}
   FDetail_ClassName := FARDefine.Detail_ClassName;
   FDetail_PropName  := FARDefine.Detail_PropName ;
end;

procedure TscARGeneratorController.SetARsFileName(const Value: string);
begin
   FARsFileName := Value;
   LoadARProjectFile;
end;

procedure TscARGeneratorController.SetDetail_ClassName(const Value :string);
var i     :TscARDefine;
    Found :Boolean;
begin
   FDetail_ClassName := Value;

   Found := False;
   for i in FARConfigs do begin
      if LowerCase(Trim(i.TargetClassName)) = LowerCase(Trim(FDetail_ClassName)) then begin
         Found := True;
         //ShowMessage('SetDetail_ClassName');
         FARDefine.Detail_UnitName   := Copy(i.TargetFileName, 1, Pos('.', i.TargetFileName)-1);
         FARDefine.WithDetail        := True;
         FARDefine.Detail_ClassName  := i.TargetClassName;
         FARDefine.Detail_PropName   := i.Detail_PropName;
         Break;
      end;
   end;

   if not Found then begin
      {This happends when the user press Delete Value button}
      FARDefine.WithDetail        := False;
      FARDefine.Detail_UnitName   := '';
      FARDefine.Detail_ClassName  := '';
      FARDefine.Detail_PropName   := '';
   end;
end;

procedure TscARGeneratorController.SetDetail_MemberName(const Value: string);
begin
   FDetail_MemberName := Value;
end;

procedure TscARGeneratorController.SetDetail_PropName(const Value: string);
begin
   FDetail_PropName := Value;
end;

procedure TscARGeneratorController.SetHostingUnitName(const Value: string);
var Define :TscARDefine;
begin
   FHostingUnitName := Value;
   for Define in FARConfigs do begin
      //ShowMessage(Define.DataSetName+'  '+Define.HostingUnitName);
      if Define <> FARDefine then begin
         if (FDataSetName <> '') and (Define.DataSetName = FDataSetName) then begin
            if (FHostingUnitName <> '') and (Define.HostingUnitName <> FHostingUnitName) then begin
               ShowMessage('The class '+FTargetClassName+' exists previously, but created from '+Define.HostingUnitName+'.'+#13+
                           'You should manage it from the original hosting Form of this DataSet.');
               Abort;
            end;
         end;
      end;
   end;
end;

function TscARGeneratorController.ARDefineToString(Value :TscARDefine):string;
var WithDetail :string;
begin
   if Value.WithDetail then WithDetail := 'Y' else WithDetail := 'N';

   Result := Value.DataSetName       +#9+
             Value.HostingUnitName   +#9+
             Value.SingularName      +#9+
             Value.TargetClassName   +#9+
             Value.TargetFileName    +#9+
             WithDetail              +#9+
             Value.Detail_ClassName  +#9+
             Value.Detail_UnitName   +#9+
             Value.Detail_PropName   ;
end;

function TscARGeneratorController.StringToARDefine(Value :string):TscARDefine;
   function Split(Delimiter :Char; Text :string):TStringList;
   begin
      Result := TStringList.Create;
      Result.Delimiter       := Delimiter;
      Result.StrictDelimiter := True;
      Result.DelimitedText   := Text;
   end;

var Values :TStringList;
begin
   Values := Split(#9, Value);
   try
      Result := TscARDefine.Create;
      Result.DataSetName       := Values[ 0];
      Result.HostingUnitName   := Values[ 1];
      Result.SingularName      := Values[ 2];
      Result.TargetClassName   := Values[ 3];
      Result.TargetFileName    := Values[ 4];
      Result.WithDetail        := Values[ 5] = 'Y';
      Result.Detail_ClassName  := Values[ 6];
      Result.Detail_UnitName   := Values[ 7];
      Result.Detail_PropName   := Values[ 8];
   finally
      Values.Free;
   end;
end;

procedure TscARGeneratorController.SetSerialized(Value :string);
begin
   FARDefine := StringToARDefine(Value);
end;

end.

