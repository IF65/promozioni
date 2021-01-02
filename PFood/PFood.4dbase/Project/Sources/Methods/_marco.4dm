//%attributes = {}
C_OBJECT:C1216(<>promoDescrizione)
For ($i; 1; Size of array:C274(<>promoTipoCodice))
	OB SET:C1220(<>promoDescrizione; <>promoTipoCodice{$i}; <>promoTipo{$i})
End for 