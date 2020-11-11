Case of 
	: (Form event code:C388=On Load:K2:1)
		notePromozionePiePagina:=""
		pfPromozioniInserimento ("visualizzaRicompense")
		
	: (Form event code:C388=On Clicked:K2:4)
		vPR_calendarioSettimanale:=""
		If (vPR_Do)
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"1"
		Else 
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"0"
		End if 
		If (vPR_Lu)
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"1"
		Else 
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"0"
		End if 
		If (vPR_Ma)
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"1"
		Else 
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"0"
		End if 
		If (vPR_Me)
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"1"
		Else 
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"0"
		End if 
		If (vPR_Gi)
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"1"
		Else 
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"0"
		End if 
		If (vPR_Ve)
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"1"
		Else 
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"0"
		End if 
		If (vPR_Sa)
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"1"
		Else 
			vPR_calendarioSettimanale:=vPR_calendarioSettimanale+"0"
		End if 
	: (Form event code:C388=On Resize:K2:27)
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		$width:=$right-$left
		$button_width_new:=Int:C8(($width-41)/10)
		OBJECT GET COORDINATES:C663(Button10;$b_left;$b_top;$b_right;$b_bottom)
		$button_width_old:=$b_right-$b_left
		
		$delta:=$button_width_new-$button_width_old
		For ($i;1;10)
			OBJECT MOVE:C664(*;"Button"+String:C10($i);($i-1)*$delta;0;$delta;0)
		End for 
		
	: (Form event code:C388=On Data Change:K2:15)
		If (Size of array:C274(arRI_ammontare)=1) & (vPR_codice#0) & ((vPR_Tipo="0481") | (vPR_Tipo="0503"))
			  //vPR_barcode:=utlCreaBarcodeCatalina (vPR_Tipo;vPR_codice;arRI_ammontare{1})
		End if 
End case 