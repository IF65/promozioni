//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 06/09/17, 12:59:27
  // ----------------------------------------------------
  // Method: setupStampante
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($0)  //tipo stampa: -1=Stampa Annullata, 0=Stampante, 1=PDF, 2=EXCEL, 3=TXT;
C_POINTER:C301($1)  //file name

$currentPrinter:=Get current printer:C788

ARRAY TEXT:C222(arPrinterNames;0)
ARRAY TEXT:C222($arAlternatePrinterNames;0)
ARRAY TEXT:C222($arPrinterModels;0)
PRINTERS LIST:C789(arPrinterNames;$arAlternatePrinterNames;$arPrinterModels)
INSERT IN ARRAY:C227(arPrinterNames;1;4)
arPrinterNames{1}:="PDF"
arPrinterNames{2}:="EXCEL"
arPrinterNames{3}:="TXT"
arPrinterNames{4}:="-"
If (Size of array:C274(arPrinterNames)>1)
	arPrinterNames:=Find in array:C230(arPrinterNames;$currentPrinter)
	$wRef:=Open form window:C675("setupStampante";Movable form dialog box:K39:8;Horizontally centered:K39:1;Vertically centered:K39:4)
	DIALOG:C40("setupStampante")
	If (ok=1)
		If (arPrinterNames>3) & ($currentPrinter#arPrinterNames{arPrinterNames})
			SET CURRENT PRINTER:C787(arPrinterNames{arPrinterNames})
		End if 
		
		If (Count parameters:C259>=1)
			$1->:=$1->+"_"+Replace string:C233(Replace string:C233(String:C10(Current date:C33(*);ISO date:K1:8;Current time:C178(*));":";"");"-";"")
		End if 
		
		Case of 
			: (arPrinterNames=1)  //PDF
				$0:=1
			: (arPrinterNames=2)  //EXCEL
				$0:=2
			: (arPrinterNames=3)  //TXT
				$0:=3
			Else 
				$0:=0
		End case 
	Else 
		$0:=-1
	End if 
	
	CLOSE WINDOW:C154($wRef)
End if 