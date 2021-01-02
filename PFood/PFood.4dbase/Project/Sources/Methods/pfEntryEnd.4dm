//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 22/08/17, 11:07:00
  // ----------------------------------------------------
  // Method: b2bEntryEnd
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_BOOLEAN:C305($0)  // "data valid" return value (True or False) 
C_LONGINT:C283($1)  // AreaList Pro object reference
C_LONGINT:C283($2)  // action terminating data entry for this cell

If (Undefined:C82(alpRicompense))
	alpRicompense:=0
End if 
If (Undefined:C82(alpArticoli))
	alpArticoli:=0
End if 
If (Undefined:C82(alpGruppi))
	alpGruppi:=0
End if 

$0:=False:C215

If ($2#AL Esc key action)  // escape key will ignore (and reset) entered data
	$row:=AL_GetAreaLongProperty ($1;ALP_Area_EntryRow)
	$column:=AL_GetAreaLongProperty ($1;ALP_Area_EntryColumn)
	
	Case of 
		: ($1=alpRicompense)
			If (AL_GetAreaLongProperty ($1;ALP_Area_EntryModified)>0)
				Case of 
					: ($column=3)
						$0:=True:C214
					Else 
						$0:=True:C214
				End case 
			Else 
				$0:=True:C214
			End if 
			
		: ($1=alpArticoli)
			If (AL_GetAreaLongProperty ($1;ALP_Area_EntryModified)>0)
				If (utlMatchRegex ("^(\\d{7}|)$";arAR_codiceArticolo{$row}))
					
					If (arAR_codiceArticolo{$row}#"")
						$articoliJson:=utlCercaArticoloPerCodice (arAR_codiceArticolo{$row})
						ARRAY OBJECT:C1221($articoli;0)
						JSON PARSE ARRAY:C1219($articoliJson;$articoli)
						If (Size of array:C274($articoli)=1)
							If (OB Is defined:C1231($articoli{1};"codice"))
								arAR_descrizione{$row}:=OB Get:C1224($articoli{1};"descrizione";Is text:K8:3)
								AL_SetAreaLongProperty ($1;ALP_Area_ClearCache;$row)
								
								$0:=True:C214
							End if 
						End if 
					Else 
						arAR_descrizione{$row}:=""
						AL_SetAreaLongProperty ($1;ALP_Area_ClearCache;$row)
						$0:=True:C214
					End if 
				End if 
				
			Else 
				$0:=True:C214
			End if 
			
			  //: ($1=alpGruppi)
			  //If (arGR_descrizione{$row}#"")
			  //pfAderenti ("salva")
			  //$0:=True
			  //End if 
		Else 
			  //Case of 
			  //: ($1=alp_posid)
			  //If ([qc_ced_transazioni]codice_ced="")
			  //UNLOAD RECORD([qc_ced_transazioni])
			  //DELETE RECORD([qc_ced_transazioni])
			
			  //QUERY([qc_ced_transazioni];[qc_ced_transazioni]sede=(src_negozio_codice{src_negozio}+"@"))
			  //ORDER BY([qc_ced_transazioni];[qc_ced_transazioni]sede;>;[qc_ced_transazioni]codice_ced;>)
			
			  //AL_SetAreaLongProperty ($1;ALP_Area_AutoResizeColumn;6)
			  //AL_SetAreaLongProperty ($1;ALP_Area_UpdateData;0)
			  //AL_SetAreaLongProperty ($1;ALP_Area_ScrollTop;0)
			  //AL_SetAreaLongProperty ($1;ALP_Area_SelRow;0)
			  //End if 
			  //End case 
	End case 
End if 
