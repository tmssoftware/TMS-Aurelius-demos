unit CountryForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Entities;

type
  TfmCountry = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edId: TEdit;
    edName: TEdit;
    procedure edIdChange(Sender: TObject);
    procedure edNameChange(Sender: TObject);
  private
    FCountry: TCountry;
    FUpdating: Boolean;
    procedure SetCountry(const Value: TCountry);
    property Country: TCountry read FCountry write SetCountry;
  public
    class procedure Edit(Country: TCountry); static;
  end;

var
  fmCountry: TfmCountry;

implementation

{$R *.dfm}

procedure TfmCountry.edIdChange(Sender: TObject);
var
  Value: Integer;
begin
  if not FUpdating and (Country <> nil) and TryStrToInt(edId.Text, Value) then
    Country.Id := Value;
end;

procedure TfmCountry.edNameChange(Sender: TObject);
begin
  if not FUpdating and (Country <> nil) then
    Country.Name := edName.Text;
end;

class procedure TfmCountry.Edit(Country: TCountry);
begin
  fmCountry.Country := Country;
  fmCountry.ShowModal;
end;

procedure TfmCountry.SetCountry(const Value: TCountry);
begin
  FUpdating := True;
  FCountry := Value;
  edId.Text := Value.Id.ToString;
  edName.Text := Value.Name;
  FUpdating := False;
end;

end.
