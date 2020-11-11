$row:=AL_GetAreaLongProperty (alpRicompense;ALP_Area_SelRow)
If ($row>0)
	CONFIRM:C162("Vuoi veramente eliminare la ricompensa?";"Annulla";"Conferma")
	If (ok=0)
		pfPromozioniInserimento ("eliminaRigaRicompense";$row)
		AL_SetAreaLongProperty (alpRicompense;ALP_Area_UpdateData;0)
		AL_SetAreaLongProperty (alpRicompense;ALP_Area_SelRow;0)
	End if 
End if 