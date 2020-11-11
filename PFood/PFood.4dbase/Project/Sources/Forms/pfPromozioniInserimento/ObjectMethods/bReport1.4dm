Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Macintosh option down:C545)
			If (vPR_barcode#"")
				ARRAY TEXT:C222($documents;0)
				$document:=Select document:C905("";"PMT";"Seleziona il file che contiene il PMT";Use sheet window:K24:11+Alias selection:K24:10;$documents)
				If ($document#"") & (Size of array:C274($documents)=1)
					$text:=Document to text:C1236($documents{1})
					If (utlMatchRegex (vPR_barcode;$text))
						vPR_testo:=$text
					Else 
						CONFIRM:C162("Il barcode non è contenuto nel file selezionato?";"Annullo";"Carico")
						If (ok=0)
							vPR_testo:=$text
						End if 
					End if 
				Else 
					ALERT:C41("E' necessario selezionare un file PMT !";"Continua")
				End if 
			Else 
				ALERT:C41("Per caricare un file PMT è necessario inserire un barcode !";"Continua")
			End if 
			
		Else 
			$ok:=True:C214
			If (vPR_testo#"")
				CONFIRM:C162("Attenzione il PMT verrà sovrascritto";"Annulla";"Continua")
				If (ok=1)
					$ok:=False:C215
				End if 
			End if 
			If ($ok=True:C214)
				If (Size of array:C274(arRI_promovar)=1)
					If (arRI_promovar{1}="")
						arRI_promovar{1}:=String:C10(utlProgressivoCrea (<>progPromovarPMT))
					End if 
					If (Size of array:C274(arAR_codiceReparto)>0)
						vPR_testo:=utlCreaPmtDaTemplate (\
							arRI_promovar{1};\
							vPR_dataInizio;\
							vPR_dataFine;\
							arRI_soglia{1};\
							arRI_ammontare{1};\
							vPR_barcode;\
							->arAR_codiceReparto\
							)
					Else 
						vPR_testo:=utlCreaPmtDaTemplate (\
							arRI_promovar{1};\
							vPR_dataInizio;\
							vPR_dataFine;\
							arRI_soglia{1};\
							arRI_ammontare{1};\
							vPR_barcode\
							)
					End if 
					
				Else 
					ALERT:C41("Record ricompensa mancante o ambiguo!";"Annulla")
				End if 
			End if 
		End if 
End case 
