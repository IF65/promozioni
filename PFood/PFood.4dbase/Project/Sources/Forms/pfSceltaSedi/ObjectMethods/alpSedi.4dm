Case of 
	: (Form event code:C388=On Load:K2:1)
		utlAlpAreaAddColumn (Self:C308;1;->arSE_codice;"";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arSE_descrizione;"Sede";1;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;3;->arSE_selezionata;"";1;25;2;"";1)
		utlAlpAreaSetup (Self:C308->)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ColumnResize;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_NumHdrLines;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
		
		AL_SetColumnLongProperty (Self:C308->;3;ALP_Column_DisplayControl;2;1)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_AutoResizeColumn;2)
End case 