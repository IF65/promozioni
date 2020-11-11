If (selTipo>=3)
	GOTO OBJECT:C206(alpRicompense)
	pfPromozioniInserimento ("aggiungiRigaRicompense")
	AL_SetAreaLongProperty (alpRicompense;ALP_Area_UpdateData;0)
	AL_SetAreaLongProperty (alpRicompense;ALP_Area_EntryGotoRow;Size of array:C274(arRI_id))
	AL_SetAreaLongProperty (alpRicompense;ALP_Area_EntryGotoColumn;4)
Else 
	BEEP:C151
	ALERT:C41("Tipo promozione non specificato!";"Continua")
End if 
