//%attributes = {}

// ----------------------------------------------------
// User name (OS): if65
// Date and time: 05/07/19, 11:14:04
// ----------------------------------------------------
// Method: pfIncarichi
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
		C_LONGINT:C283(<>incarichi)
		If (<>incarichi=0)
			<>incarichi:=New process:C317("pfIncarichi";1024*1024;"Incarichi";"creaFinestra";*)
		Else 
			SHOW PROCESS:C325(<>incarichi)
			BRING TO FRONT:C326(<>incarichi)
		End if 
	: ($azione="creaFinestra")
		$wRef:=Open form window:C675("pfIncarichi";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfIncarichi")
		
	: ($azione="inizializzaRicerca")
		$currentDate:=Current date:C33(*)
		COPY ARRAY:C226(<>promoTipo;srcTipoPromozione)
		COPY ARRAY:C226(<>promoTipoCodice;srcTipoPromozioneCodice)
		srcTipoPromozione:=1
		srcBozza:=2
		srcUsaDataCorrente:=True:C214
		srcDataCorrente:=$currentDate
		srcDataDa:=Date:C102(String:C10(Year of:C25($currentDate)-1;"0000")+"-01-01T00:00:00")
		srcDataA:=Date:C102(String:C10(Year of:C25($currentDate)+1;"0000")+"-12-31T00:00:00")
		srcCodicePromozione:=0
		srcBarcode:=""
		srcDescrizione:=""
		
	: ($azione="inizializzaArray")
		ARRAY TEXT:C222(arINC_id;0)
		ARRAY TEXT:C222(arINC_idPadre;0)
		ARRAY LONGINT:C221(arINC_codicePromozione;0)
		ARRAY LONGINT:C221(arINC_lavoroCodice;0)
		ARRAY TEXT:C222(arINC_lavoroDescrizione;0)
		ARRAY TEXT:C222(arINC_negozioCodice;0)
		ARRAY TEXT:C222(arINC_negozioDescrizione;0)
		ARRAY LONGINT:C221(arINC_stato;0)
		ARRAY TEXT:C222(arINC_tsCreazione;0)
		ARRAY TEXT:C222(arINC_tsPianificazione;0)
		ARRAY TEXT:C222(arINC_tsEsecuzione;0)
		ARRAY DATE:C224(arINC_data;0)
		ARRAY TEXT:C222(arINC_ora;0)
		
	: ($azione="caricaArray")
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		//parametri
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"elencoIncarichi")
		$body:=JSON Stringify:C1217($request)
		//SET TEXT TO PASTEBOARD($body)
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse=200) & (<>error=0)
			pfIncarichi("inizializzaArray")
			ARRAY OBJECT:C1221($elencoIncarichi;0)
			JSON PARSE ARRAY:C1219($response;$elencoIncarichi)
			For ($i;1;Size of array:C274($elencoIncarichi))
				$pianificazione:=OB Get:C1224($elencoIncarichi{$i};"tsPianificazione";Is text:K8:3)
				$data:=Date:C102(Substring:C12($pianificazione;1;10)+"T00:00:00")
				$ora:=Substring:C12($pianificazione;12;8)
				
				APPEND TO ARRAY:C911(arINC_id;OB Get:C1224($elencoIncarichi{$i};"id";Is text:K8:3))
				APPEND TO ARRAY:C911(arINC_idPadre;OB Get:C1224($elencoIncarichi{$i};"idPadre";Is text:K8:3))
				APPEND TO ARRAY:C911(arINC_codicePromozione;OB Get:C1224($elencoIncarichi{$i};"codicePromozione";Is longint:K8:6))
				APPEND TO ARRAY:C911(arINC_lavoroCodice;OB Get:C1224($elencoIncarichi{$i};"lavoroCodice";Is longint:K8:6))
				APPEND TO ARRAY:C911(arINC_lavoroDescrizione;OB Get:C1224($elencoIncarichi{$i};"lavoroDescrizione";Is text:K8:3))
				APPEND TO ARRAY:C911(arINC_negozioCodice;OB Get:C1224($elencoIncarichi{$i};"negozioCodice";Is text:K8:3))
				APPEND TO ARRAY:C911(arINC_negozioDescrizione;OB Get:C1224($elencoIncarichi{$i};"negozioDescrizione";Is text:K8:3))
				APPEND TO ARRAY:C911(arINC_stato;OB Get:C1224($elencoIncarichi{$i};"stato";Is longint:K8:6))
				APPEND TO ARRAY:C911(arINC_tsCreazione;OB Get:C1224($elencoIncarichi{$i};"tsCreazione";Is text:K8:3))
				APPEND TO ARRAY:C911(arINC_tsPianificazione;$pianificazione)
				APPEND TO ARRAY:C911(arINC_tsEsecuzione;OB Get:C1224($elencoIncarichi{$i};"tsEsecuzione";Is text:K8:3))
				APPEND TO ARRAY:C911(arINC_data;$data)
				APPEND TO ARRAY:C911(arINC_ora;$ora)
			End for 
			SORT ARRAY:C229(arINC_data;arINC_ora;arINC_lavoroCodice;arINC_codicePromozione;arINC_id;arINC_idPadre;\
				arINC_lavoroDescrizione;arINC_negozioCodice;arINC_negozioDescrizione;arINC_stato;arINC_tsCreazione;\
				arINC_tsPianificazione;arINC_tsEsecuzione;>)
		End if 
		
	: ($azione="modificaIncarico")
		
	: ($azione="creaIncarichi")
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		//parametri
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"creaIncarichi")
		OB SET ARRAY:C1227($request;"promozioniDaInviare";incarichi)
		
		$body:=JSON Stringify:C1217($request)
		//SET TEXT TO PASTEBOARD($body)
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse=200) & (<>error=0)
			
		End if 
		
	: ($azione="cancellaIncarichi")
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		//parametri
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"cancellaIncarichi")
		OB SET ARRAY:C1227($request;"incarichiDaCancellare";incarichiDaCancellare)
		
		$body:=JSON Stringify:C1217($request)
		SET TEXT TO PASTEBOARD:C523($body)
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse=200) & (<>error=0)
			
		End if 
		
	: ($azione="aggiornaDisplay")
		pfIncarichi("updateDisplay")
		AL_SetAreaLongProperty(alpIncarichi;ALP_Area_ScrollTop;0)
		AL_SetAreaLongProperty(alpIncarichi;ALP_Area_SelRow;0)
		
	: ($azione="updateDisplay")
		AL_SetAreaLongProperty(alpIncarichi;ALP_Area_UpdateData;0)
		
	: ($azione="stampa")
		
		
End case 
