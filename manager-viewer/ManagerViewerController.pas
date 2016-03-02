unit ManagerViewerController;

interface

uses
  Generics.Collections, System.Classes, System.SysUtils, atDiagram,
  Aurelius.Engine.ObjectManager,
  UMLBlocks;

type
  TManagerViewerController = class
  private
    FDiagramTransient: TatDiagram;
    FDiagramManager: TatDiagram;
    FManager: TObjectManager;
    FObjects: TObjectList<TObject>;
    FOnBlockCreated: TProc<TCustomDiagramBlock>;
    function SelectedInDiagram(Diagram: TatDiagram): TObject;
    function GetSelected: TObject;
    function FindBlock(Diagram: TatDiagram; Obj: TObject): TUMLObjectBlock;
    function CreateBlock(Diagram: TatDiagram; Obj: TObject; RefBlock: TUMLObjectBlock): TUMLObjectBlock;
    procedure UpdateBlocks(Diagram: TatDiagram);
    procedure UpdateBlock(Block: TUMLObjectBlock);
    function GetObjects: TList<TObject>;
  public
    constructor Create(AManager: TObjectManager; ADiagramTransient, ADiagramManager: TatDiagram);
    destructor Destroy; override;
    property Objects: TList<TObject> read GetObjects;
    property DiagramTransient: TatDiagram read FDiagramTransient;
    property DiagramManager: TatDiagram read FDiagramManager;
    property Manager: TObjectManager read FManager;
    property Selected: TObject read GetSelected;
  public
    procedure AddManagedObjectsToTransientList;
    procedure RemoveManagedObjectsFromTransientList;
    procedure UpdateDiagrams;
    property OnBlockCreated: TProc<TCustomDiagramBlock> read FOnBlockCreated write FOnBlockCreated;
  end;

implementation

uses
  DiagramUtils,
  Aurelius.Global.Utils,
  Aurelius.Mapping.Explorer,
  Aurelius.Mapping.Optimization;

type
  TIntManager = class(TObjectManager)
  public
    function ObjList: TList<TObject>;
  end;

function TIntManager.ObjList: TList<TObject>;
begin
  Result := ObjectMap.GetList;
end;

{ TManagerViewerController }

procedure TManagerViewerController.AddManagedObjectsToTransientList;
var
  Obj: TObject;
begin
  // Add Manager objects to the Objects list so that list will contain all objects
  // we're manipulating
  for Obj in TIntManager(Manager).ObjList do
    if not Objects.Contains(Obj) then
      Objects.Add(Obj);
end;

constructor TManagerViewerController.Create(AManager: TObjectManager;
  ADiagramTransient, ADiagramManager: TatDiagram);
begin
  FManager := AManager;
  FDiagramTransient := ADiagramTransient;
  FDiagramManager := ADiagramManager;
  FObjects := TObjectList<TObject>.Create(False);
end;

function TManagerViewerController.CreateBlock(Diagram: TatDiagram; Obj: TObject;
  RefBlock: TUMLObjectBlock): TUMLObjectBlock;
const
  _Margin = 10;

  function Overlaps(Block: TUMLObjectBlock): Boolean;
  var
    I: integer;
  begin
    for I := 0 to Diagram.BlockCount - 1 do
      if Diagram.Blocks[I] <> Block then
        if RectsTouch(Diagram.Blocks[I].BoundsRect, Block.BoundsRect) then
          Exit(True);
    Result := False;
  end;

var
  Block: TUMLObjectBlock;
begin
  Block := TUMLObjectBlock.Create(Diagram.Owner);
  Block.Obj := Obj;
  Block.Diagram := Diagram;
  Block.Left := _Margin;
  Block.Top := _Margin;

  // When a block is "moved" from one diagram to another (evict, save, etc.)
  // try to keep block in the same position as it was in the other diagram
  if RefBlock <> nil then
  begin
    Block.Left := RefBlock.Left;
    Block.Top := RefBlock.Top;
  end;
  UpdateBlock(Block);

  // Avoid overlap
  while Overlaps(Block) do
  begin
    Block.Left := Block.Left + Block.Width + _Margin;
    if Block.Right > Diagram.Width then
    begin
      Block.Left := _Margin;
      Block.Top := Block.Top + Block.Height + _Margin;
    end;
  end;

  if Assigned(FOnBlockCreated) then
    FOnBlockCreated(Block);

  Result := Block;
end;

destructor TManagerViewerController.Destroy;
begin
  RemoveManagedObjectsFromTransientList;
  FObjects.OwnsObjects := True; // destroy remaining objects
  FObjects.Free;
  inherited;
