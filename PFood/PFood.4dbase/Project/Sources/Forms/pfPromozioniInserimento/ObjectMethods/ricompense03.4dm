If (ricompenseCurrentItemPosition>0)
	CONFIRM:C162("Vuoi veramente eliminare la ricompensa?"; "Annulla"; "Conferma")
	If (ok=0)
		promozioneCorrente.ricompense.remove(ricompenseCurrentItemPosition-1)
		promozioneCorrente.ricompense:=promozioneCorrente.ricompense
	End if 
Else 
	ALERT:C41("Nessuna ricompensa selezionata."; "Annulla")
End if 