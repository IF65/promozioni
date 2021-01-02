Case of 
	: (Form event code:C388=On Load:K2:1)
		pfCatalina ("inizializzaArray")
		
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
		
		utlAlpAreaAddColumn (Self:C308;1;->arTC_id;"id";1;50;2;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arTC_descrizione;"Descrizione";1;130;1;"";0)
		utlAlpAreaAddColumn (Self:C308;3;->arTC_categoria;"Categ.";1;50;2;"";0)
		utlAlpAreaAddColumn (Self:C308;4;->arTC_tipo;"Tipo";1;200;1;"";0)
		utlAlpAreaAddColumn (Self:C308;5;->arTC_valore;"Valore";1;50;3;<>formatCurrency;0)
		utlAlpAreaAddColumn (Self:C308;6;->arTC_soglia;"Soglia";1;40;3;<>formatCurrency;0)
		utlAlpAreaAddColumn (Self:C308;7;->arTC_inizio;"Inizio";1;70;2;"";0)
		utlAlpAreaAddColumn (Self:C308;8;->arTC_fine;"Fine";1;70;2;"";0)
		utlAlpAreaAddColumn (Self:C308;9;->arTC_barcode;"Barcode";1;0;1;"";0)
		
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
		
		AL_SetColumnPtrProperty (Self:C308->;4;ALP_Column_PopupArray;->$tipoCodice;1)
		AL_SetColumnPtrProperty (Self:C308->;4;ALP_Column_PopupMap;->$tipoDescrizione;1)
		AL_SetColumnLongProperty (Self:C308->;4;ALP_Column_DisplayControl;3;1)
		AL_SetColumnLongProperty (Self:C308->;4;ALP_Column_Enterable;AL Column entry off)
		
		
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