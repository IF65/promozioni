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
			<>sceltaSedi:=New process:C317("pfSceltaSedi";1024*1024;"Scelta Sedi";"creaFinestra")
		Else 
			SHOW PROCESS:C325(<>sceltaSedi)
			BRING TO FRONT:C326(<>sceltaSedi)
		End if 
	: ($azione="creaFinestra")
		pfSceltaSedi ("inizializza")
		$wRef:=Open form window:C675("pfSceltaSedi";Sheet form window:K39:12;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfSceltaSedi")
		If (ok=1)
			
		End if 
	: ($azione="inizializza")
		If (Undefined:C82(<>sediSelezionate))
			ARRAY TEXT:C222(<>sediSelezionate;0)
		End if 
		
		ARRAY TEXT:C222(arSE_codice;0)
		ARRAY TEXT:C222(arSE_descrizione;0)
		ARRAY BOOLEAN:C223(arSE_selezionata;0)
		
		For ($i;1;Size of array:C274(<>sedi))
			APPEND TO ARRAY:C911(arSE_codice;<>sedi{$i}.codice)
			APPEND TO ARRAY:C911(arSE_descrizione;<>sedi{$i}.codice+" - "+<>sedi{$i}.negozio_descrizione)
			If (Find in array:C230(<>sediSelezionate;<>sedi{$i}.codice)>0)
				APPEND TO ARRAY:C911(arSE_selezionata;True:C214)
			Else 
				APPEND TO ARRAY:C911(arSE_selezionata;False:C215)
			End if 
		End for 
		
	: ($azione="salva")
		ARRAY TEXT:C222(<>sediSelezionate;0)
		For ($i;1;Size of array:C274(arSE_codice))
			If (arSE_selezionata{$i})
				APPEND TO ARRAY:C911(<>sediSelezionate;arSE_codice{$i})
			End if 
		End for 
		
End case 
