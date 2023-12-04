unit scARFileGenerator;

interface

uses System.Classes,
     Data.DB;

type
  TscARDefine = class
  private
  protected
    constructor Create;
  public
    DataSetName     :string; {This is the Key value to search, save and modify the values on the project}
    HostingUnitName :string; {This is the name of the Unit in which is the dataset Hosted}
    SingularName    :string;
    TargetClassName :string;
    TargetFileName  :string;
    WithDetail      :Boolean;
    {-----------------------}
    Detail_ClassName :string;
    Detail_PropName  :string;
    Detail_UnitName  :string;
  end;

  TscARFileGenerator = class
  private
    FDataSet  :TDataSet;
    FLines    :TStringList;
    FARDefine :TscARDefine;
    function GetMaxLengthFieldName(aDataSet :TDataSet):Integer;
    function RFill(StrData :string; Long :Integer):string;
    function LFill(Strdata :string; Long :Integer):string;
    procedure RaiseException(Error :string);
  public
     constructor Create;
     destructor Destroy; override;
     procedure Run;
     property DataSet  :TDataSet    read FDataSet  write FDataSet;
     property ARDefine :TscARDefine read FARDefine write FARDefine;
     property Lines    :TStringList read FLines    write FLines;
  end;

implementation

uses System.Math, System.SysUtils, VCL.Dialogs;


{ TscARDefine }

constructor TscARDefine.Create;
begin
   WithDetail       := False;
   Detail_ClassName := '';
   Detail_UnitName  := '';
   Detail_PropName  := '';
end;

{ TscARFileGenerator }

constructor TscARFileGenerator.Create;
begin
   FLines := TStringList.Create;
end;

destructor TscARFileGenerator.Destroy;
begin
   FLines.Free;
end;

function TscARFileGenerator.GetMaxLengthFieldName(aDataSet: TDataSet): Integer;
var i :Integer;
begin
   Result := 0;
   for i := 0 to aDataSet.Fields.Count -1 do begin
      Result := Max(Length(aDataSet.Fields[i].FieldName), Result);
   end;
end;

procedure TscARFileGenerator.RaiseException(Error: string);
begin
   raise EInvalidOperation.Create(Error);
end;

function TscARFileGenerator.RFill(StrData: string; Long: Integer): string;
var Mask :string;
    i    :Integer;
begin
   Mask := '';
   for i := 1 to Long do Mask := Mask + ' ';

   if Length(Trim(StrData)) < Long then begin
      Result := StrData + Copy(Mask, 1, Long - Length(StrData));
   end
   else begin
      Result := Copy(StrData, 1, Long);
   end;
end;

function TscARFileGenerator.LFill(StrData: string; Long: Integer): string;
var Mask :string;
    i    :Integer;
begin
   Mask := '';
   for i := 1 to Long do Mask := Mask + ' ';

   if Length(Trim(StrData)) < Long then begin
      Result := Copy(Mask, 1, Long - Length(StrData)) + StrData;
   end
   else begin
      Result := Copy(StrData, 1, Long);
   end;
end;

procedure TscARFileGenerator.Run;
var i               :Integer;
    F               :Integer; {MaxLengthFieldName}
    CFN             :string;  {CurrentFieldName}
    TextRequired    :string;
