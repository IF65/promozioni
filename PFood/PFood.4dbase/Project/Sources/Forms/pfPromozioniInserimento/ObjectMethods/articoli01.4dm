Case of 
	: (Form event code:C388=On Load:K2:1)
		AL_SetAreaTextProperty (Self:C308->;ALP_Area_CallbackMethEntryStart;"pfEntryStart")
		AL_SetAreaTextProperty (Self:C308->;ALP_Area_CallbackMethEntryEnd;"pfEntryEnd")
		
		utlAlpAreaAddColumn (Self:C308;1;->arAR_id;"";0;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arAR_idPromozioni;"";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;3;->arAR_codiceArticolo;"Art.";0;50;1;"";0)
		utlAlpAreaAddColumn (Self:C308;4;->arAR_codiceReparto;"Rep.";1;40;1;"";1)
		utlAlpAreaAddColumn (Self:C308;5;->arAR_barcode;"Barcode";1;90;1;"";1)
		utlAlpAreaAddColumn (Self:C308;6;->arAR_descrizione;"Descrizione";1;45;1;"";0)
		utlAlpAreaAddColumn (Self:C308;7;->arAR_molteplicita;"M";1;25;2;<>formatInteger;1)
		utlAlpAreaAddColumn (Self:C308;8;->arAR_gruppo;"Gr";1;25;2;<>formatInteger;1)
		
		utlAlpAreaSetup (Self:C308->)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ColumnResize;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_NumHdrLines;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryMapEnter;0)
		
		AL_SetColumnLongProperty (Self:C308->;6;ALP_Column_Uppercase;1)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_AutoResizeColumn;6)
End case 