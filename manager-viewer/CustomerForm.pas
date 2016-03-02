unit CustomerForm;

interface

uses
  Generics.Collections, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Aurelius.Engine.ObjectManager,
  Entities;

type
  TfmCustomer = class(TForm)
    Label1: TLabel;
    edId: TEdit;
    Label2: TLabel;
    edName: TEdit;
    Label3: TLabel;
    cbCountry: TComboBox;
    procedure edIdChange(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure cbCountryChange(Sender: TObject);
  private
    FCustomer: TCustomer;
    FObjects: TList<TObject>;
    FUpdating: Boolean;
    procedure UpdateCountries;
    procedure SetCustomer(const Value: TCustomer);
    property Customer: TCustomer read FCustomer write SetCustomer;
    property Objects: TList<TObject> read FObjects write FObjects;
  public
    class procedure Edit(Customer: TCustomer; Objects: TList<TObject>);
  end;

var
  fmCustomer: TfmCustomer;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfmCustomer.cbCountryChange(Sender: TObject);
begin
  if not FUpdating and (Customer <> nil) then
  begin
    if cbCountry.ItemIndex >= 0 then
      Customer.Country := TCountry(cbCountry.Items.Objects[cbCountry.ItemIndex])
    else
      Customer.Country := nil;
  end;
end;

procedure TfmCustomer.edIdChange(Sender: TObject);
var
  Value: Integer;
begin
  if not FUpdating and (Customer <> nil) and TryStrToInt(edId.Text, Value) then
    Customer.Id := Value;
end;

class procedure TfmCustomer.Edit(Customer: TCustomer; Objects: TList<TObject>);
begin
  fmCustomer.Objects := Objects;
  fmCustomer.Customer := Customer;
  fmCustomer.ShowModal;
end;

procedure TfmCustomer.edNameChange(Sender: TObject);
begin
  if not FUpdating and (Customer <> nil) then
    Customer.Name := edName.Text;
end;

procedure TfmCustomer.SetCustomer(const Value: TCustomer);
begin
  FUpdating := True;
  FCustomer := Value;
  edId.Text := Value.Id.ToString;
  edName.Text := Value.Name;
  UpdateCountries;
  cbCountry.ItemIndex := cbCountry.Items.IndexOfObject(Value.Country);
  FUpdating := False;
end;

procedure TfmCustomer.UpdateCountries;
var
  Obj: TObject;
begin
  cbCountry.Clear;
  cbCountry.AddItem('(nil)', nil);
  if Assigned(FObjects) then
    for Obj in FObjects do
      if Obj is TCountry then
        cbCountry.AddItem(Format('%s (%s)',
          [TCountry(Obj).Name, IntToHex(IntPtr(Obj), SizeOf(Pointer) * 2)]
        ), Obj);
end;

end.
