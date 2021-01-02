If (selTipo>=3)
	pfSceltaSedi
	While (<>sceltaSedi#0)
		IDLE:C311
	End while 
	
	//$entitySelection:=ds.Employee.query("firstName in :1";New collection("Kim";"Dixie"))
	
	$sediSelezionate:=<>sediDisponibili.query("selezionata = :1"; False:C215)
	For each ($sede; $sediSelezionate)
		$result:=promozioneCorrente.sedi.query("codiceSede = :1"; $sede.codice)
		$position:=promozioneCorrente.sedi.lastIndexOf($result)
		promozioneCorrente.sedi.remove($position)
	End for each 
	
	// aggiungo le sedi inserite nella selezione (se non già presenti)
	$sediSelezionate:=<>sediDisponibili.query("selezionata = :1"; True:C214)
	For each ($sede; $sediSelezionate)
		$result:=promozioneCorrente.sedi.query("codiceSede = :1"; $sede.codice)
		If ($result.count()=0)
			$nuovaSede:=cs:C1710.PromozioneSede.new()
			$nuovaSede.idPromozioni:=promozioneCorrente.id
			$nuovaSede.codiceSede:=$sede.codice
			$nuovaSede.descrizione:=$sede.descrizione
			promozioneCorrente.sedi.push($sede)
		End if 
	End for each 
Else 
	BEEP:C151
	ALERT:C41("Tipo promozione non specificato!"; "Continua")
End if 


