Case of 
	: (Form event code:C388=On Load:K2:1)
		pfAderenti ("inizializzaSedi")
		pfAderenti ("caricaArraySedi")
		
		utlAlpAreaAddColumn (Self:C308;1;->arADS_sedeCodice;"Sede";1;50;2;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arADS_descrizione;"Descrizione";1;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;3;->arADS_marchio;"Marchio";1;100;1;"";0)
		utlAlpAreaAddColumn (Self:C308;4;->arADS_societa_descrizione;"Societa'";1;100;1;"";0)
		utlAlpAreaAddColumn (Self:C308;5;->arADS_sottoreparti;"S.Rep.";1;35;2;"";0)
		
		utlAlpAreaSetup (Self:C308->)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_AutoSnapLastColumn;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_HideHeaders;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
		
		
		AL_SetColumnLongProperty (Self:C308->;5;ALP_Column_DisplayControl;2)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelNone;1)  //allow no selection parameters
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragLine;5)  //drag in and out with option key pressed
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragOptionKey;0)  //doesn't need the otion key
		AL_SetAreaLongProperty (alpAderenti;ALP_Area_DragAcceptLine;1)  //Accept Drag line
		
		AL_SetAreaTextProperty (Self:C308->;ALP_Area_DragSrcRowCodes;"DropA")
		AL_SetAreaTextProperty (alpAderenti;ALP_Area_DragDstRowCodes;"DropA")
		
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragRowMultiple;1)  //multiple rows dragging
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragRowOnto;0)  //Between rows (disable On row)
		
End case 