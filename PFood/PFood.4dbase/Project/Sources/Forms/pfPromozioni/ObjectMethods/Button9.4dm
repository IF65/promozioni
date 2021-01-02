$fileName:="promozioni"

$tipo_stampa:=setupStampante (->$fileName)
Case of 
	: ($tipo_stampa=0)  //stampa fisica
		
	: ($tipo_stampa=1)  //PDF
		SET PRINTABLE MARGIN:C710(0;0;0;0)
		SET PRINT OPTION:C733(Orientation option:K47:2;0)  //Landscape
		SET PRINT OPTION:C733(Paper option:K47:1;"A4")
		SET PRINT OPTION:C733(Scale option:K47:3;100)
		$fileName:=System folder:C487(Desktop:K41:16)+"TEST_"+Replace string:C233(Time string:C180(Current time:C178);":";"")+".pdf"
		SET PRINT OPTION:C733(Destination option:K47:7;1)  //3;$fileName)
		pfPromozioni ("Stampa")
		
	: ($tipo_stampa=2)  //EXCEL
	: ($tipo_stampa=3)  //TXT
		  //pfPromozioni("exportTXT")
	Else 
		  //stampa annullata
End case 
