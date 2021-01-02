//%attributes = {}

// ----------------------------------------------------
// User name (OS): if65
// Date and time: 28/12/20, 11:12:43
// ----------------------------------------------------
// Method: pfExcelReport
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)

$azione:=""
If (Count parameters:C259=1)
	$azione:=$1
End if 

Case of 
	: ($azione="")
		C_LONGINT:C283(<>excelReport)
		If (<>excelReport=0)
			<>excelReport:=New process:C317("pfExcelReport"; 1024*1024; "Report"; "creaFinestra"; *)
		Else 
			SHOW PROCESS:C325(<>excelReport)
			BRING TO FRONT:C326(<>excelReport)
		End if 
	: ($azione="creaFinestra")
		$wRef:=Open form window:C675("pfExcelReport"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("pfExcelReport")
End case 
