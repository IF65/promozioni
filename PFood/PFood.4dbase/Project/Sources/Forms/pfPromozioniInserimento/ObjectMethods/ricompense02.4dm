If (selTipo>=3)
	$ricompensa:=cs:C1710.Ricompensa.new()
	$ricompensa.idPromozioni:=promozioneCorrente.id
	promozioneCorrente.ricompense:=promozioneCorrente.ricompense.push($ricompensa)
	$position:=promozioneCorrente.ricompense.lastIndexOf($ricompensa)
	EDIT ITEM:C870(*; "colRicompenseDescrizione"; $position+1)
Else 
	BEEP:C151
	ALERT:C41("Tipo promozione non specificato!"; "Continua")
End if 
