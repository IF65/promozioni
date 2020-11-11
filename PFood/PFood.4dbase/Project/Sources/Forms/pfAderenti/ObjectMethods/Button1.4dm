$nuovoAderenteDescrizione:=Request:C163("Denominazione Nuovo Aderente";"";"Conferma";"Annulla")
If (ok=1)
	$nuovoAderenteDescrizione:=trim_all (Uppercase:C13($nuovoAderenteDescrizione))
	If ($nuovoAderenteDescrizione#"")
		C_OBJECT:C1216($aderente)
		ARRAY OBJECT:C1221($sedi;0)
		$aderente:=New object:C1471("id";Generate UUID:C1066;"descrizione";$nuovoAderenteDescrizione)
		OB SET ARRAY:C1227($aderente;"sedi";$sedi)
		APPEND TO ARRAY:C911(<>aderenti;$aderente)
		
		aderenteSelezionato:=Size of array:C274(<>aderenti)
		pfAderenti ("salva")
		pfAderenti ("caricaArray")
		pfAderenti ("aggiornaDisplay")
	Else 
		ALERT:C41("Descrizione vuota o non valida.";"Annulla")
	End if 
End if 
