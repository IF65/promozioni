//%attributes = {}
  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 23/03/20, 17:53:40
  // ----------------------------------------------------
  // Method: utlCreaPmtDaTemplate
  // Description
  //
  //$id:="8102"
  //$dataInizio:=Replace string(Substring(String(!2020-03-23!;ISO date);1;10);"-";"")
  //$dataFine:=Replace string(Substring(String(!2020-04-05!;ISO date);1;10);"-";"")
  //$soglia:=String(12*100)
  //$punti:=String(250)
  //$barcode:="29907564"
  //$reparti:="2;200;210;250"//separati da ; ma l'ultimo non deve avere ;
  //
  // Parameters
  // ----------------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($1)  //id
C_DATE:C307($2;$3)
C_REAL:C285($4)  //soglia
C_LONGINT:C283($5)  //punti
C_TEXT:C284($6)  //barcode
C_POINTER:C301($7)  //reparti

$0:=""
If (Count parameters:C259>=6)
	$id:=$1
	$dataInizio:=Replace string:C233(Substring:C12(String:C10($2;ISO date:K1:8);1;10);"-";"")
	$dataFine:=Replace string:C233(Substring:C12(String:C10($3;ISO date:K1:8);1;10);"-";"")
	$soglia:=String:C10(Round:C94($4*100;0))
	$punti:=String:C10(Round:C94($5;0))
	$barcode:=$6
	$template:="3.01.02,A,@id0,7,Accelera Punti,@dataInizio,0,@dataFine,2359,1,0,8,,,,,0,99,0,0,1,;,0,0,1,0,0,0,0,0,0,4,0,0,127,0,2359,,,,,,,,,,,,0,0,2,0,0,0,0,0,6,1,5,1,0,0,0,,,,,,,,,,,,0,0,3,0,0,0,0,0,3,1,0,@soglia,0,0,0,,,,,,,,,,,,0,0,4,0,1,0,0,0,6,0,0,@punti,0,0,"+"1"+",1,0,4,1,@barcode;,;,;,;,;,;,1;Accelera Punti                          ;006;00;000;00:ACPTI@id G1;          ;,;,;,;,;,;,0,0,5,0,1,0,64,0,16,0,300811,@punti,0,0,1,1,0,4,1,@barcode;,;,;,;,;,;,1;Accelera Punti                          ;016;00;000;       "+"        ;          ;,;,;,;,;,;,0,0,6,0,1,0,0,0,16,0,300812,@punti,0,0,1,1,0,4,1,@barcode;,;,;,;,;,;,1;Accelera Punti                          ;016;00;000;               ;          ;,;,;,;,;,;,0,0,7,0,1,0,0,0,29,0,0,0,0,0,1,1,0,4,1,@barcode;,;,;,;,;,;,"+"1;Accelera Punti                          ;136;00;000;               ;          ;__00:ACPTI@id G1,;,;,;,;,;,0,0"
	
	If (Count parameters:C259=7)
		$reparti:=""
		For ($i;1;Size of array:C274($7->))
			$reparti:=$reparti+$7->{$i}
			If ($i<Size of array:C274($7->))
				$reparti:=$reparti+";"
			End if 
		End for 
		$tmpl1:="3.01.02,A,@id0,3,Accelera Punti,@dataInizio,0,@dataFine,2359,0,0,0,,,,,0,50,0,0,1,;,0,0,1,0,0,0,0,0,0,4,0,0,127,0,2359,,,,,,,,,,,,0,0,2,0,0,0,0,0,6,1,5,1,0,0,0,,,,,,,,,,,,0,0,3,0,1,0,64,0,17,0,9@id,100,0,0,1,1,0,4,1,;,@reparti;,;,;,;,;,0;Accelera Punt"+"i                          ;017;00;000;               ;          ;,;,;,;,;,;,0,0"
		$tmpl2:="3.01.02,A,@id1,7,Accelera Punti,@dataInizio,0,@dataFine,2359,1,0,0,,,,,0,3,0,0,1,;,0,0,1,0,0,0,0,0,0,4,0,0,127,0,2359,,,,,,,,,,,,0,0,2,0,0,0,0,0,6,1,5,1,0,0,0,,,,,,,,,,,,0,0,3,0,0,0,4,0,6,1,9@id,@soglia,0,0,0,,,,,,,,,,,,0,0,4,0,1,0,0,0,6,0,0,@punti,0,"+"0"+",1,1,0,4,1,@barcode;,;,;,;,;,;,1;Accelera Punti                          ;006;00;000;00:ACPTI@id G1;          ;,;,;,;,;,;,0,0,5,0,1,0,64,0,16,0,300811,@punti,0,0,1,1,0,4,1,@barcode;,;,;,;,;,;,1;Accelera Punti                          ;016;00;000;     "+"          ;          ;,;,;,;,;,;,0,0,6,0,1,0,0,0,16,0,300812,@punti,0,0,1,1,0,4,1,@barcode;,;,;,;,;,;,1;Accelera Punti                          ;016;00;000;               ;          ;,;,;,;,;,;,0,0,7,0,1,0,0,0,29,0,0,0,0,0,1,1,0,4,1,@barcode;,;,;,;,;,"+";,1;Accelera Punti                          ;136;00;000;               ;          ;__00:ACPTI@id G1,;,;,;,;,;,0,0"
		$template:=$tmpl1+"\n"+$tmpl2
	End if 
	
	
	$template:=Replace string:C233($template;"@id";$id)
	$template:=Replace string:C233($template;"@dataInizio";$dataInizio)
	$template:=Replace string:C233($template;"@dataFine";$dataFine)
	$template:=Replace string:C233($template;"@soglia";$soglia)
	$template:=Replace string:C233($template;"@punti";$punti)
	$template:=Replace string:C233($template;"@barcode";$barcode)
	If (Count parameters:C259=7)
		$template:=Replace string:C233($template;"@reparti";$reparti)
	End if 
	
	$0:=$template+"\n"
End if 





