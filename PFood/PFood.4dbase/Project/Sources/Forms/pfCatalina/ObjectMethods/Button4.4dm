CONFIRM:C162("Vuoi creare le promozioni relative alle righe caricate";"No";"Sì")
If (ok=0)
	For ($i;1;Size of array:C274(arTC_id))
		Case of 
			: (arTC_tipo{$i}="0503")
				If (Not:C34(catalinaCaricamento_0503 (arTC_id{$i};arTC_soglia{$i};arTC_valore{$i};arTC_inizio{$i};arTC_fine{$i};arTC_barcode{$i})))
					ALERT:C41("Errore promozione: "+String:C10(arTC_id{$i});"Continua")
				End if 
				
			: (arTC_tipo{$i}="0481")
				If (Not:C34(catalinaCaricamento_0481 (arTC_id{$i};arTC_descrizione{$i};arTC_soglia{$i};arTC_valore{$i};arTC_inizio{$i};arTC_fine{$i};arTC_barcode{$i})))
					ALERT:C41("Errore promozione: "+String:C10(arTC_id{$i});"Continua")
				End if 
				
			: (arTC_tipo{$i}="0492")
				If (Not:C34(catalinaCaricamento_0492 (arTC_id{$i};arTC_descrizione{$i};arTC_soglia{$i};arTC_valore{$i};arTC_inizio{$i};arTC_fine{$i};arTC_barcode{$i})))
					ALERT:C41("Errore promozione: "+String:C10(arTC_id{$i});"Continua")
				End if 
				
			: (arTC_tipo{$i}="ACPT")
				If (Not:C34(catalinaCaricamento_ACPT (arTC_id{$i};arTC_descrizione{$i};arTC_soglia{$i};arTC_valore{$i};arTC_inizio{$i};arTC_fine{$i};arTC_barcode{$i})))
					ALERT:C41("Errore promozione: "+String:C10(arTC_id{$i});"Continua")
				End if 
		End case 
	End for 
End if 