end;

function TManagerViewerController.FindBlock(Diagram: TatDiagram;
  Obj: TObject): TUMLObjectBlock;
var
  I: Integer;
begin
  for I := 0 to Diagram.BlockCount - 1 do
    if (Diagram.Blocks[I].Obj = Obj) and (Diagram.Blocks[I] is TUMLObjectBlock) then
      Exit(TUMLObjectBlock(Diagram.Blocks[I]));
  Result := nil;
end;


function TManagerViewerController.GetObjects: TList<TObject>;
begin
  Result := FObjects;
end;

function TManagerViewerController.GetSelected: TObject;
begin
  Result := SelectedInDiagram(DiagramTransient);
  if Result = nil then
    Result := SelectedInDiagram(DiagramManager);
end;

procedure TManagerViewerController.RemoveManagedObjectsFromTransientList;
var
  I: Integer;
begin
  for I := Objects.Count - 1 downto 0 do
    if Manager.IsAttached(Objects[I]) then
      Objects.Delete(I);
end;

function TManagerViewerController.SelectedInDiagram(
  Diagram: TatDiagram): TObject;
begin
  Result := nil;
  if (Diagram.SelectedCount > 0) and
    (Diagram.Selecteds[0].Obj <> nil) then
    Result := Diagram.Selecteds[0].Obj;
end;

procedure TManagerViewerController.UpdateBlock(Block: TUMLObjectBlock);
var
  J: Integer;
  Obj: TObject;
  Info: TRttiOptimization;
  Attr: TUMLAttribute;
  E: TMappingExplorer;
  Value: string;
begin
  Obj := Block.Obj;
  if Obj = nil then Exit;

  Block.UMLClassName := Obj.ClassName;
  Block.UMLObjectName := IntToHex(IntPtr(Obj), SizeOf(Pointer) * 2);
  Block.Attributes.Clear;

  E := TMappingExplorer.Default;
  for Info in E.GetClassVisibleMembers(Obj.ClassType, True) do
  begin
    Attr := Block.Attributes.Add;
    if Info.MemberClass = nil then // it's a primitive type, not an object
      Value := TUtils.VariantToString(E.ValueToVariant(E.GetMemberValue(Obj, Info), Info))
    else
    begin
      Value := IntToHex(IntPtr(E.GetMemberValue(Obj, Info).AsObject), SizeOf(Pointer) * 2);
      if Value = '00000000' then Value := 'nil';
    end;

    Attr.CustomText := Format('%s = %s', [Info.MemberName, Value]);
  end;

  for J := 0 to Block.TextCells.Count - 1 do
    Block.TextCells[J].CellFrame.AutoFrameMargin := 5;
end;

procedure TManagerViewerController.UpdateBlocks(Diagram: TatDiagram);
var
  I: Integer;
begin
  for I := 0 to Diagram.BlockCount - 1 do
    if (Diagram.Blocks[I] is TUMLObjectBlock) then
      UpdateBlock(TUMLObjectBlock(Diagram.Blocks[I]));
end;

procedure TManagerViewerController.UpdateDiagrams;
var
  Obj: TObject;
  Block: TCustomDiagramBlock;
  I: Integer;
begin
  // Create missing blocks in manager diagram
  for Obj in TIntManager(Manager).ObjList do
  begin
    Block := FindBlock(DiagramManager, Obj);
    if Block = nil then
      CreateBlock(DiagramManager, Obj, FindBlock(DiagramTransient, Obj));
  end;

  // Create missing blocks in transient diagram
  for Obj in Objects do
    if not Manager.IsAttached(Obj) then
    begin
      Block := FindBlock(DiagramTransient, Obj);
      if Block = nil then
        CreateBlock(DiagramTransient, Obj, FindBlock(DiagramManager, Obj));
    end;

  // Remove unused blocks from transient diagram
  for I := DiagramTransient.BlockCount - 1 downto 0 do
  begin
    Block := DiagramTransient.Blocks[I];
    if (Block.Obj = nil) or Manager.IsAttached(Block.Obj) or not Objects.Contains(Block.Obj) then
      Block.Free;
  end;

  // Remove unused blocks from manager diagram
  for I := DiagramManager.BlockCount - 1 downto 0 do
  begin
    Block := DiagramManager.Blocks[I];
    if (Block.Obj = nil) or not TIntManager(Manager).ObjList.Contains(Block.Obj) then
      Block.Free;
  end;

  UpdateBlocks(DiagramManager);
  UpdateBlocks(DiagramTransient);
end;

end.
