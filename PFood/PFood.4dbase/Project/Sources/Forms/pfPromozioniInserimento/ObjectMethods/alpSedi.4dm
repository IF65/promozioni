Case of 
	: (Form event code:C388=On Load:K2:1)
		utlAlpAreaAddColumn (Self:C308;1;->arSE_id;"";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arSE_idPromozioni;"";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;3;->arSE_codice;"";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;4;->arSE_descrizione;"Sede";1;0;1;"";0)
		utlAlpAreaSetup (Self:C308->)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ColumnResize;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_NumHdrLines;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_AutoResizeColumn;4)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_UpdateData;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ScrollTop;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelRow;0)
End case 