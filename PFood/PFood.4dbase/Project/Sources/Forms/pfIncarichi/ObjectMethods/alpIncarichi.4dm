Case of 
	: (Form event code:C388=On Load:K2:1)
		pfIncarichi ("inizializzaRicerca")
		pfIncarichi ("inizializzaArray")
		
		ARRAY TEXT:C222($statoDescrizione;0)
		ARRAY LONGINT:C221($statoCodice;0)
		APPEND TO ARRAY:C911($statoDescrizione;"INDEFINITO")
		APPEND TO ARRAY:C911($statoCodice;0)
		APPEND TO ARRAY:C911($statoDescrizione;"ORDINE DI INVIO")
		APPEND TO ARRAY:C911($statoCodice;10)
		
		utlAlpAreaAddColumn (Self:C308;1;->arINC_id;"id";0;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arINC_idPadre;"idPadre";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;3;->arINC_codicePromozione;"Pr. Num.";1;55;2;"";0)
		utlAlpAreaAddColumn (Self:C308;4;->arINC_lavoroCodice;"Codice";1;40;2;"";0)
		utlAlpAreaAddColumn (Self:C308;5;->arINC_lavoroDescrizione;"Descrizione";1;200;1;"";0)
		utlAlpAreaAddColumn (Self:C308;6;->arINC_negozioCodice;"Sede";1;40;2;"";0)
		utlAlpAreaAddColumn (Self:C308;7;->arINC_negozioDescrizione;"Descrizione";1;150;1;"";0)
		utlAlpAreaAddColumn (Self:C308;8;->arINC_data;"Data";1;70;2;"";0)
		utlAlpAreaAddColumn (Self:C308;9;->arINC_ora;"Ora";1;50;2;"";0)
		utlAlpAreaAddColumn (Self:C308;10;->arINC_stato;"Stato";1;35;1;"";0)
		utlAlpAreaAddColumn (Self:C308;11;->arINC_tsEsecuzione;"";0;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;12;->arINC_tsCreazione;"";0;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;13;->arINC_tsPianificazione;"";0;0;1;"";0)
		
		utlAlpAreaSetup (Self:C308->)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ColumnResize;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelGotoRec;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_NumHdrLines;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
		  //AL_SetAreaLongProperty (Self->;ALP_Area_ColsLocked;2)
		
		  //AL_SetColumnLongProperty (Self->;10;ALP_Column_DisplayControl;2)
		
		AL_SetColumnPtrProperty (Self:C308->;10;ALP_Column_PopupArray;->$statoCodice;1)
		AL_SetColumnPtrProperty (Self:C308->;10;ALP_Column_PopupMap;->$statoDescrizione;1)
		AL_SetColumnLongProperty (Self:C308->;10;ALP_Column_DisplayControl;3;1)
		  //AL_SetColumnLongProperty (Self->;10;ALP_Column_Enterable;AL Column entry popup only)
		
		
		  //AL_SetAreaLongProperty (Self->;ALP_Area_AutoResizeColumn;5)
		
		pfIncarichi ("totali")
		pfIncarichi ("aggiornaDisplay")
	: (Form event code:C388=On Plug in Area:K2:16)
		$event:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_AlpEvent)
		Case of 
			: ($event=AL Empty Area Single click)
				  //pfIncarichi ("totali")
			: ($event=AL Single click event)
				  //pfIncarichi ("totali")
			: ($event=AL Double click event)
				promozioneSelezionata:=AL_GetAreaLongProperty (alpIncarichi;ALP_Area_SelRow)
				pfIncarichi ("modificaPromozione")
			: ($event=AL Empty Area Double click)
				ordineSelezionato:=0
				pfIncarichi ("modificaOrdine")
		End case 
End case 