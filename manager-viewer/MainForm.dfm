object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'TMS Aurelius - Using TObjectManager'
  ClientHeight = 503
  ClientWidth = 952
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 952
    Height = 503
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Object Manager'
      object Splitter1: TSplitter
        Left = 409
        Top = 66
        Width = 4
        Height = 362
        Color = clSilver
        ParentColor = False
        ExplicitHeight = 409
      end
      object Splitter3: TSplitter
        Left = 0
        Top = 428
        Width = 944
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        Color = clSilver
        ParentColor = False
        ExplicitLeft = 413
        ExplicitTop = 66
        ExplicitWidth = 368
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 944
        Height = 66
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 168
        ExplicitTop = 3
        object btCreateCustomer: TButton
          Left = 4
          Top = 4
          Width = 108
          Height = 25
          Caption = 'TCustomer.Create'
          TabOrder = 0
          OnClick = btCreateCustomerClick
        end
        object btCreateCountry: TButton
          Left = 117
          Top = 4
          Width = 108
          Height = 25
          Caption = 'TCountry.Create'
          TabOrder = 1
          OnClick = btCreateCountryClick
        end
        object btSave: TButton
          Left = 4
          Top = 34
          Width = 60
          Height = 25
          Action = acSave
          TabOrder = 2
        end
        object Button2: TButton
          Left = 70
          Top = 34
          Width = 60
          Height = 25
          Action = acUpdate
          TabOrder = 3
        end
        object Button3: TButton
          Left = 138
          Top = 34
          Width = 60
          Height = 25
          Action = acMerge
          TabOrder = 4
        end
        object Button4: TButton
          Left = 206
          Top = 34
          Width = 60
          Height = 25
          Action = acRefresh
          TabOrder = 5
        end
        object Button6: TButton
          Left = 439
          Top = 34
          Width = 60
          Height = 25
          Action = acEvict
          TabOrder = 6
        end
        object Button7: TButton
          Left = 340
          Top = 34
          Width = 93
          Height = 25
          Action = acSaveOrUpdate
          TabOrder = 7
        end
        object Button8: TButton
          Left = 274
          Top = 34
          Width = 60
          Height = 25
          Action = acRemove
          TabOrder = 8
        end
        object Button5: TButton
          Left = 505
          Top = 34
          Width = 60
          Height = 25
          Action = acFlush
          TabOrder = 9
        end
        object acFindCustomersByCountry: TButton
          Left = 422
          Top = 3
          Width = 224
          Height = 25
          Caption = 'Find Customers With Name Containing:'
          TabOrder = 10
          OnClick = acFindCustomersByCountryClick
        end
        object edLike: TEdit
          Left = 652
          Top = 5
          Width = 121
          Height = 21
          TabOrder = 11
        end
        object Button1: TButton
          Left = 571
          Top = 35
          Width = 60
          Height = 25
          Action = acClear
          TabOrder = 12
        end
        object btFindAll: TButton
          Left = 340
          Top = 3
          Width = 79
          Height = 25
          Caption = 'Find All '
          TabOrder = 13
          OnClick = btFindAllClick
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 66
        Width = 409
        Height = 362
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 1
        ExplicitHeight = 409
        object DiagramTransient: TatDiagram
          Left = 0
          Top = 21
          Width = 409
          Height = 341
          NettoExportOffset = 3
          AutomaticNodes = False
          AutoScroll = True
          AutoPage = False
          Background.Scroll = True
          Background.Style = biTile
          Background.Visible = False
          Background.Gradient.Direction = grTopBottom
          Background.Gradient.StartColor = clWhite
          Background.Gradient.EndColor = clYellow
          Background.Gradient.Visible = False
          Background.PrintGradient = False
          SnapGrid.Active = False
          SnapGrid.Force = False
          SnapGrid.Visible = False
          SnapGrid.SizeX = 8.000000000000000000
          SnapGrid.SizeY = 8.000000000000000000
          SnapGrid.Style = gsDots
          SnapGrid.SnapToRuler = False
          ShowLinkPoints = True
          LeftRuler.Visible = False
          LeftRuler.Divisions = 5
          LeftRuler.Font.Charset = DEFAULT_CHARSET
          LeftRuler.Font.Color = clWindowText
          LeftRuler.Font.Height = -9
          LeftRuler.Font.Name = 'Arial'
          LeftRuler.Font.Style = []
          LeftRuler.Units = unCenti
          LeftRuler.MinorTickLength = 4
          LeftRuler.MajorTickLength = 6
          LeftRuler.Color = clWhite
          LeftRuler.TickColor = clBlack
          LeftRuler.Size = 16
          LeftRuler.AutoFactor = True
          LeftRuler.GridColor = clBlack
          TopRuler.Visible = False
          TopRuler.Divisions = 5
          TopRuler.Font.Charset = DEFAULT_CHARSET
          TopRuler.Font.Color = clWindowText
          TopRuler.Font.Height = -9
          TopRuler.Font.Name = 'Arial'
          TopRuler.Font.Style = []
          TopRuler.Units = unCenti
          TopRuler.MinorTickLength = 4
          TopRuler.MajorTickLength = 6
          TopRuler.Color = clWhite
          TopRuler.TickColor = clBlack
          TopRuler.Size = 16
          TopRuler.AutoFactor = True
          TopRuler.GridColor = clBlack
          Zoom = 100
          BorderColor = clGray
          MouseWheelMode = mwOff
          ActiveLayers = 0
          Layers = <>
          LinkCursor = crHandPoint
          PanCursor = crHandPoint
          ZoomCursor = crDefault
          IgnoreScreenDPI = False
          ShowCrossIndicators = False
          PageLines.Visible = False
          PageLines.Pen.Style = psDot
          KeyActions = [kaEscape, kaMove, kaPage, kaResize, kaSelect]
          HandlesStyle = hsClassic
          SmoothMode = smAntiAlias
          TextRenderingMode = tmAntiAlias
          SelectionMode = slmMultiple
          CanMoveOutOfBounds = True
          PageSettings.PaperName = 'A4'
          PageSettings.PaperId = 9
          PageSettings.PaperWidth = 209.973333333333300000
          PageSettings.PaperHeight = 297.010666666666700000
          PageSettings.Orientation = dpoPortrait
          PageSettings.LeftMarginStr = '25.4'
          PageSettings.TopMarginStr = '25.4'
          PageSettings.RightMarginStr = '25.4'
          PageSettings.BottomMarginStr = '25.4'
          RulerAutoUnit = False
          MeasUnit = duCenti
          WheelZoom = False
          WheelZoomIncrement = 10
          WheelZoomMin = 10
          WheelZoomMax = 500
          OnSelectDControl = DiagramTransientSelectDControl
          OnDControlDblClick = DiagramTransientDControlDblClick
          Align = alClient
          Anchors = [akLeft, akTop, akRight, akBottom]
          BiDiMode = bdLeftToRight
          BorderStyle = bsNone
          ShowHint = False
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 409
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Transient Objects'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
      end
      object Panel4: TPanel
        Left = 413
        Top = 66
        Width = 531
        Height = 362
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitLeft = -55
        ExplicitTop = 65
        ExplicitWidth = 185
        ExplicitHeight = 409
        object DiagramManager: TatDiagram
          Left = 0
          Top = 21
          Width = 531
          Height = 341
          NettoExportOffset = 3
          AutomaticNodes = False
          AutoScroll = True
          AutoPage = False
          Background.Scroll = True
          Background.Style = biTile
          Background.Visible = False
          Background.Gradient.Direction = grTopBottom
          Background.Gradient.StartColor = clWhite
          Background.Gradient.EndColor = clYellow
          Background.Gradient.Visible = False
          Background.PrintGradient = False
          SnapGrid.Active = False
          SnapGrid.Force = False
          SnapGrid.Visible = False
          SnapGrid.SizeX = 8.000000000000000000
          SnapGrid.SizeY = 8.000000000000000000
          SnapGrid.Style = gsDots
          SnapGrid.SnapToRuler = False
          ShowLinkPoints = True
          LeftRuler.Visible = False
          LeftRuler.Divisions = 5
          LeftRuler.Font.Charset = DEFAULT_CHARSET
          LeftRuler.Font.Color = clWindowText
          LeftRuler.Font.Height = -9
          LeftRuler.Font.Name = 'Arial'
          LeftRuler.Font.Style = []
          LeftRuler.Units = unCenti
          LeftRuler.MinorTickLength = 4
          LeftRuler.MajorTickLength = 6
          LeftRuler.Color = clWhite
          LeftRuler.TickColor = clBlack
          LeftRuler.Size = 16
          LeftRuler.AutoFactor = True
          LeftRuler.GridColor = clBlack
          TopRuler.Visible = False
          TopRuler.Divisions = 5
          TopRuler.Font.Charset = DEFAULT_CHARSET
          TopRuler.Font.Color = clWindowText
          TopRuler.Font.Height = -9
          TopRuler.Font.Name = 'Arial'
          TopRuler.Font.Style = []
          TopRuler.Units = unCenti
          TopRuler.MinorTickLength = 4
          TopRuler.MajorTickLength = 6
          TopRuler.Color = clWhite
          TopRuler.TickColor = clBlack
          TopRuler.Size = 16
          TopRuler.AutoFactor = True
          TopRuler.GridColor = clBlack
          Zoom = 100
          BorderColor = clGray
          MouseWheelMode = mwOff
          ActiveLayers = 0
          Layers = <>
          LinkCursor = crHandPoint
          PanCursor = crHandPoint
          ZoomCursor = crDefault
          IgnoreScreenDPI = False
          ShowCrossIndicators = False
          PageLines.Visible = False
          PageLines.Pen.Style = psDot
          KeyActions = [kaEscape, kaMove, kaPage, kaResize, kaSelect]
          HandlesStyle = hsClassic
          SmoothMode = smAntiAlias
          TextRenderingMode = tmAntiAlias
          SelectionMode = slmMultiple
          CanMoveOutOfBounds = True
          PageSettings.PaperName = 'A4'
          PageSettings.PaperId = 9
          PageSettings.PaperWidth = 209.973333333333300000
          PageSettings.PaperHeight = 297.010666666666700000
          PageSettings.Orientation = dpoPortrait
          PageSettings.LeftMarginStr = '25.4'
          PageSettings.TopMarginStr = '25.4'
          PageSettings.RightMarginStr = '25.4'
          PageSettings.BottomMarginStr = '25.4'
          RulerAutoUnit = False
          MeasUnit = duCenti
          WheelZoom = False
          WheelZoomIncrement = 10
          WheelZoomMin = 10
          WheelZoomMax = 500
          OnSelectDControl = DiagramTransientSelectDControl
          OnDControlDblClick = DiagramTransientDControlDblClick
          Align = alClient
          Anchors = [akLeft, akTop, akRight, akBottom]
          BiDiMode = bdLeftToRight
          BorderStyle = bsNone
          ShowHint = False
          TabOrder = 0
        end
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 531
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Managed Objects (TObjectManager)'
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          ExplicitWidth = 532
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 431
        Width = 944
        Height = 44
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        object lbCommands: TListBox
          Left = 0
          Top = 0
          Width = 944
          Height = 44
          Align = alClient
          BorderStyle = bsNone
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Data'
      ImageIndex = 1
      object Splitter2: TSplitter
        Left = 505
        Top = 35
        Height = 440
        ExplicitLeft = 376
        ExplicitTop = 96
        ExplicitHeight = 100
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 35
        Width = 505
        Height = 440
        Align = alLeft
        DataSource = dsCustomer
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object DBGrid2: TDBGrid
        Left = 508
        Top = 35
        Width = 436
        Height = 440
        Align = alClient
        DataSource = dsCountry
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 944
        Height = 35
        Align = alTop
        TabOrder = 2
        object btRefreshDatasets: TButton
          Left = 2
          Top = 5
          Width = 75
          Height = 25
          Caption = 'Refresh'
          TabOrder = 0
          OnClick = btRefreshDatasetsClick
        end
      end
    end
  end
  object dsCustomer: TDataSource
    DataSet = adsCustomer
    Left = 88
    Top = 280
  end
  object adsCustomer: TAureliusDataset
    FieldDefs = <>
    Left = 120
    Top = 224
    object adsCustomerId: TIntegerField
      DisplayWidth = 5
      FieldName = 'Id'
    end
    object adsCustomerName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 255
    end
    object adsCustomerCountry: TAureliusEntityField
      FieldName = 'Country'
      Visible = False
    end
    object adsCustomerCountryName: TStringField
      DisplayLabel = 'Country'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'CountryName'
      LookupDataSet = adsCountry
      LookupKeyFields = 'Self'
      LookupResultField = 'Name'
      KeyFields = 'Country'
      Size = 255
      Lookup = True
    end
  end
  object ActionList1: TActionList
    Left = 160
    Top = 280
    object acSave: TAction
      Caption = 'Save'
      OnExecute = acSaveExecute
      OnUpdate = EntityActionUpdate
    end
    object acUpdate: TAction
      Caption = 'Update'
      OnExecute = acUpdateExecute
      OnUpdate = EntityActionUpdate
    end
    object acRemove: TAction
      Caption = 'Remove'
      OnExecute = acRemoveExecute
      OnUpdate = EntityActionUpdate
    end
    object acMerge: TAction
      Caption = 'Merge'
      OnExecute = acMergeExecute
      OnUpdate = EntityActionUpdate
    end
    object acEvict: TAction
      Caption = 'Evict'
      OnExecute = acEvictExecute
      OnUpdate = EntityActionUpdate
    end
    object acRefresh: TAction
      Caption = 'Refresh'
      OnExecute = acRefreshExecute
      OnUpdate = EntityActionUpdate
    end
    object acSaveOrUpdate: TAction
      Caption = 'SaveOrUpdate'
      OnExecute = acSaveOrUpdateExecute
      OnUpdate = EntityActionUpdate
    end
    object acFlush: TAction
      Caption = 'Flush'
      OnExecute = acFlushExecute
    end
    object acClear: TAction
      Caption = 'Clear'
      OnExecute = acClearExecute
    end
  end
  object dsCountry: TDataSource
    DataSet = adsCountry
    Left = 472
    Top = 256
  end
  object adsCountry: TAureliusDataset
    FieldDefs = <>
    Left = 488
    Top = 320
    object adsCountrySelf: TAureliusEntityField
      FieldName = 'Self'
      Visible = False
    end
    object adsCountryId: TIntegerField
      DisplayWidth = 5
      FieldName = 'Id'
    end
    object adsCountryName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 255
    end
  end
end
