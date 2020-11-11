Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(selAderente;0)
		ARRAY LONGINT:C221(selAderenteCodice;0)
		
		APPEND TO ARRAY:C911(selAderente;"SELEZIONA ADERENTI")
		APPEND TO ARRAY:C911(selAderenteCodice;0)
		APPEND TO ARRAY:C911(selAderente;"-")
		APPEND TO ARRAY:C911(selAderenteCodice;0)
		For ($i;1;Size of array:C274(<>aderenti))
			APPEND TO ARRAY:C911(selAderente;<>aderenti{$i}.descrizione)
			APPEND TO ARRAY:C911(selAderenteCodice;$i)
		End for 
		selAderente:=1
		
	: (Form event code:C388=On Clicked:K2:4)
		If (selAderente{0}#selAderente{selAderente})
			If (selAderente>1)
				ARRAY TEXT:C222($sediSelezionate;0)
				ARRAY OBJECT:C1221($sedi;0)
				OB GET ARRAY:C1229(<>aderenti{selAderenteCodice{selAderente}};"sedi";$sedi)
				For ($i;1;Size of array:C274($sedi))
					APPEND TO ARRAY:C911($sediSelezionate;$sedi{$i}.codice)
				End for 
				
				For ($i;1;Size of array:C274(arSE_codice))
					If (Find in array:C230($sediSelezionate;arSE_codice{$i})>0)
						arSE_selezionata{$i}:=True:C214
					Else 
						arSE_selezionata{$i}:=False:C215
					End if 
				End for 
				
				AL_SetAreaLongProperty (alpSedi;ALP_Area_UpdateData;0)
				AL_SetAreaLongProperty (alpSedi;ALP_Area_ScrollTop;0)
				AL_SetAreaLongProperty (alpSedi;ALP_Area_SelRow;0)
				
			End if 
			
			selAderente{0}:=selAderente{selAderente}
		End if 
End case 
