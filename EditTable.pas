unit EditTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TEditTableForm = class(TForm)
    Label1: TLabel;
    LabelTableName: TLabel;
    Label3: TLabel;
    EditClassName: TEdit;
    BtnCancel: TBitBtn;
    BtnOK: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    function GetClassName:string;
    procedure SetTableName(Value :string);
    procedure SetClassName(Value :string);
  public
    property TableName :string                   write SetTableName;
    property ClassName :string read GetClassName write SetClassName;
  end;

var
  EditTableForm: TEditTableForm;

implementation

{$R *.dfm}

procedure TEditTableForm.FormShow(Sender: TObject);
begin
   EditClassName.SetFocus;
end;

function TEditTableForm.GetClassName:string;
begin
   Result := EditClassName.Text;
end;

procedure TEditTableForm.SetClassName(Value: string);
begin
   EditClassName.Text := Value;
end;

procedure TEditTableForm.SetTableName(Value: string);
begin
   LabelTableName.Caption := Value;
end;

end.
