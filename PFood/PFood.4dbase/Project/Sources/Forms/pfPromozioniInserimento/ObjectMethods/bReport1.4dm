Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Macintosh option down:C545)
			If (promozioneCorrente.barcode#"")
				ARRAY TEXT:C222($documents; 0)
				$document:=Select document:C905(""; "PMT"; "Seleziona il file che contiene il PMT"; Use sheet window:K24:11+Alias selection:K24:10; $documents)
				If ($document#"") & (Size of array:C274($documents)=1)
					$text:=Document to text:C1236($documents)
					If (utlMatchRegex(promozioneCorrente.barcode; $text))
						promozioneCorrente.testo:=$text
					Else 
						CONFIRM:C162("Il barcode non è contenuto nel file selezionato?"; "Annullo"; "Carico")
						If (ok=0)
							promozioneCorrente.testo:=$text
						End if 
					End if 
				Else 
					ALERT:C41("E' necessario selezionare un file PMT !"; "Continua")
				End if 
			Else 
				ALERT:C41("Per caricare un file PMT è necessario inserire un barcode !"; "Continua")
			End if 
			
		Else 
			$ok:=True:C214
			If (promozioneCorrente.testo#"")
				CONFIRM:C162("Attenzione il PMT verrà sovrascritto"; "Annulla"; "Continua")
				If (ok=1)
					$ok:=False:C215
				End if 
			End if 
			If ($ok=True:C214)
				If (promozioneCorrente.ricompense.count()=1)
					If (promozioneCorrente.ricompense[0].promovar="")
						promozioneCorrente.ricompense[0].promovar:=String:C10(utlProgressivoCrea(<>progPromovarPMT))
					End if 
					If (promozioneCorrente.articoli.count()>0)
						ARRAY TEXT:C222($codiciReparto; 0)
						COLLECTION TO ARRAY:C1562(promozioneCorrente.articoli; $codiciReparto; "codiceReparto")
						
						promozioneCorrente.testo:=utlCreaPmtDaTemplate(\
							promozioneCorrente.ricompense[0].promovar; \
							promozioneCorrente.dataInizio; \
							promozioneCorrente.dataFine; \
							promozioneCorrente.ricompense[0].soglia; \
							promozioneCorrente.ricompense[0].ammontare; \
							promozioneCorrente.barcode; \
							->$codiciReparto\
							)
					Else 
						promozioneCorrente.testo:=utlCreaPmtDaTemplate(\
							promozioneCorrente.ricompense[0].promovar; \
							promozioneCorrente.dataInizio; \
							promozioneCorrente.dataFine; \
							promozioneCorrente.ricompense[0].soglia; \
							promozioneCorrente.ricompense[0].ammontare; \
							promozioneCorrente.barcode\
							)
					End if 
					
				Else 
					ALERT:C41("Record ricompensa mancante o ambiguo!"; "Annulla")
				End if 
			End if 
		End if 
End case 
