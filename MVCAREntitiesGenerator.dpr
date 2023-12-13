program MVCAREntitiesGenerator;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Main},
  UtilsU in 'UtilsU.pas',
  ARGeneratorController in 'ARGeneratorController.pas',
  EditTable in 'EditTable.pas' {EditTableForm},
  EditField in 'EditField.pas' {EditFieldForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TEditTableForm, EditTableForm);
  Application.CreateForm(TEditFieldForm, EditFieldForm);
  Application.Run;
end.
