Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(selAderente; 0)
		ARRAY LONGINT:C221(selAderenteCodice; 0)
		
		APPEND TO ARRAY:C911(selAderente; "SELEZIONA ADERENTI")
		APPEND TO ARRAY:C911(selAderenteCodice; 0)
		APPEND TO ARRAY:C911(selAderente; "-")
		APPEND TO ARRAY:C911(selAderenteCodice; 0)
		For ($i; 1; Size of array:C274(<>aderenti))
			APPEND TO ARRAY:C911(selAderente; <>aderenti{$i}.descrizione)
			APPEND TO ARRAY:C911(selAderenteCodice; $i)
		End for 
		selAderente:=1
		
		For each ($sede; <>sediDisponibili)
			$sede.selezionata:=False:C215
		End for each 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		If (selAderente{0}#selAderente{selAderente})
			If (selAderente>1)
				For each ($sede; <>sediDisponibili)
					$sede.selezionata:=False:C215
				End for each 
				
				ARRAY OBJECT:C1221($sedi; 0)
				OB GET ARRAY:C1229(<>aderenti{selAderenteCodice{selAderente}}; "sedi"; $sedi)
				For ($i; 1; Size of array:C274($sedi))
					<>sediDisponibili.query("codice = :1"; $sedi{$i}.codice)[0].selezionata:=True:C214
				End for 
				<>sediDisponibili:=<>sediDisponibili
			End if 
			
			selAderente{0}:=selAderente{selAderente}
		End if 
End case 
