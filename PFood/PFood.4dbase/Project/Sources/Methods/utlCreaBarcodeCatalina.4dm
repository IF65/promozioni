//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 11/07/19, 12:30:10
  // ----------------------------------------------------
  // Method: utlCreaBarcodeCatalina
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)  //tipo
C_LONGINT:C283($2)  //promovar
C_REAL:C285($3)  //importo

$0:=""

$barcode:=""
C_LONGINT:C283($cin)

$tipo:="0492"
$progressivo:=1208
$importo:=30
If (Count parameters:C259=3)
	$tipo:=$1
	$progressivo:=$2
	$importo:=$3
End if 

Case of 
	: ($tipo="0503")
		$barcode:="9882"
		$barcode:=$barcode+String:C10($progressivo;"0000")
		$barcode:=$barcode+String:C10(Int:C8($importo*100);"0000")
		
	: ($tipo="0481")
		$barcode:="9872"
		$barcode:=$barcode+String:C10($progressivo;"0000")
		$barcode:=$barcode+String:C10(Int:C8($importo*10);"0000")
		
	: ($tipo="0492")
		  //percentuale espressa come 30,5 %
		  //nessuna promovar utilizzata
		$barcode:="977011"
		$barcode:=$barcode+String:C10(Int:C8($importo*10);"000000")
		
End case 

If ($barcode#"")
	$sommaPari:=Num:C11(Substring:C12($barcode;2;1))
	$sommaPari:=$sommaPari+Num:C11(Substring:C12($barcode;4;1))
	$sommaPari:=$sommaPari+Num:C11(Substring:C12($barcode;6;1))
	$sommaPari:=$sommaPari+Num:C11(Substring:C12($barcode;8;1))
	$sommaPari:=$sommaPari+Num:C11(Substring:C12($barcode;10;1))
	$sommaPari:=$sommaPari+Num:C11(Substring:C12($barcode;12;1))
	
	$sommaDispari:=Num:C11(Substring:C12($barcode;1;1))
	$sommaDispari:=$sommaDispari+Num:C11(Substring:C12($barcode;3;1))
	$sommaDispari:=$sommaDispari+Num:C11(Substring:C12($barcode;5;1))
	$sommaDispari:=$sommaDispari+Num:C11(Substring:C12($barcode;7;1))
	$sommaDispari:=$sommaDispari+Num:C11(Substring:C12($barcode;9;1))
	$sommaDispari:=$sommaDispari+Num:C11(Substring:C12($barcode;11;1))
	
	$somma:=($sommaPari*3)+$sommaDispari
	$cin:=10-Choose:C955(($somma%10)#0;$somma%10;10)  //ceiling(10)
	
	$0:=$barcode+String:C10($cin)
End if 
