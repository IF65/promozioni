$row:=AL_GetAreaLongProperty (alpArticoli;ALP_Area_SelRow)
If ($row>0)
	CONFIRM:C162("Vuoi veramente eliminare l'articolo?";"Annulla";"Conferma")
	If (ok=0)
		pfPromozioniInserimento ("eliminaRigaArticoli";$row)
		AL_SetAreaLongProperty (alpArticoli;ALP_Area_UpdateData;0)
		AL_SetAreaLongProperty (alpArticoli;ALP_Area_SelRow;0)
	End if 
End if 
