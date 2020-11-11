Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (srcSocietaDescrizione{0}#String:C10(srcSocietaDescrizione))
			srcSocietaDescrizione{0}:=String:C10(srcSocietaDescrizione)
		End if 
End case 
