ARRAY LONGINT:C221($selezione;0)
$err:=AL_GetObjects (alpIncarichi;ALP_Object_Selection;$selezione)
If (Size of array:C274($selezione)>0)
	ARRAY TEXT:C222(incarichiDaCancellare;0)
	For ($i;1;Size of array:C274($selezione))
		APPEND TO ARRAY:C911(incarichi;arINC_id{$selezione{$i}})
	End for 
	pfIncarichi ("cancellaIncarichi")
End if 