Case of 
	: (Form event code:C388=On Load:K2:1)
		pfTemplate ("inizializzaArray")
		
		ARRAY TEXT:C222($tipoDescrizione;0)
		ARRAY TEXT:C222($tipoCodice;0)
		APPEND TO ARRAY:C911($tipoDescrizione;"INDEFINITO")
		APPEND TO ARRAY:C911($tipoCodice;"")
		APPEND TO ARRAY:C911($tipoDescrizione;"-")
		APPEND TO ARRAY:C911($tipoCodice;"")
		For ($i;1;Size of array:C274(<>promoTipoCodice))
			APPEND TO ARRAY:C911($tipoDescrizione;<>promoTipo{$i})
			APPEND TO ARRAY:C911($tipoCodice;<>promoTipoCodice{$i})
		End for 
		
		ARRAY TEXT:C222(arTMPL_tipoPromozione;0)
		ARRAY LONGINT:C221(arTMPL_idIF65;0)
		ARRAY LONGINT:C221(arTMPL_numero;0)
		ARRAY LONGINT:C221(arTMPL_promovar;0)
		ARRAY TEXT:C222(arTMPL_denominazione;0)
		ARRAY REAL:C219(arTMPL_percentuale;0)
		ARRAY DATE:C224(arTMPL_dataInizio;0)
		ARRAY DATE:C224(arTMPL_dataFine;0)
		ARRAY TEXT:C222(arTMPL_barcodeGruppo1;0)
		ARRAY TEXT:C222(arTMPL_barcodeGruppo2;0)
		ARRAY TEXT:C222(arTMPL_codiciArticoloGruppo1;0)
		ARRAY TEXT:C222(arTMPL_codiciArticoloGruppo2;0)
		ARRAY TEXT:C222(arTMPL_aderenti;0)
		ARRAY TEXT:C222(arTMPL_aderentiGruppo;0)
		
		utlAlpAreaAddColumn (Self:C308;1;->arTMPL_tipoPromozione;"Tipo";1;130;2;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arTMPL_idIF65;"id";1;50;2;<>formatInteger;0)
		utlAlpAreaAddColumn (Self:C308;3;->arTMPL_numero;"Numero";1;50;2;<>formatInteger;0)
		utlAlpAreaAddColumn (Self:C308;4;->arTMPL_promovar;"P.Var";1;50;2;<>formatInteger;0)
		utlAlpAreaAddColumn (Self:C308;5;->arTMPL_denominazione;"Denominazione";1;200;1;"";0)
		utlAlpAreaAddColumn (Self:C308;6;->arTMPL_percentuale;"%";1;50;3;<>formatCurrency;0)
		utlAlpAreaAddColumn (Self:C308;7;->arTMPL_dataInizio;"Inizio";1;70;2;"";0)
		utlAlpAreaAddColumn (Self:C308;8;->arTMPL_dataFine;"Fine";1;70;2;"";0)
		utlAlpAreaAddColumn (Self:C308;9;->arTMPL_barcodeGruppo1;"Barcode1";1;70;1;"";0)
		utlAlpAreaAddColumn (Self:C308;10;->arTMPL_barcodeGruppo2;"Barcode2";1;70;1;"";0)
		utlAlpAreaAddColumn (Self:C308;11;->arTMPL_codiciArticoloGruppo1;"Codici1";1;70;1;"";0)
		utlAlpAreaAddColumn (Self:C308;12;->arTMPL_codiciArticoloGruppo2;"Codici2";1;70;1;"";0)
		utlAlpAreaAddColumn (Self:C308;13;->arTMPL_aderenti;"Aderenti";1;70;1;"";0)
		utlAlpAreaAddColumn (Self:C308;14;->arTMPL_aderentiGruppo;"Aderenti Gr.";1;70;1;"";0)
		
		utlAlpAreaSetup (Self:C308->)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ColumnResize;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelGotoRec;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_NumHdrLines;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
		  //AL_SetAreaLongProperty (Self->;ALP_Area_ColsLocked;2)
		
		  //AL_SetColumnLongProperty (Self->;10;ALP_Column_DisplayControl;2)
		
		AL_SetColumnPtrProperty (Self:C308->;1;ALP_Column_PopupArray;->$tipoCodice;1)
		AL_SetColumnPtrProperty (Self:C308->;1;ALP_Column_PopupMap;->$tipoDescrizione;1)
		AL_SetColumnLongProperty (Self:C308->;1;ALP_Column_DisplayControl;3;1)
		AL_SetColumnLongProperty (Self:C308->;1;ALP_Column_Enterable;AL Column entry off)
		
		
		  //AL_SetAreaLongProperty (Self->;ALP_Area_AutoResizeColumn;5)
		
		  //pfIncarichi ("totali")
		  //pfIncarichi ("aggiornaDisplay")
	: (Form event code:C388=On Plug in Area:K2:16)
		$event:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_AlpEvent)
		  //Case of 
		  //: ($event=AL Empty Area Single click)
		  //  //pfIncarichi ("totali")
		  //: ($event=AL Single click event)
		  //  //pfIncarichi ("totali")
		  //: ($event=AL Double click event)
		  //promozioneSelezionata:=AL_GetAreaLongProperty (alpCatalina;ALP_Area_SelRow)
		  //pfIncarichi ("modificaPromozione")
		  //: ($event=AL Empty Area Double click)
		  //ordineSelezionato:=0
		  //pfIncarichi ("modificaOrdine")
		  //End case 
End case 