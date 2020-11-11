ARRAY LONGINT:C221($selezione;0)
$err:=AL_GetObjects (alpPromozioni;ALP_Object_Selection;$selezione)
If (Size of array:C274($selezione)>0)
	
	ARRAY TEXT:C222($id;0)
	For ($i;1;Size of array:C274($selezione))
		APPEND TO ARRAY:C911($id;arPR_id{$selezione{$i}})
	End for 
	
	If (Not:C34(utlPromozioniIF652Excel (->$id)))
		ALERT:C41("Errore";"Continua")
	End if 
	
End if 
