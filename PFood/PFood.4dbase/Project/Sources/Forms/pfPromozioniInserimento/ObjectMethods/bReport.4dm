If (selTipo>=3)
	ARRAY TEXT:C222(<>sediSelezionate;0)
	For ($i;1;Size of array:C274(arSE_codice))
		APPEND TO ARRAY:C911(<>sediSelezionate;arSE_codice{$i})
	End for 
	
	COPY ARRAY:C226(<>sediSelezionate;$sediSelezionate)
	
	pfSceltaSedi 
	While (<>sceltaSedi#0)
		IDLE:C311
	End while 
	
	If (Not:C34(utlConfrontoArray (-><>sediSelezionate;->$sediSelezionate)))
		If (Size of array:C274(<>sediSelezionate)>0)
			  //elimino le sedi eliminate
			For ($i;Size of array:C274(arSE_codice);1;-1)
				If (Find in array:C230(<>sediSelezionate;arSE_codice{$i})<0)
					DELETE FROM ARRAY:C228(arSE_id;$i)
					DELETE FROM ARRAY:C228(arSE_idPromozioni;$i)
					DELETE FROM ARRAY:C228(arSE_codice;$i)
					DELETE FROM ARRAY:C228(arSE_descrizione;$i)
				End if 
			End for 
			
			  //aggiungo le sedi nuove
			For ($i;1;Size of array:C274(<>sediSelezionate);1)
				If (Find in array:C230(arSE_codice;<>sediSelezionate{$i})<0)
					APPEND TO ARRAY:C911(arSE_id;Generate UUID:C1066)
					APPEND TO ARRAY:C911(arSE_idPromozioni;vPR_id)
					APPEND TO ARRAY:C911(arSE_codice;<>sediSelezionate{$i})
					APPEND TO ARRAY:C911(arSE_descrizione;<>sediSelezionate{$i}+" - "+OB Get:C1224(<>sediDescrizione;<>sediSelezionate{$i};Is text:K8:3))
				End if 
			End for 
			SORT ARRAY:C229(arSE_codice;arSE_descrizione;arSE_id;arSE_idPromozioni;>)
			AL_SetAreaLongProperty (alpSedi;ALP_Area_UpdateData;0)
			AL_SetAreaLongProperty (alpSedi;ALP_Area_ScrollTop;0)
			AL_SetAreaLongProperty (alpSedi;ALP_Area_SelRow;0)
		End if 
	End if 
Else 
	BEEP:C151
	ALERT:C41("Tipo promozione non specificato!";"Continua")
End if 


