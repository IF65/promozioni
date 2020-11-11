CONFIRM:C162("Vuoi creare le promozioni relative alle righe caricate";"No";"Sì")
If (ok=0)
	For ($i;1;Size of array:C274(arTMPL_idIF65))
		Case of 
			: (arTMPL_tipoPromozione{$i}="0054")
				If (Not:C34(templateCaricamento_0054 (arTMPL_idIF65{$i};arTMPL_denominazione{$i};arTMPL_percentuale{$i};\
					arTMPL_dataInizio{$i};arTMPL_dataFine{$i};arTMPL_barcodeGruppo1{$i};arTMPL_barcodeGruppo2{$i};\
					arTMPL_codiciArticoloGruppo1{$i};arTMPL_codiciArticoloGruppo2{$i};arTMPL_aderenti{$i};arTMPL_aderentiGruppo{$i})))
					ALERT:C41("Errore promozione: "+String:C10(arTMPL_idIF65{$i});"Continua")
				End if 
				
		End case 
	End for 
End if 


