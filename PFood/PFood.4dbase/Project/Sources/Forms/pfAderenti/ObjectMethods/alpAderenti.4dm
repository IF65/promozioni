Case of 
	: (Form event code:C388=On Load:K2:1)
		pfAderenti ("inizializza")
		pfAderenti ("caricaArray")
		
		utlAlpAreaAddColumn (Self:C308;1;->arAD_id;"";0;70;2;"";0)
		utlAlpAreaAddColumn (Self:C308;2;->arAD_descrizione;"";1;0;1;"";0)
		utlAlpAreaAddColumn (Self:C308;3;->arAD_sedeCodice;"";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;4;->arAD_displayedLevel;"";0;0;2;"";0)
		utlAlpAreaAddColumn (Self:C308;5;->arAD_expanded;"";0;0;2;"";0)
		
		utlAlpAreaSetup (Self:C308->)
		
		$err:=AL_SetObjects2 (Self:C308->;ALP_Object_Hierarchy;arAD_displayedLevel;arAD_expanded)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragLine;5)  //drag in and out with option key pressed
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragOptionKey;0)  //doesn't need the option key
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragAcceptLine;1)  //Accept Drag line
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragRowMultiple;1)  //multiple rows dragging
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_DragRowOnto;1)  //Between rows (disable On row)
		
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_AutoSnapLastColumn;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_SelMultiple;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_RowHeightFixed;0)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_EntryClick;2)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_HideHeaders;1)
		AL_SetAreaLongProperty (Self:C308->;ALP_Area_ShowFooters;0)
	: (Form event code:C388=On Drop:K2:12)
		ARRAY LONGINT:C221($selezione;0)
		$err:=AL_GetObjects (alpAderentiSedi;ALP_Object_Selection;$selezione)
		$sz:=Size of array:C274($selezione)
		If ($sz>0)
			$destRow:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_DragDstRow)
			If ($destRow>0)
				$id:=arAD_id{$destRow}
				
				  //carico le sedi già presenti
				ARRAY TEXT:C222($sediPresenti;0)
				For ($i;1;Size of array:C274(arAD_id))
					If (arAD_id{$i}=$id) & (arAD_displayedLevel{$i}=1)
						APPEND TO ARRAY:C911($sediPresenti;arAD_sedeCodice{$i})
					End if 
				End for 
				
				  //aggiungo alle sedi già presenti le nuove sedi
				For ($i;1;Size of array:C274($selezione))
					If (Find in array:C230($sediPresenti;arADS_sedeCodice{$selezione{$i}})<0)
						APPEND TO ARRAY:C911($sediPresenti;arADS_sedeCodice{$selezione{$i}})
					End if 
				End for 
				
				  //ricostruisco l'array sedi
				ARRAY OBJECT:C1221($sedi;0)
				For ($i;1;Size of array:C274($sediPresenti))
					APPEND TO ARRAY:C911($sedi;New object:C1471("codice";$sediPresenti{$i};"descrizione";OB Get:C1224(<>sediDescrizione;$sediPresenti{$i};Is text:K8:3)))
				End for 
				
				aderenteSelezionato:=0
				For ($i;1;Size of array:C274(<>aderenti))
					If (<>aderenti{$i}.id=$id)
						aderenteSelezionato:=$i
					End if 
				End for 
				If (aderenteSelezionato>0)
					OB SET ARRAY:C1227(<>aderenti{aderenteSelezionato};"sedi";$sedi)
					pfAderenti ("salva")
					pfAderenti ("caricaArray")
					pfAderenti ("aggiornaDisplay")
				End if 
				
			End if 
		End if 
		
End case 




  //$row:=AL_GetAreaLongProperty (alpAderenti;ALP_Area_SelRow)
  //If ($row>0)
  //If (arAD_displayedLevel{$row}=0)
  //End if 
  //End if 
