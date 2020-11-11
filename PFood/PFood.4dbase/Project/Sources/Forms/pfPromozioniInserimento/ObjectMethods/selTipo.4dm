Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (selTipo{0}#selTipo{selTipo})
			vPR_Tipo:=selTipoCodice{selTipo}
			pfPromozioniInserimento ("visualizzaRicompense")
			
			selTipo{0}:=selTipo{selTipo}
		End if 
End case 
