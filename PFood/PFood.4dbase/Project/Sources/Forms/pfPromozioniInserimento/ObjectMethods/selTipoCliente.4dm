Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (selTipoCliente{0}#selTipoCliente{selTipoCliente})
			vPR_tipoCliente:=selTipoCliente-1
			
			selTipoCliente{0}:=selTipoCliente{selTipoCliente}
		End if 
End case 
