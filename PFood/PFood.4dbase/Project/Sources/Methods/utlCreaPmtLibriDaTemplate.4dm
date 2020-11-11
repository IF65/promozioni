//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 29/06/20, 15:16:24
  // ----------------------------------------------------
  // Method: utlCreaPmtLibriDaTemplate
  // Description
  // 
  // Parameters
  // ----------------------------------------------------
  // $codice1:="70000"
  // $codice2:="70001"
  // $codice3:="70002"
  // $codice4:="70003"
  // $dataInizio:="20200629"
  // $dataFine:="20201231"
  // $promoVarPerTotale:="1468"
  // $promoVarPerBuono:="1469"
  // $barcode:="2099990000006"
  // $percentualeSconto:="15"
  //

C_TEXT:C284($0)

C_LONGINT:C283($1;$2;$3;$4)  //codici promo
C_DATE:C307($5;$6)
C_LONGINT:C283($7;$8)  //promovar
C_TEXT:C284($9)  //barcode
C_LONGINT:C283($10)  //percentuale x buono

$0:=""

If (Count parameters:C259=10)
	$codice1:=String:C10($1)
	$codice2:=String:C10($2)
	$codice3:=String:C10($3)
	$codice4:=String:C10($4)
	$dataInizio:=Replace string:C233(Substring:C12(String:C10($5;ISO date:K1:8);1;10);"-";"")
	$dataFine:=Replace string:C233(Substring:C12(String:C10($6;ISO date:K1:8);1;10);"-";"")
	$promoVarPerTotale:=String:C10($7)
	$promoVarPerBuono:=String:C10($8)
	$barcode:=$9
	$percentualeSconto:=String:C10($10)
	
	$template:=""
	$template:=$template+"3.01.02,A,@codice1,1,LIBRI DI TESTO,@dataInizio,0,@dataFine,2359,0,0,0,,,,,0,99,0,0,1,;,0,0,1,0,1,0,64,0,17,0,97000,10000,0,0,1,1,0,4,1,@barcode;,;,;,;,;,;,1;BUONO SCONTO                            ;017;00;000;               ;          ;,;,;,;,;,"+";,0,0\n"
	$template:=$template+"3.01.02,A,@codice2,5,LIBRI DI TESTO,@dataInizio,0,@dataFine,2359,0,0,0,,,,,0,50,0,0,1,;,0,0,1,0,0,0,0,0,0,4,0,0,127,0,2359,,,,,,,,,,,,0,0,2,0,0,0,0,0,6,1,5,1,0,0,0,,,,,,,,,,,,0,0,3,0,0,0,0,0,9,1,0,0,0,0,0,,,,,,,,,,,,0,0,4,0,0,0,0,0,6,0,97000,100,0,0,0"+",,,,,,,,,,,,0,0,5,0,1,0,64,0,16,0,9986@promoVarPerTotale,@percentualeSconto,0,0,1,1,0,4,1,;,;,;,;,;,;,1;BUONO SCONTO                            ;016;00;000;               ;          ;,;,;,;,;,;,0,0\n"
	$template:=$template+"3.01.02,A,@codice3,5,LIBRI DI TESTO,@dataInizio,0,@dataFine,2359,0,0,0,,,,,0,50,0,0,1,;,0,0,1,0,0,0,0,0,0,4,0,0,127,0,2359,,,,,,,,,,,,0,0,2,0,0,0,0,0,6,1,5,0,0,0,0,,,,,,,,,,,,0,0,3,0,0,0,0,0,9,1,0,0,0,0,0,,,,,,,,,,,,0,0,4,0,0,0,0,0,6,0,9986@promoVarPe"+"rTotale,100,0,0,0,,,,,,,,,,,,0,0,5,0,1,0,64,0,16,0,9987@promoVarPerTotale,1,0,0,1,1,0,4,1,;,;,;,;,;,;,1;BUONO SCONTO                            ;016;00;000;               ;          ;,;,;,;,;,;,0,0\n"
	$template:=$template+"3.01.02,A,@codice4,3,LIBRI DI TESTO,@dataInizio,0,@dataFine,2359,0,0,0,,,,,0,30,0,0,1,;,0,0,1,0,0,0,0,0,0,4,0,0,127,0,2359,,,,,,,,,,,,0,0,2,0,0,0,0,0,6,1,5,0,0,0,0,,,,,,,,,,,,0,0,3,0,1,0,0,0,22,0,0,0,0,0,1,1,0,4,1,;,;,;,;,;,;,1;BUONO SCONTO           "+"                 ;022;00;000;               ;          ;&NfBegin&$NewLine$LIBRI DI TESTO$NewLine$ORDINA RISPARMIA E IMPARA$NewLine$$NewLine$BUONO SCONTO$NewLine$Vale EURO &Amt_9987@promoVarPerTotale&$NewLine$$NewLine$Valido solo in questo negozio$NewL"+"ine$entro 30 giorni$NewLine$dalla data di emissione$NewLine$&Barcode_9872@promoVarPerBuono& &NfEnd&,;,;,;,;,;,0,0\n"
	
	$template:=Replace string:C233($template;"@codice1";$codice1)
	$template:=Replace string:C233($template;"@codice2";$codice2)
	$template:=Replace string:C233($template;"@codice3";$codice3)
	$template:=Replace string:C233($template;"@codice4";$codice4)
	$template:=Replace string:C233($template;"@dataInizio";$dataInizio)
	$template:=Replace string:C233($template;"@dataFine";$dataFine)
	$template:=Replace string:C233($template;"@promoVarPerTotale";$promoVarPerTotale)
	$template:=Replace string:C233($template;"@promoVarPerBuono";$promoVarPerBuono)
	$template:=Replace string:C233($template;"@barcode";$barcode)
	$template:=Replace string:C233($template;"@percentualeSconto";$percentualeSconto)
	
	$0:=$template
End if 

  //SET TEXT TO PASTEBOARD($template)






