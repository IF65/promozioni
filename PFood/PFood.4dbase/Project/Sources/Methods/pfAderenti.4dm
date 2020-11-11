//%attributes = {}
  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 20/08/19, 10:11:28
  // ----------------------------------------------------
  // Method: pfAderenti
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_BOOLEAN:C305($0)

C_TEXT:C284($1)
C_LONGINT:C283($2)

$azione:=""
If (Count parameters:C259>=1)
	$azione:=$1
End if 

Case of 
	: ($azione="")
		C_LONGINT:C283(<>aderentiWinRef)
		If (<>aderentiWinRef=0)
			<>aderentiWinRef:=New process:C317("pfAderenti";1024*1024;"Scelta Sedi";"creaFinestra";*)
		Else 
			SHOW PROCESS:C325(<>aderentiWinRef)
			BRING TO FRONT:C326(<>aderentiWinRef)
		End if 
	: ($azione="creaFinestra")
		pfAderenti ("inizializza")
		$wRef:=Open form window:C675("pfAderenti";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfAderenti")
		If (ok=1)
			
		End if 
	: ($azione="inizializza")
		ARRAY TEXT:C222(arAD_id;0)
		ARRAY TEXT:C222(arAD_descrizione;0)
		ARRAY TEXT:C222(arAD_sedeCodice;0)
		ARRAY LONGINT:C221(arAD_displayedLevel;0)
		ARRAY LONGINT:C221(arAD_expanded;0)
		
	: ($azione="inizializzaSedi")
		ARRAY TEXT:C222(arADS_sedeCodice;0)
		ARRAY TEXT:C222(arADS_descrizione;0)
		
	: ($azione="caricaArray")
		pfAderenti ("inizializza")
		For ($i;1;Size of array:C274(<>aderenti))
			APPEND TO ARRAY:C911(arAD_id;OB Get:C1224(<>aderenti{$i};"id";Is text:K8:3))
			APPEND TO ARRAY:C911(arAD_descrizione;OB Get:C1224(<>aderenti{$i};"descrizione";Is text:K8:3))
			APPEND TO ARRAY:C911(arAD_sedeCodice;"")
			APPEND TO ARRAY:C911(arAD_displayedLevel;0)
			APPEND TO ARRAY:C911(arAD_expanded;0)
			
			ARRAY OBJECT:C1221($sedi;0)
			OB GET ARRAY:C1229(<>aderenti{$i};"sedi";$sedi)
			For ($j;1;Size of array:C274($sedi))
				APPEND TO ARRAY:C911(arAD_id;OB Get:C1224(<>aderenti{$i};"id";Is text:K8:3))
				APPEND TO ARRAY:C911(arAD_descrizione;OB Get:C1224($sedi{$j};"codice";Is text:K8:3)+" - "+OB Get:C1224($sedi{$j};"descrizione";Is text:K8:3))
				APPEND TO ARRAY:C911(arAD_sedeCodice;OB Get:C1224($sedi{$j};"codice";Is text:K8:3))
				APPEND TO ARRAY:C911(arAD_displayedLevel;1)
				APPEND TO ARRAY:C911(arAD_expanded;0)
			End for 
			
		End for 
		
	: ($azione="caricaArraySedi")
		pfAderenti ("inizializzaSedi")
		
		ARRAY TEXT:C222(arADS_sedeCodice;0)
		ARRAY TEXT:C222(arADS_descrizione;0)
		ARRAY BOOLEAN:C223(arADS_sottoreparti;0)
		ARRAY TEXT:C222(arADS_marchio;0)
		ARRAY TEXT:C222(arADS_societa_descrizione;0)
		
		For ($i;1;Size of array:C274(<>sedi))
			If (<>sedi{$i}.abilita="1")
				APPEND TO ARRAY:C911(arADS_sedeCodice;<>sedi{$i}.codice)
				APPEND TO ARRAY:C911(arADS_descrizione;<>sedi{$i}.negozio_descrizione)
				APPEND TO ARRAY:C911(arADS_sottoreparti;(<>sedi{$i}.sottoreparti="1"))
				APPEND TO ARRAY:C911(arADS_marchio;<>sedi{$i}.marchio)
				APPEND TO ARRAY:C911(arADS_societa_descrizione;<>sedi{$i}.societa_descrizione)
			End if 
		End for 
		SORT ARRAY:C229(arADS_sedeCodice;arADS_descrizione;>)
		
	: ($azione="salva")
		
		C_OBJECT:C1216($aderente)
		OB SET:C1220($aderente;"id";<>aderenti{aderenteSelezionato}.id)
		OB SET:C1220($aderente;"descrizione";<>aderenti{aderenteSelezionato}.descrizione)
		
		ARRAY OBJECT:C1221($sedi;0)
		OB GET ARRAY:C1229(<>aderenti{aderenteSelezionato};"sedi";$sedi)
		OB SET ARRAY:C1227($aderente;"sedi";$sedi)
		
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"salvaAderente")
		OB SET:C1220($request;"aderente";$aderente)
		
		$body:=JSON Stringify:C1217($request)
		  //SET TEXT TO PASTEBOARD($body)
		
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse=200) & (<>error=0)
			$0:=True:C214
		End if 
		
	: ($azione="aggiornaDisplay")
		pfAderenti ("updateDisplay")
		AL_SetAreaLongProperty (alpAderenti;ALP_Area_ScrollTop;0)
		AL_SetAreaLongProperty (alpAderenti;ALP_Area_SelRow;0)
		
	: ($azione="updateDisplay")
		$err:=AL_SetObjects2 (alpAderenti;ALP_Object_Hierarchy;arAD_displayedLevel;arAD_expanded)
		AL_SetAreaLongProperty (alpAderenti;ALP_Area_UpdateData;0)
End case 
