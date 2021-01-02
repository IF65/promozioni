If (selTipo>=3)
	$articolo:=cs:C1710.Articolo.new()
	$articolo.idPromozioni:=promozioneCorrente.id
	promozioneCorrente.articoli:=promozioneCorrente.articoli.push($articolo)
	$position:=promozioneCorrente.articoli.lastIndexOf($articolo)
	EDIT ITEM:C870(*; "colArticoliCodiceReparto"; $position+1)
Else 
	BEEP:C151
	ALERT:C41("Tipo promozione non specificato!"; "Continua")
End if 
