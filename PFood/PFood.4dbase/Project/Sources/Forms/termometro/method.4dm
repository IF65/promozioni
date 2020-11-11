Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(<>termometro)
		SET TIMER:C645(30)
		
	: (Form event code:C388=On Timer:K2:25)
		REDRAW WINDOW:C456
		If (<>termometro)
			CANCEL:C270
		End if 
		
	: ((Form event code:C388=On Outside Call:K2:11) & (<>termometro))
		CANCEL:C270
End case 