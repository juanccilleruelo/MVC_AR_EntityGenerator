unit EditField;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TEditFieldForm = class(TForm)
    Label1: TLabel;
    LabelTableName: TLabel;
    Label3: TLabel;
    EditCustomName: TEdit;
    BtnCancel: TBitBtn;
    BtnOK: TBitBtn;
    Label2: TLabel;
    LabelFieldName: TLabel;
    procedure FormShow(Sender: TObject);
  private
    procedure SetTableName(Value :string);
    procedure SetFieldName(Value :string);
    procedure SetCustomName(Value :string);
    function GetCustomName:string;
  public
    property TableName  :string                    write SetTableName;
    property FieldName  :string                    write SetFieldName;
    property CustomName :string read GetCustomName write SetCustomName;
  end;

var
  EditFieldForm: TEditFieldForm;

implementation

{$R *.dfm}

procedure TEditFieldForm.FormShow(Sender: TObject);
begin
   EditCustomName.SetFocus;
end;

procedure TEditFieldForm.SetTableName(Value: string);
begin
   LabelTableName.Caption := Value;
end;

procedure TEditFieldForm.SetFieldName(Value: string);
begin
   LabelFieldName.Caption := Value;
end;

procedure TEditFieldForm.SetCustomName(Value: string);
begin
   EditCustomName.Text := Value;
end;

function TEditFieldForm.GetCustomName: string;
begin
   Result := EditCustomName.Text;
end;

end.
