Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(selTipoCliente; 0)
		APPEND TO ARRAY:C911(selTipoCliente; "0 - TUTTI")
		APPEND TO ARRAY:C911(selTipoCliente; "1 - CLIENTE")
		APPEND TO ARRAY:C911(selTipoCliente; "2 - DIPENDENTE")
		APPEND TO ARRAY:C911(selTipoCliente; "3 - CLIENTE E DIPENDENTE")
		APPEND TO ARRAY:C911(selTipoCliente; "4 - CLIENTE DI UNA CATEGORIA")
		APPEND TO ARRAY:C911(selTipoCliente; "5 - DIPENDENTE DI UNA CATEGORIA")
		APPEND TO ARRAY:C911(selTipoCliente; "6 - CLIENTE/DIPENDENTE DI UNA CATEGORIA")
		APPEND TO ARRAY:C911(selTipoCliente; "7 - SOLO CLIENTE/DIPENDENTE SENZA TESSERA")
		selTipoCliente:=promozioneCorrente.tipoCliente+1
		selTipoCliente{0}:=selTipoCliente{selTipoCliente}
		
	: (Form event code:C388=On Clicked:K2:4)
		If (selTipoCliente{0}#selTipoCliente{selTipoCliente})
			vPR_tipoCliente:=selTipoCliente-1
			
			selTipoCliente{0}:=selTipoCliente{selTipoCliente}
		End if 
End case 
