Case of 
	: (Form event code:C388=On Data Change:K2:15)
		  //b2bOrdiniClienti ("caricaArray")
		  //b2bOrdiniClienti ("totali")
		
		  //AL_SetAreaLongProperty (alpOrd;ALP_Area_UpdateData;0)
		  //AL_SetAreaLongProperty (alpOrd;ALP_Area_ScrollTop;0)
		  //AL_SetAreaLongProperty (alpOrd;ALP_Area_SelRow;0)
		
		  //REDRAW(alpOrd)
	: (Form event code:C388=On Before Keystroke:K2:6)
		FILTER KEYSTROKE:C389(Uppercase:C13(Keystroke:C390))
		
End case 

