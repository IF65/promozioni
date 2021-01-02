Case of 
	: (Form event code:C388=On Data Change:K2:15)
		vDataInizio:=promozioneCorrente.dataInizio
		If (promozioneCorrente.dataFine<promozioneCorrente.dataInizio)
			promozioneCorrente.dataFine:=promozioneCorrente.dataInizio
			vDataFine:=promozioneCorrente.dataFine
		End if 
		
End case 