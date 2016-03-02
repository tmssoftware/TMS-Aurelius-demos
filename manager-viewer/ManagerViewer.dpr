program ManagerViewer;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form3},
  SQLiteConnectionModule in 'SQLiteConnectionModule.pas' {SQLiteConnection: TDataModule},
  Entities in 'Entities.pas',
  CustomerForm in 'CustomerForm.pas' {fmCustomer},
  CountryForm in 'CountryForm.pas' {fmCountry},
  ManagerViewerController in 'ManagerViewerController.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfmCustomer, fmCustomer);
  Application.CreateForm(TfmCountry, fmCountry);
  Application.Run;
end.
