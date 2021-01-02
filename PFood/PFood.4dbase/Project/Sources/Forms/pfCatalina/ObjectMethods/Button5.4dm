$fileName:="promozioni"

$tipo_stampa:=setupStampante (->$fileName)
Case of 
	: ($tipo_stampa=0)  //stampa fisica
	: ($tipo_stampa=1)  //PDF
		pfPromozioni ("Stampa")
	: ($tipo_stampa=2)  //EXCEL
	: ($tipo_stampa=3)  //TXT
		  //pfPromozioni("exportTXT")
	Else 
		  //stampa annullata
End case 
