Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY LONGINT:C221($tipoAreaCodice;0)
		ARRAY TEXT:C222($tipoAreaDescrizione;0)
		APPEND TO ARRAY:C911($tipoAreaCodice;0)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Area non definita")
		APPEND TO ARRAY:C911($tipoAreaCodice;0)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito prima della stampa della riga di subtotale")
		APPEND TO ARRAY:C911($tipoAreaCodice;2)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito dopo la stampa della riga di subtotale")
		APPEND TO ARRAY:C911($tipoAreaCodice;3)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito prima della stampa della riga di totale")
		APPEND TO ARRAY:C911($tipoAreaCodice;4)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito dopo la stampa della riga di totale")
		APPEND TO ARRAY:C911($tipoAreaCodice;5)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito prima della fine scontrino")  //nel caso di stampante fiscale subito prima del logotipo fiscale
		APPEND TO ARRAY:C911($tipoAreaCodice;6)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito dopo la fine scontrino")  //nel caso di stampante fiscale subito dopo il logotipo fiscale
		APPEND TO ARRAY:C911($tipoAreaCodice;7)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Messaggi Retro scontrino")
		APPEND TO ARRAY:C911($tipoAreaCodice;8)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito dopo il passaggio tessera")
		APPEND TO ARRAY:C911($tipoAreaCodice;9)
		APPEND TO ARRAY:C911($tipoAreaDescrizione;"Subito dopo l’intestazione scontrino")
		
		AL_SetAreaTextProperty (Self:C308->;ALP_Area_CallbackMethEntryStart;"pfEntryStart")
		AL_SetAreaTextProperty (Self:C308->;ALP_Area_CallbackMethEntryEnd;"pfEntryEnd")
		
		utlAlpAreaAddColumn (Self:C308;1;->arRI_id;"";0;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arRI_idPromozioni;"";0;0;2;<>formatInteger;0)
		utlAlpAreaAddColumn (Self:C308;3;->arRI_progressivo;"#";1;20;2;"";1)
		utlAlpAreaAddColumn (Self:C308;4;->arRI_descrizione;"Descrizione";1;100;1;"";1)
		utlAlpAreaAddColumn (Self:C308;5;->arRI_soglia;"Sogl.";1;40;3;<>formatCurrency;1)
		utlAlpAreaAddColumn (Self:C308;6;->arRI_ammontare;"Imp.";1;40;3;<>formatCurrency;1)
		utlAlpAreaAddColumn (Self:C308;7;->arRI_limiteSconto;"Lim.";1;40;3;<>formatCurrency;1)
		utlAlpAreaAddColumn (Self:C308;8;->arRI_taglio;"Taglio";1;40;2;<>formatCurrency;1)
		utlAlpAreaAddColumn (Self:C308;9;->arRI_recordM;"Rec. M";1;100;1;"";1)
		utlAlpAreaAddColumn (Self:C308;10;->arRI_accumulatore;"Accum.";1;50;2;"";1)
		utlAlpAreaAddColumn (Self:C308;11;->arRI_promovar;"PVar";1;50;2;"";1)
		utlAlpAreaAddColumn (Self:C308;12;->arRI_tipoArea;"Tipo Area";1;200;1;"";1)
		utlAlpAreaAddColumn (Self:C308;13;->arRI_ordinamentoInArea;"Ord.";1;30;2;<>formatInteger;1)
		utlAlpAreaSetup (Self:C308->)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ColumnResize;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_NumHdrLines;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
		
		AL_SetColumnLongProperty (Self:C308->;4;ALP_Column_Uppercase;1)
		AL_SetColumnLongProperty (Self:C308->;4;ALP_Column_Attributed;0)
		
		AL_SetColumnPtrProperty (Self:C308->;12;ALP_Column_PopupArray;->$tipoAreaCodice;1)
		AL_SetColumnPtrProperty (Self:C308->;12;ALP_Column_PopupMap;->$tipoAreaDescrizione;1)
		AL_SetColumnLongProperty (Self:C308->;12;ALP_Column_DisplayControl;3;1)
		AL_SetColumnLongProperty (Self:C308->;12;ALP_Column_Enterable;AL Column entry popup only)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_AutoResizeColumn;4)
		
End case 

