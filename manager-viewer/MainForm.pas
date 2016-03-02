unit MainForm;

interface

uses
  Generics.Collections, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Aurelius.Bind.Dataset,
  atDiagram, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Entities,
  Aurelius.Engine.ObjectManager,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Drivers.Interfaces,
  Aurelius.Commands.Listeners,
  Aurelius.Mapping.Attributes,
  ManagerViewerController,
  SQLiteConnectionModule, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus;

type
  TfmMain = class(TForm, ICommandExecutionListener)
    dsCustomer: TDataSource;
    adsCustomer: TAureliusDataset;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    btCreateCustomer: TButton;
    btCreateCountry: TButton;
    btSave: TButton;
    ActionList1: TActionList;
    acSave: TAction;
    acUpdate: TAction;
    acRemove: TAction;
    acMerge: TAction;
    acEvict: TAction;
    acRefresh: TAction;
    acFlush: TAction;
    acSaveOrUpdate: TAction;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button5: TButton;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    DBGrid2: TDBGrid;
    Panel2: TPanel;
    dsCountry: TDataSource;
    adsCountry: TAureliusDataset;
    acFindCustomersByCountry: TButton;
    edLike: TEdit;
    btRefreshDatasets: TButton;
    adsCountryId: TIntegerField;
    adsCountryName: TStringField;
    adsCustomerId: TIntegerField;
    adsCustomerName: TStringField;
    Button1: TButton;
    adsCustomerCountry: TAureliusEntityField;
    adsCountrySelf: TAureliusEntityField;
    adsCustomerCountryName: TStringField;
    btFindAll: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    DiagramTransient: TatDiagram;
    DiagramManager: TatDiagram;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Splitter3: TSplitter;
    lbCommands: TListBox;
    acClear: TAction;
    PopupMenu1: TPopupMenu;
    Save1: TMenuItem;
    Update1: TMenuItem;
    Merge1: TMenuItem;
    Refresh1: TMenuItem;
    Remove1: TMenuItem;
    SaveOrUpdate1: TMenuItem;
    Evict1: TMenuItem;
    GroupBox1: TGroupBox;
    chSaveUpdate: TCheckBox;
    chMerge: TCheckBox;
    chEvict: TCheckBox;
    chRefresh: TCheckBox;
    chRemove: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCreateCustomerClick(Sender: TObject);
    procedure btCreateCountryClick(Sender: TObject);
    procedure DiagramTransientDControlDblClick(Sender: TObject;
      ADControl: TDiagramControl);
    procedure EntityActionUpdate(Sender: TObject);
    procedure DiagramTransientSelectDControl(Sender: TObject;
      ADControl: TDiagramControl);
    procedure acSaveExecute(Sender: TObject);
    procedure acUpdateExecute(Sender: TObject);
    procedure acRemoveExecute(Sender: TObject);
    procedure acMergeExecute(Sender: TObject);
    procedure acEvictExecute(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure acSaveOrUpdateExecute(Sender: TObject);
    procedure acFlushExecute(Sender: TObject);
    procedure acFindCustomersByCountryClick(Sender: TObject);
    procedure btRefreshDatasetsClick(Sender: TObject);
    procedure btFindAllClick(Sender: TObject);
    procedure acClearExecute(Sender: TObject);
    procedure chSaveUpdateClick(Sender: TObject);
    procedure chMergeClick(Sender: TObject);
    procedure chEvictClick(Sender: TObject);
    procedure chRefreshClick(Sender: TObject);
    procedure chRemoveClick(Sender: TObject);
  private
    procedure ToggleCascade(CascadeType: TCascadeType; Include: Boolean);
  private
    { ICommandExecutionListener }
    procedure ExecutingCommand(SQL: string; Params: TEnumerable<TDBParam>);
  private
    Connection: IDBConnection;
    Manager: TObjectManager;
    DatasetsManager: TObjectManager;
    Controller: TManagerViewerController;
  public
  end;

var
  fmMain: TfmMain;

implementation

uses
  Aurelius.Criteria.Base,
  Aurelius.Criteria.Linq,
  Aurelius.Mapping.Explorer,
  Aurelius.Mapping.Metadata,
  CustomerForm, CountryForm;

{$R *.dfm}

procedure TfmMain.acClearExecute(Sender: TObject);
begin
  // Remove objects from list that are not in manager,
  // so there are not references to destroyed objects
  // move this to the controller, later
  Controller.RemoveManagedObjectsFromTransientList;

  Manager.Clear;
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acEvictExecute(Sender: TObject);
begin
  // Add Manager objects to the list so when evicted, they will be there
  Controller.AddManagedObjectsToTransientList;

  Manager.Evict(Controller.Selected);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acFlushExecute(Sender: TObject);
begin
  Manager.Flush;
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acMergeExecute(Sender: TObject);
begin
  Manager.Merge<TObject>(Controller.Selected);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acRefreshExecute(Sender: TObject);
begin
  Manager.Refresh(Controller.Selected);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acRemoveExecute(Sender: TObject);
begin
  // Remove objects from list that are not in manager,
  // so there are not references to destroyed objects
  // move this to the controller, later
  Controller.RemoveManagedObjectsFromTransientList;

  Manager.Remove(Controller.Selected);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acSaveExecute(Sender: TObject);
begin
  Manager.Save(Controller.Selected);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acSaveOrUpdateExecute(Sender: TObject);
begin
  Manager.SaveOrUpdate(Controller.Selected);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.acUpdateExecute(Sender: TObject);
begin
  Manager.Update(Controller.Selected);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.btCreateCountryClick(Sender: TObject);
begin
  Controller.Objects.Add(TCountry.Create);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.btCreateCustomerClick(Sender: TObject);
begin
  Controller.Objects.Add(TCustomer.Create);
  Controller.UpdateDiagrams;
end;

procedure TfmMain.btFindAllClick(Sender: TObject);
begin
  Manager.Find<TCustomer>.List.Free;
  Manager.Find<TCountry>.List.Free;
  Controller.UpdateDiagrams;
end;

procedure TfmMain.btRefreshDatasetsClick(Sender: TObject);
begin
  adsCountry.Close;
  adsCustomer.Close;
  DatasetsManager.Clear;

  adsCountry.Manager := DatasetsManager;
  adsCountry.SetSourceCriteria(adsCountry.Manager.Find<TCountry>);
  adsCountry.Open;

  adsCustomer.Manager := DatasetsManager;
  adsCustomer.SetSourceCriteria(adsCustomer.Manager.Find<TCustomer>);
  adsCustomer.Open;
end;

procedure TfmMain.chEvictClick(Sender: TObject);
begin
  ToggleCascade(TCascadeType.Evict, chEvict.Checked);
end;

procedure TfmMain.chMergeClick(Sender: TObject);
begin
  ToggleCascade(TCascadeType.Merge, chMerge.Checked);
end;

procedure TfmMain.chRefreshClick(Sender: TObject);
begin
  ToggleCascade(TCascadeType.Refresh, chRefresh.Checked);
end;

procedure TfmMain.chRemoveClick(Sender: TObject);
begin
  ToggleCascade(TCascadeType.Remove, chRemove.Checked);
end;

procedure TfmMain.chSaveUpdateClick(Sender: TObject);
begin
  ToggleCascade(TCascadeType.SaveUpdate, chSaveUpdate.Checked);
end;

procedure TfmMain.acFindCustomersByCountryClick(Sender: TObject);
var
  Criteria: TCriteria;
begin
  Criteria := Manager.Find<TCustomer>;
  if edLike.Text <> '' then
    Criteria.Add(TLinq.Contains('Name', edLike.Text));

  Criteria.List<TCustomer>.Free;
  Controller.UpdateDiagrams;
end;

procedure TfmMain.DiagramTransientDControlDblClick(Sender: TObject;
  ADControl: TDiagramControl);
begin
  if ADControl.Obj is TCustomer then
  begin
    Controller.AddManagedObjectsToTransientList;
    TfmCustomer.Edit(TCustomer(ADControl.Obj), Controller.Objects);
    Controller.UpdateDiagrams;
  end;
  if ADControl.Obj is TCountry then
  begin
    TfmCountry.Edit(TCountry(ADControl.Obj));
    Controller.UpdateDiagrams;
  end;
end;

procedure TfmMain.DiagramTransientSelectDControl(Sender: TObject;
  ADControl: TDiagramControl);
begin
  // Make sure only only one object is selected considering the two diagrams
  if ADControl.Diagram = DiagramTransient then
    DiagramManager.UnselectAll
  else
    DiagramTransient.UnselectAll;
end;

procedure TfmMain.EntityActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (Controller.Selected <> nil);
end;

procedure TfmMain.ExecutingCommand(SQL: string; Params: TEnumerable<TDBParam>);
var
  P: TDBParam;
  ValueAsString: string;
begin
  // quick and dirty sql beautifier
  if Params <> nil then
    for P in Params do
    begin
      if P.ParamValue = NULL then
        ValueAsString := 'NULL'
      else
        ValueAsString := '"' + VarToStr(P.ParamValue) + '"';
      SQL := SQL + '; ' + P.ParamName + ' = ' + ValueAsString;
    end;
  SQL := StringReplace(SQL, #13, ' ', [rfReplaceAll]);
  SQL := StringReplace(SQL, #10, ' ', [rfReplaceAll]);
  SQL := StringReplace(SQL, '  ', ' ', [rfReplaceAll]);
  SQL := StringReplace(SQL, '  ', ' ', [rfReplaceAll]);

  lbCommands.ItemIndex := lbCommands.Items.Add(SQL);
end;

procedure TfmMain.ToggleCascade(CascadeType: TCascadeType; Include: Boolean);
var
  A: TAssociation;
begin
  // This is just for learning purposes. Be careful when changing mapping after application is
  // already up and running with managers and entities floating around
  A := TMappingExplorer.Default.GetAssociationByPropertyName(TCustomer, 'FCountry');
  if Include then
    A.Cascade := A.Cascade + [CascadeType]
  else
    A.Cascade := A.Cascade - [CascadeType];
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  A: TAssociation;
begin
  // create the database connection and create missing tables and columns
  Connection := TSQLiteConnection.CreateConnection;
  TDatabaseManager.Update(Connection);

  // create the manager to be "viewed"
  Manager := TObjectManager.Create(Connection);
  Manager.AddCommandListener(Self);

  // create a separated manager for the datasets
  DatasetsManager := TObjectManager.Create(Connection);

  // set some visual parameters for the diagram
  DiagramTransient.ShowLinkPoints := False;
  DiagramTransient.HandlesStyle := TDiagramHandlesStyle.hsVisio;
  DiagramTransient.DragStyle := TDiagramDragStyle.dsShape;
  DiagramManager.ShowLinkPoints := False;
  DiagramManager.HandlesStyle := TDiagramHandlesStyle.hsVisio;
  DiagramManager.DragStyle := TDiagramDragStyle.dsShape;

  // create the controller for the manager viewer
  Controller := TManagerViewerController.Create(Manager, DiagramTransient, DiagramManager);
  Controller.OnBlockCreated :=
    procedure(Block: TCustomDiagramBlock)
    begin
      if Block.Obj is TCustomer then
        Block.Color := clCream;
      Block.SelColor := Block.Color;
    end;

  // Check/Uncheck the cascade checkboxes according to the cascade status
  // Just in case you change the mapping of TCustomer.FCountry in Entities unit
  // so the check boxes will automatically reflect that change
  A := TMappingExplorer.Default.GetAssociationByPropertyName(TCustomer, 'FCountry');
  chSaveUpdate.Checked := TCascadeType.SaveUpdate in A.Cascade;
  chMerge.Checked := TCascadeType.Merge in A.Cascade;
  chEvict.Checked := TCascadeType.Evict in A.Cascade;
  chRefresh.Checked := TCascadeType.Refresh in A.Cascade;
  chRemove.Checked := TCascadeType.Remove in A.Cascade;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Controller.Free;
  adsCustomer.Close;
  adsCountry.Close;
  Manager.Free;
  DatasetsManager.Free;
end;

end.
