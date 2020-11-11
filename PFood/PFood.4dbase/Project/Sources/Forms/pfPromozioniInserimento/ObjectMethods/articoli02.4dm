If (selTipo>=3)
	GOTO OBJECT:C206(alpArticoli)
	pfPromozioniInserimento ("aggiungiRigaArticoli")
	AL_SetAreaLongProperty (alpArticoli;ALP_Area_UpdateData;1)
	AL_SetAreaLongProperty (alpArticoli;ALP_Area_EntryGotoRow;1)
	AL_SetAreaLongProperty (alpArticoli;ALP_Area_EntryGotoColumn;4)
Else 
	BEEP:C151
	ALERT:C41("Tipo promozione non specificato!";"Continua")
End if 
