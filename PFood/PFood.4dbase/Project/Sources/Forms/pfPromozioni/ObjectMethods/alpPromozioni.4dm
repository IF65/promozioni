Case of 
	: (Form event code:C388=On Load:K2:1)
		pfPromozioni("inizializzaRicerca")
		pfPromozioni("inizializzaArray")
		
		ARRAY TEXT:C222($displayTipo;0)
		ARRAY TEXT:C222($displayTipoCodice;0)
		For ($i;1;Size of array:C274(<>promoTipo))
			APPEND TO ARRAY:C911($displayTipo;<>promoTipo{$i})
			APPEND TO ARRAY:C911($displayTipoCodice;<>promoTipoCodice{$i})
		End for 
		
		utlAlpAreaAddColumn(Self:C308;1;->arPR_id;"id";0;0;1;"";0)
		utlAlpAreaAddColumn(Self:C308;2;->arPR_bozza;"B";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;3;->arPR_stampato;"S";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;4;->arPR_codice;"Codice";1;70;2;"";0)
		utlAlpAreaAddColumn(Self:C308;5;->arPR_codiceCatalina;"Catalina";1;60;2;"";0)
		utlAlpAreaAddColumn(Self:C308;6;->arPR_tipo;"Tipo";1;160;1;"";0)
		utlAlpAreaAddColumn(Self:C308;7;->arPR_sottoreparti;"S";0;0;2;"";0)
		utlAlpAreaAddColumn(Self:C308;8;->arPR_descrizione;"Descrizione";1;70;1;"";0)
		utlAlpAreaAddColumn(Self:C308;9;->arPR_ripetibilita;"Rip.";0;0;3;<>formatInteger;0)
		utlAlpAreaAddColumn(Self:C308;10;->arPR_soglia;"Soglia";1;50;3;<>formatCurrency;0)
		utlAlpAreaAddColumn(Self:C308;11;->arPR_importo;"Importo";1;50;3;<>formatCurrency;0)
		utlAlpAreaAddColumn(Self:C308;12;->arPR_tipoCliente;"Cl.";1;30;2;"";0)
		utlAlpAreaAddColumn(Self:C308;13;->arPR_categoria;"Cat.";1;30;2;"";0)
		utlAlpAreaAddColumn(Self:C308;14;->arPR_barcode;"Barcode";1;90;1;"";0)
		utlAlpAreaAddColumn(Self:C308;15;->arPR_dataInizio;"Data In.";1;65;2;"";0)
		utlAlpAreaAddColumn(Self:C308;16;->arPR_dataFine;"Data Fine";1;65;2;"";0)
		utlAlpAreaAddColumn(Self:C308;17;->arPR_oraInizio;"Ora In.";1;65;2;"";0)
		utlAlpAreaAddColumn(Self:C308;18;->arPR_oraFine;"Ora Fine";1;65;2;"";0)
		utlAlpAreaAddColumn(Self:C308;19;->arPR_calendarioSettimanale;"Calendario";0;120;2;"";0)
		utlAlpAreaAddColumn(Self:C308;20;->arPR_Do;"Do";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;21;->arPR_Lu;"Lu";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;22;->arPR_Ma;"Ma";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;23;->arPR_Me;"Me";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;24;->arPR_Gi;"Gi";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;25;->arPR_Ve;"Ve";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;26;->arPR_Sa;"Sa";1;25;2;"";0)
		utlAlpAreaAddColumn(Self:C308;27;->arPR_testo;"";0;0;2;"";0)
		utlAlpAreaAddColumn(Self:C308;28;->arPR_numeroSedi;"Sedi";1;40;2;"";0)
		utlAlpAreaAddColumn(Self:C308;29;->arPR_immagineBarcode;"Immagine";0;0;2;"";0)
		
		utlAlpAreaSetup(Self:C308->)
		
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_ColumnResize;0)
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_SelGotoRec;1)
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_SelMultiple;1)
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_NumHdrLines;1)
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_ShowFooters;0)
		//AL_SetAreaLongProperty (Self->;ALP_Area_ColsLocked;2)
		
		AL_SetColumnLongProperty(Self:C308->;2;ALP_Column_DisplayControl;2)
		AL_SetColumnLongProperty(Self:C308->;3;ALP_Column_DisplayControl;2)
		
		AL_SetColumnPtrProperty(Self:C308->;6;ALP_Column_PopupArray;->$displayTipoCodice;1)
		AL_SetColumnPtrProperty(Self:C308->;6;ALP_Column_PopupMap;->$displayTipo;1)
		AL_SetColumnLongProperty(Self:C308->;6;ALP_Column_DisplayControl;3;1)
		//AL_SetColumnLongProperty (Self->;6;ALP_Column_Enterable;AL Column entry popup only)
		
		AL_SetColumnLongProperty(Self:C308->;20;ALP_Column_DisplayControl;2)
		AL_SetColumnLongProperty(Self:C308->;21;ALP_Column_DisplayControl;2)
		AL_SetColumnLongProperty(Self:C308->;22;ALP_Column_DisplayControl;2)
		AL_SetColumnLongProperty(Self:C308->;23;ALP_Column_DisplayControl;2)
		AL_SetColumnLongProperty(Self:C308->;24;ALP_Column_DisplayControl;2)
		AL_SetColumnLongProperty(Self:C308->;25;ALP_Column_DisplayControl;2)
		AL_SetColumnLongProperty(Self:C308->;26;ALP_Column_DisplayControl;2)
		
		AL_SetAreaLongProperty(Self:C308->;ALP_Area_AutoResizeColumn;8)
		
		pfPromozioni("totali")
		pfPromozioni("aggiornaDisplay")
	: (Form event code:C388=On Plug in Area:K2:16)
		$event:=AL_GetAreaLongProperty(Self:C308->;ALP_Area_AlpEvent)
		Case of 
			: ($event=AL Single Control Click)
				$menu:=""
				$menu:=$menu+"<BPianificazione Invio;"
				$menu:=$menu+"-;"
				$menu:=$menu+"Invio Immediato;"
				$menu:=$menu+"Cancellazione Immediata;"
				$menu:=$menu+"-;"
				$menu:=$menu+"Invio a Laboratorio;"
				$menu:=$menu+"Cancellazione da Laboratorio;"
				
				$result:=Pop up menu:C542($menu)
				Case of 
					: ($result=1)  // pianificazione invio
						
						ARRAY LONGINT:C221($selezione;0)
						$err:=AL_GetObjects(alpPromozioni;ALP_Object_Selection;$selezione)
						If (Size of array:C274($selezione)>0)
							$winRef:=Open form window:C675("utlImpostaDataOraSpedizione";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
							DIALOG:C40("utlImpostaDataOraSpedizione")
							If (ok=1)
								ARRAY OBJECT:C1221(incarichi;0)
								For ($i;1;Size of array:C274($selezione))
									$incarico:=New object:C1471(\
										"codicePromozione";arPR_codice{$selezione{$i}};\
										"lavoroCodice";10;\
										"data";vDataInvio;\
										"ora";String:C10(vOraInvio;HH MM:K7:2)\
										)
									APPEND TO ARRAY:C911(incarichi;$incarico)
								End for 
								pfIncarichi("creaIncarichi")
							End if 
						Else 
							ALERT:C41("Nessuna promozione selezionata!";"Continua")
						End if 
						
					: ($result=3)
						ARRAY LONGINT:C221($selezione;0)
						$err:=AL_GetObjects(alpPromozioni;ALP_Object_Selection;$selezione)
						If (Size of array:C274($selezione)>0)
							
							ARRAY LONGINT:C221($promozioni;0)
							For ($i;1;Size of array:C274($selezione))
								APPEND TO ARRAY:C911($promozioni;arPR_codice{$selezione{$i}})
							End for 
							$text:=utlElencoSediUsate(->$promozioni)
							$sediUsate:=JSON Parse:C1218($text)
							
							ARRAY OBJECT:C1221(incarichi;0)
							For ($i;1;Size of array:C274($selezione))
								If (OB Is defined:C1231($sediUsate;String:C10(arPR_codice{$selezione{$i}})))
									ARRAY TEXT:C222($codiciSediUsate;0)
									OB GET ARRAY:C1229($sediUsate;String:C10(arPR_codice{$selezione{$i}});$codiciSediUsate)
									For ($j;1;Size of array:C274($codiciSediUsate))
										$incarico:=New object:C1471(\
											"codicePromozione";arPR_codice{$selezione{$i}};\
											"codiceSede";$codiciSediUsate{$j};\
											"codiceLavoro";10\
											)
										APPEND TO ARRAY:C911(incarichi;$incarico)
									End for 
								End if 
							End for 
							pfIncarichi("creaIncarichi")
						End if 
						
					: ($result=4)
						ARRAY LONGINT:C221($selezione;0)
						$err:=AL_GetObjects(alpPromozioni;ALP_Object_Selection;$selezione)
						If (Size of array:C274($selezione)>0)
							ARRAY OBJECT:C1221(incarichi;0)
							For ($i;1;Size of array:C274($selezione))
								$incarico:=New object:C1471(\
									"codicePromozione";arPR_codice{$selezione{$i}};\
									"lavoroCodice";20;\
									"data";Current date:C33;\
									"ora";String:C10(Current time:C178;HH MM:K7:2)\
									)
								APPEND TO ARRAY:C911(incarichi;$incarico)
							End for 
							pfIncarichi("creaIncarichi")
						End if 
						
					: ($result=6)
						utlInvioLaboratorio("invio")
					: ($result=7)
						utlInvioLaboratorio("cancellazione")
				End case 
				
			: ($event=AL Empty Area Single click)
				//pfPromozioni ("totali")
			: ($event=AL Single click event)
				//pfPromozioni ("totali")
			: ($event=AL Double click event)
				promozioneSelezionata:=AL_GetAreaLongProperty(alpPromozioni;ALP_Area_SelRow)
				pfPromozioni("modificaPromozione")
			: ($event=AL Empty Area Double click)
				
		End case 
End case 