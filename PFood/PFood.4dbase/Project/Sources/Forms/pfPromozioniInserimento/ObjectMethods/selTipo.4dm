Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(selTipo; 0)
		ARRAY TEXT:C222(selTipoCodice; 0)
		If (Size of array:C274(<>promoTipo)>0)
			selTipo:=1
			For ($i; 1; Size of array:C274(<>promoTipo))
				APPEND TO ARRAY:C911(selTipo; <>promoTipo{$i})
				APPEND TO ARRAY:C911(selTipoCodice; <>promoTipoCodice{$i})
				If (promozioneCorrente.tipo=<>promoTipoCodice{$i})
					selTipo:=$i
				End if 
			End for 
			selTipo{0}:=selTipo{selTipo}
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (selTipo{0}#selTipo{selTipo})
			promozioneCorrente.tipo:=selTipoCodice{selTipo}
			promozioneCorrente.tipoDescrizione:=selTipo{selTipo}
			pfPromozioni("visualizzaRicompense")
			
			selTipo{0}:=selTipo{selTipo}
		End if 
End case 
