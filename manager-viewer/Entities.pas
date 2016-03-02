unit Entities;

interface

uses
  Aurelius.Mapping.Attributes;

type
  [Entity, Automapping]
  TCountry = class
  private
    FId: Integer;
    FName: string;
  public
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
  end;

  [Entity, Automapping]
  TCustomer = class
  private
    FId: Integer;
    FName: string;
    FCountry: TCountry;
  public
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property Country: TCountry read FCountry write FCountry;
  end;

implementation

initialization
  RegisterEntity(TCustomer);
  RegisterEntity(TCountry);
end.
