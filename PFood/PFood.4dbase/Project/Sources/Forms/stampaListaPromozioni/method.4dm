Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_REAL:C285($bestWidth;$bestHeigth)
		
		$delta:=15
		
		  //riposiziono gli oggetti di testata in funzione del tipo di carta e del sua orientamento
		  //------------------------------------------------------------------------------------------------
		  //$maxRight:=0
		  //OBJECT GET COORDINATES(vDescrizioneSede;$left;$top;$right;$bottom)
		  //OBJECT GET BEST SIZE(vDescrizioneSede;$bestWidth;$bestHeigth)
		  //OBJECT MOVE(vDescrizioneSede;0;0;-($right-$left-$bestWidth);0)
		  //OBJECT GET COORDINATES(vDescrizioneSede;$left;$top;$right;$bottom)
		  //$maxRight:=$right
		
		  //OBJECT GET COORDINATES(vIndirizzo;$left;$top;$right;$bottom)
		  //OBJECT GET BEST SIZE(vIndirizzo;$bestWidth;$bestHeigth)
		  //OBJECT MOVE(vIndirizzo;0;0;-($right-$left-$bestWidth);0)
		  //OBJECT GET COORDINATES(vIndirizzo;$left;$top;$right;$bottom)
		  //$maxRight:=Choose($right>$maxRight;$right;$maxRight)
		
		  //OBJECT GET COORDINATES(vTelefonoFax;$left;$top;$right;$bottom)
		  //OBJECT GET BEST SIZE(vTelefonoFax;$bestWidth;$bestHeigth)
		  //OBJECT MOVE(vTelefonoFax;0;0;-($right-$left-$bestWidth);0)
		  //OBJECT GET COORDINATES(vTelefonoFax;$left;$top;$right;$bottom)
		  //$maxRight:=Choose($right>$maxRight;$right;$maxRight)
		
		  //OBJECT MOVE(*;"testata@";wPaper-$maxRight-$delta;0)
		
		  //OBJECT GET COORDINATES(*;"rettangoloTestata";$left;$top;$right;$bottom)
		  //OBJECT MOVE(*;"rettangoloTestata";0;0;wPaper-$right-$delta)
		
		
		  //OBJECT MOVE(*;"parteMobile@";wPaper-$right-$delta;0)
		  //OBJECT MOVE(*;"parteRidimensionabile@";0;0;wPaper-$right-$delta)
		
		
		  //colori
		  //------------------------------------------------------------------------------------------------
		  //Case of 
		  //: (Num(stQuantitaEvasa)=0)
		  //$colore:=Red
		  //: (Num(stQuantitaEvasa)<Num(stQuantitaConfermata))
		  //$colore:=Orange
		  //Else 
		  //$colore:=Black
		  //End case 
		  //OBJECT SET COLOR(stNumeroOrdineCliente;-($colore+(256*White)))
		  //OBJECT SET COLOR(stNumeroOrdineCliente;-($colore+(256*White)))
		  //OBJECT SET COLOR(stNumeroOrdine;-($colore+(256*White)))
		  //OBJECT SET COLOR(stDataOrdine;-($colore+(256*White)))
		  //OBJECT SET COLOR(stCodiceArticoloGcc;-($colore+(256*White)))
		  //OBJECT SET COLOR(stCodiceArticoloSM;-($colore+(256*White)))
		  //OBJECT SET COLOR(stDescrizione;-($colore+(256*White)))
		  //OBJECT SET COLOR(stModello;-($colore+(256*White)))
		  //OBJECT SET COLOR(stMarchio;-($colore+(256*White)))
		  //OBJECT SET COLOR(stPrezzo;-($colore+(256*White)))
		  //OBJECT SET COLOR(stQuantita;-($colore+(256*White)))
		  //OBJECT SET COLOR(stQuantitaConfermata;-($colore+(256*White)))
		  //OBJECT SET COLOR(stQuantitaEvasa;-($colore+(256*White)))
		  //OBJECT SET COLOR(stImportoTotale;-($colore+(256*White)))
		  //OBJECT SET COLOR(stDdt;-($colore+(256*White)))
		
End case 

