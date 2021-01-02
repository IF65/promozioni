If (articoliCurrentItemPosition>0)
	CONFIRM:C162("Vuoi veramente eliminare l'articolo'?"; "Annulla"; "Conferma")
	If (ok=0)
		promozioneCorrente.articoli.remove(articoliCurrentItemPosition-1)
		promozioneCorrente.articoli:=promozioneCorrente.articoli
	End if 
Else 
	ALERT:C41("Nessun articolo selezionata."; "Annulla")
End if 