//%attributes = {}
// ----------------------------------------------------
// User name (OS): if65
// Date and time: 20/08/19, 10:11:28
// ----------------------------------------------------
// Method: pfSceltaSedi
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_LONGINT:C283($2)

$azione:=""
If (Count parameters:C259>=1)
	$azione:=$1
End if 

Case of 
	: ($azione="")
		C_LONGINT:C283(<>sceltaSedi)
		If (<>sceltaSedi=0)
			<>sceltaSedi:=New process:C317("pfSceltaSedi"; 1024*1024; "Scelta Sedi"; "creaFinestra")
		Else 
			SHOW PROCESS:C325(<>sceltaSedi)
			BRING TO FRONT:C326(<>sceltaSedi)
		End if 
	: ($azione="creaFinestra")
		pfSceltaSedi("inizializza")
		$wRef:=Open form window:C675("pfSceltaSedi"; Sheet form window:K39:12; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("pfSceltaSedi")
		If (ok=1)
			
		End if 
End case 
