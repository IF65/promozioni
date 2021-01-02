vDataFine:=promozioneCorrente.dataFine
If (promozioneCorrente.dataFine<promozioneCorrente.dataInizio)
	promozioneCorrente.dataInizio:=promozioneCorrente.dataFine
	vDataInizio:=promozioneCorrente.dataInizio
End if 