begin
   F := GetMaxLengthFieldName(FDataSet);

   Lines.Clear;
   with Lines do begin
     Add('(***********************************************************)');
     Add('(* Unit generated automatically. Modify with care, please. *)');
     Add('(* (c) 2023 by Juan C.Cilleruelo                           *)');
     Add('(* contact with me at juanc.cilleruelo@sencille.es         *)');
     Add('(***********************************************************)');
     Add('{   ActiveRecord Generator Version : 6.01 =>  '+FormatDateTime('"Generated on " dddd, d mmmm, yyyy, " at " hh:mm', Now())+'   }');
     Add('');
     Add('unit AR'+FARDefine.SingularName+';');
     Add('');
     Add('interface');
     Add('');
     Add('uses System.SysUtils, System.Generics.Collections, ');
     Add('     Data.DB,                                      ');
     if not (FARDefine.WithDetail) or (FARDefine.Detail_UnitName = '') then begin
        Add('     senCille.ARClasses;                           ');
     end
     else begin
        Add('     senCille.ARClasses,                      ');
        Add('     '+FARDefine.Detail_UnitName+';           ');
     end;
     Add('');
     Add('type');
     Add('  T'+FARDefine.SingularName+'AR = class(TCustomAR)');
     Add('  private');
     if FARDefine.WithDetail then begin
        Add('    F'+FARDefine.Detail_PropName+' :TObjectList<'+FARDefine.Detail_ClassName+'>;    ');
     end;
     //I think this line is not necessary, because all previous declarations don't break the structure of the code.   Add('  private'); {This is necessary}
     for i := 0 to FDataSet.Fields.Count - 1 do begin
        case FDataSet.Fields[i].DataType of
           ftADT        :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TMemoField;'         );  // Abstract Data Type field
           ftDate       :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TDateField;'         );  // Date field
           ftReference  :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TReferenceField;'    );  // REF field
           ftDateTime   :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TDateTimeField;'     );  // Date and time field
           ftSmallint   :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TSmallintField;'     );  // 16-bit integer field
           ftArray      :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TArrayField;'        );  // Array field
           ftFloat      :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TFloatField;'        );  // Floating-point numeric field
           ftTimeStamp  :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TSQLTimeStampField;' );  // Floating-point numeric field
           ftAutoInc    :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TAutoIncField;'      );  // Auto-incrementing 32-bit integer counter field
           ftString     :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TStringField;'       );  // Character or string field
           ftFMTBCD     :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TFMTBCDField;'       );  // FMT Binary-Coded Decimal field
           ftBCD        :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TBCDField;'          );  // Binary-Coded Decimal field
           ftGraphic    :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TGraphicField;'      );  // Bitmap field
           ftTime       :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TTimeField;'         );  // Time field
           ftTypedBinary:Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TBinaryField;'       );  // Typed binary field
           ftVarBytes   :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TVarBytesField;'     );  // Variable number of bytes (binary storage)
           ftBlob       :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TBlobField;'         );  // Binary Large OBject field
           //TIDispatchField
           //TTVariantField
           ftBoolean    :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TBooleanField;'      );  // Boolean field
           ftInteger    :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TIntegerField;'      );  // 32-bit integer field
           ftWideString :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TWideStringField;'   );  // Wide string field
           ftBytes      :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TBytesField;'        );  // Fixed number of bytes (binary storage)
           //TInterfaceField
           ftWord       :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TWordField;'         );  // 16-bit unsigned integer field
           ftCurrency   :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TCurrencyField;'     );  // Money field
           ftLargeInt   :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TLargeintField;'     );  // Large integer field
           ftDataSet    :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TDataSetField;'      );  // DataSet field
           ftMemo       :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TMemoField;'         );  // Text memo field

           ftFixedChar  :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TStringField;' ); // Character or string field of fixed long
           ftWideMemo   :Add('    F'+RFill(FDataSet.Fields[i].FieldName, F+1)+':TWideMemoField;'); // Wide string field
           ftUnknown    :RaiseException('TDBIntegrity.AddCurrentValue: Field DataType = ftUnknown'); // Unknown or undetermined
           ftFmtMemo    ,                                                           // Formatted text memo field
           ftParadoxOle ,                                                           // Paradox OLE field
           ftDBaseOle   ,                                                           // dBASE OLE field
           ftCursor                                                                // Output cursor from an Oracle stored procedure (TParam only)
                 :RaiseException('TDBIntegrity.AddCurrentValue: Field DataType not Valid for a Primary Key');
           else RaiseException('TDBIntegrity.AddCurrentValue: Field DataType Unknown but not fkUnknown');
        end;
     end;
     Add('  protected');
     Add('    procedure Initialize; override;'); {It's called as part of the Create constructor. It's not allowed to be called from external objects}
     Add('  public');
     if FARDefine.WithDetail then begin
        Add('    destructor Destroy; override;');
     end;
     Add('    function Clone:T'+FARDefine.SingularName+'AR;');
     if FARDefine.WithDetail then begin
        Add('    property '+FARDefine.Detail_PropName+' :TObjectList<'+FARDefine.Detail_ClassName+'> read F'+FARDefine.Detail_PropName+' write F'+FARDefine.Detail_PropName+';    ');
     end;
     Add('  published');
     for i := 0 to FDataSet.Fields.Count - 1 do begin
        CFN := FDataSet.Fields[i].FieldName;
        case FDataSet.Fields[i].DataType of
           ftADT        :Add('    property '+RFill(CFN, F)+' :TMemoField         read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftDate       :Add('    property '+RFill(CFN, F)+' :TDateField         read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftReference  :Add('    property '+RFill(CFN, F)+' :TReferenceField    read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftDateTime   :Add('    property '+RFill(CFN, F)+' :TDateTimeField     read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftSmallint   :Add('    property '+RFill(CFN, F)+' :TSmallintField     read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftArray      :Add('    property '+RFill(CFN, F)+' :TArrayField        read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftFloat      :Add('    property '+RFill(CFN, F)+' :TFloatField        read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftTimeStamp  :Add('    property '+RFill(CFN, F)+' :TSQLTimeStampField read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftAutoInc    :Add('    property '+RFill(CFN, F)+' :TAutoIncField      read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftString     :Add('    property '+RFill(CFN, F)+' :TStringField       read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftFMTBCD     :Add('    property '+RFill(CFN, F)+' :TFMTBCDField       read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftBCD        :Add('    property '+RFill(CFN, F)+' :TBCDField          read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftGraphic    :Add('    property '+RFill(CFN, F)+' :TGraphicField      read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftTime       :Add('    property '+RFill(CFN, F)+' :TTimeField         read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftTypedBinary:Add('    property '+RFill(CFN, F)+' :TBinaryField       read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftVarBytes   :Add('    property '+RFill(CFN, F)+' :TVarBytesField     read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftBlob       :Add('    property '+RFill(CFN, F)+' :TBlobField         read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           //TIDispatchField
           //TTVariantField
           ftBoolean    :Add('    property '+RFill(CFN, F)+' :TBooleanField      read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftInteger    :Add('    property '+RFill(CFN, F)+' :TIntegerField      read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftWideString :Add('    property '+RFill(CFN, F)+' :TWideStringField   read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftBytes      :Add('    property '+RFill(CFN, F)+' :TBytesField        read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           //TInterfaceField
           ftWord       :Add('    property '+RFill(CFN, F)+' :TWordField         read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftCurrency   :Add('    property '+RFill(CFN, F)+' :TCurrencyField     read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftLargeInt   :Add('    property '+RFill(CFN, F)+' :TLargeIntField     read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftDataSet    :Add('    property '+RFill(CFN, F)+' :TDataSetField      read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftMemo       :Add('    property '+RFill(CFN, F)+' :TMemoField         read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');

           ftFixedChar  :Add('    property '+RFill(CFN, F)+' :TStringField       read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftWideMemo   :Add('    property '+RFill(CFN, F)+' :TWideMemoField     read F'+RFill(CFN, F)+' write F'+RFill(CFN, F)+';');
           ftUnknown    :RaiseException('TDBIntegrity.AddCurrentValue: Field DataType = ftUnknown'); // Unknown or undetermined
           ftFmtMemo    ,                                                           // Formatted text memo field
           ftParadoxOle ,                                                           // Paradox OLE field
           ftDBaseOle   ,                                                           // dBASE OLE field
           ftCursor                                                                 // Output cursor from an Oracle stored procedure (TParam only)
                 :RaiseException('TDBIntegrity.AddCurrentValue: Field DataType not Valid for a Primary Key');
           else RaiseException('TDBIntegrity.AddCurrentValue: Field DataType Unknown but not fkUnknown');
        end;
     end;
     Add('  end;');
     {---- End of Interface ----}
     Add('');
     Add('implementation');
     Add('uses TypInfo;');
     Add('');
     Add('{ T'+FARDefine.SingularName+'AR }');
     if FARDefine.WithDetail then begin
        Add('destructor T'+FARDefine.SingularName+'AR.Destroy;');
        Add('begin');
        if FARDefine.WithDetail then begin
           Add('   FreeAndNil(F'+FARDefine.Detail_PropName+'); ');
        end;
        Add('   inherited;');
        Add('end;');
     end;
     Add('');
     Add('procedure T'+FARDefine.SingularName+'AR.Initialize;');
     Add('begin');
     if FARDefine.WithDetail then begin
        Add('   F'+FARDefine.Detail_PropName+' := TObjectList<'+FARDefine.Detail_ClassName+'>.Create(True);  ');
        Add('   F'+FARDefine.Detail_PropName+'.OwnsObjects := True;               ');
        Add('');
     end;

     for i := 0 to FDataSet.Fields.Count - 1 do begin
        CFN := FDataSet.Fields[i].FieldName;
        if FDataSet.Fields[i].Required then TextRequired := 'True '
                                       else TextRequired := 'False';
        case FDataSet.Fields[i].DataType of
           ftADT        :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateADTField       (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftDate       :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateDateField      (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftReference  :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateReferenceField (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftDateTime   :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateDateTimeField  (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftSmallint   :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateSmallIntField  (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftArray      :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateTimeArrayField (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftFloat      :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateFloatField     (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftTimeStamp  :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateTimeStampField (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftAutoInc    :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateAutoIncField   (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftFixedChar  ,
           ftString     :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateStringField    (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftFMTBCD     :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateFMTBCDField    (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftBCD        :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateBCDField       (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftGraphic    :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateGraphicField   (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftTime       :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateTimeField      (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftTypedBinary:begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateBinaryField    (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           //TBCDField
           ftVarBytes   :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateVarBytesField  (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftBlob       :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateBlobField      (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           //TIDispatchField
           //TTVariantField
           ftBoolean    :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateBooleanField   (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftInteger    :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateIntegerField   (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftWideString :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateWideStringField(FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftBytes      :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateBytesField     (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           //TInterfaceField
           ftWord       :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateWordField      (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftCurrency   :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateCurrencyField  (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftLargeInt   :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateLargeIntField  (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftDataSet    :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateDataSetField   (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftMemo       :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateMemoField      (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftWideMemo   :begin
              Add('   '+RFill('F'+CFN, F+1)+' := CreateWideMemoField  (FDataSet, '''+RFill(CFN+'''', F+1)+', '+LFill(IntToStr(FDataSet.Fields[i].Size), 4)+', '+TextRequired+');   Fields.Add('''+RFill(CFN+'''', F+1)+', '+RFill('F'+CFN, F+2)+');');
           end;
           ftUnknown    :RaiseException('TDBIntegrity.AddCurrentValue: Field DataType = ftUnknown'); // Unknown or undetermined
           ftFmtMemo    ,                                                                            // Formatted text memo field
           ftParadoxOle ,                                                                            // Paradox OLE field
           ftDBaseOle   ,                                                                            // dBASE OLE field
           ftCursor                                                                                  // Output cursor from an Oracle stored procedure (TParam only)
                 :RaiseException('TDBIntegrity.AddCurrentValue: Field DataType not Valid for a Primary Key');
           else RaiseException('TDBIntegrity.AddCurrentValue: Field DataType Unknown but not fkUnknown');
        end;
     end;
     Add('   FDataSet.CreateDataSet;   ');
     Add('end;');
     Add('');
     Add('function T'+FARDefine.SingularName+'AR.Clone: T'+FARDefine.SingularName+'AR;');
     if FARDefine.WithDetail then begin
        Add('var Member :'+FARDefine.Detail_ClassName+';    ');
     end;
     Add('begin');
     Add('   Result := T'+FARDefine.SingularName+'AR.Create(DisplayFormats);          ');
     Add('   CustomClone(Self, Result);                                          ');
     if FARDefine.WithDetail then begin
        Add('                                                                ');
        Add('   for Member in '+FARDefine.Detail_PropName+' do begin        ');
        Add('      Result.'+FARDefine.Detail_PropName+'.Add(Member.Clone);  ');
        Add('   end;                                                         ');
     end;
     Add('end;');
     Add('');
     Add('end.');
   end;
end;

end.
