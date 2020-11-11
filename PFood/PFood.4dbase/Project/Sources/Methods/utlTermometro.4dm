//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 25/08/17, 15:59:55
  // ----------------------------------------------------
  // Method: termometro
  // Description
  //
  //
  // Parameters
  // ----------------------------------------------------


Case of 
	: ($1="apri")
		<>termometro:=False:C215
		If (Count parameters:C259>1)
			<>vStato:=$2
		Else 
			<>vStato:=""
		End if 
		$0:=New process:C317("procMostraTermometro";64*1024;"procMostraTermometro";*)
		
	: ($1="mostra")
		<>vStato:=$2
		
	: ($1="chiudi")
		<>termometro:=True:C214
End case 