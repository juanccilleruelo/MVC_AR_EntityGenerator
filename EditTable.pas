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
    Label2: TLabel;
    EditDeployPath: TEdit;
    SelectFolder: TFileOpenDialog;
    BtnSelectDeployPath: TButton;
    procedure FormShow(Sender: TObject);
    procedure BtnSelectDeployPathClick(Sender: TObject);
  private
    function GetClassName:string;
    procedure SetTableName(Value :string);
    procedure SetClassName(Value :string);
    function GetDeployPath:string;
    procedure SetDeployPath(Value :string);
  public
    property TableName  :string                    write SetTableName;
    property ClassName  :string read GetClassName  write SetClassName;
    property DeployPath :string read GetDeployPath write SetDeployPath;
  end;

var
  EditTableForm: TEditTableForm;

implementation

{$R *.dfm}

procedure TEditTableForm.BtnSelectDeployPathClick(Sender: TObject);
begin
   if SelectFolder.Execute then begin
      DeployPath := SelectFolder.FileName;
   end;
end;

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

function TEditTableForm.GetDeployPath:string;
begin
   Result := EditDeployPath.Text;
end;

procedure TEditTableForm.SetDeployPath(Value :string);
begin
   EditDeployPath.Text := Value;
end;

end.
