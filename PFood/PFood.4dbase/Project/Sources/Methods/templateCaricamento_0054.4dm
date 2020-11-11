//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 26/03/20, 10:43:31
  // ----------------------------------------------------
  // Method: templateCaricamento_0054
  // Description
  // Attenzione ai gruppi se si vuole una promo che scatti 
  // all'acquisto di 2 (o più) articoli tra n si usa solo 
  // gruppo 1
  //
  // Parameters
  // ----------------------------------------------------

C_BOOLEAN:C305($0)

C_LONGINT:C283($1)
C_TEXT:C284($2)
C_REAL:C285($3)
C_DATE:C307($4;$5)
C_TEXT:C284($6;$7;$8;$9;$10;$11)

$0:=False:C215

If (Count parameters:C259=11)
	$idIF65:=$1
	$denominazione:=$2
	$percentuale:=$3
	$dataInizio:=$4
	$dataFine:=$5
	ARRAY TEXT:C222($barcodeGruppo1;0)
	utlExplode ($6;->$barcodeGruppo1;";")
	ARRAY TEXT:C222($barcodeGruppo2;0)
	utlExplode ($7;->$barcodeGruppo2;";")
	ARRAY TEXT:C222($codiciArticoloGruppo1;0)
	utlExplode ($8;->$codiciArticoloGruppo1;";")
	ARRAY TEXT:C222($codiciArticoloGruppo2;0)
	utlExplode ($9;->$codiciArticoloGruppo2;";")
	ARRAY TEXT:C222($aderenti;0)
	utlExplode ($10;->$aderenti;";")
	$aderentiGruppo:=$11
	
	$promoOk:=True:C214
	
	If ($promoOk)
		$codicePromozione:=utlProgressivoCrea (<>progPromozione)
		$promoVar:=utlProgressivoCrea (<>progPromovarPI)
		
		C_OBJECT:C1216($promozione)
		$idPromozione:=Generate UUID:C1066
		OB SET:C1220($promozione;"id";$idPromozione)
		OB SET:C1220($promozione;"codice";$codicePromozione)
		OB SET:C1220($promozione;"codiceCatalina";$idIF65)
		OB SET:C1220($promozione;"tipo";"0054")
		OB SET:C1220($promozione;"descrizione";$denominazione)
		OB SET:C1220($promozione;"ripetibilita";1)
		OB SET:C1220($promozione;"dataInizio";$dataInizio)
		OB SET:C1220($promozione;"dataFine";$dataFine)
		OB SET:C1220($promozione;"oraInizio";"00:00:00")
		OB SET:C1220($promozione;"oraFine";"23:59:00")
		OB SET:C1220($promozione;"calendarioSettimanale";"1111111")
		OB SET:C1220($promozione;"tipoCliente";1)
		OB SET:C1220($promozione;"categoria";0)
		OB SET:C1220($promozione;"sottoreparti";0)
		OB SET:C1220($promozione;"bozza";0)
		OB SET:C1220($promozione;"stampato";0)
		OB SET:C1220($promozione;"pmt";0)
		OB SET:C1220($promozione;"barcode";"")
		OB SET:C1220($promozione;"testo";"")
		
		C_OBJECT:C1216($ricompensa)
		ARRAY OBJECT:C1221($ricompense;0)
		OB SET:C1220($ricompensa;"id";Generate UUID:C1066)
		OB SET:C1220($ricompensa;"idPromozioni";$idPromozione)
		OB SET:C1220($ricompensa;"soglia";0)
		OB SET:C1220($ricompensa;"ammontare";$percentuale)
		OB SET:C1220($ricompensa;"limiteSconto";0)
		OB SET:C1220($ricompensa;"taglio";0)
		OB SET:C1220($ricompensa;"descrizione";"SCONTO")
		OB SET:C1220($ricompensa;"recordM";"00:0054-"+String:C10($codicePromozione))
		OB SET:C1220($ricompensa;"accumulatore";"")
		OB SET:C1220($ricompensa;"promovar";$promoVar)
		OB SET:C1220($ricompensa;"tipoArea";0)
		OB SET:C1220($ricompensa;"ordinamentoInArea";0)
		OB SET:C1220($ricompensa;"progressivo";0)
		APPEND TO ARRAY:C911($ricompense;$ricompensa)
		OB SET ARRAY:C1227($promozione;"ricompense";$ricompense)
		
		C_OBJECT:C1216($articolo)
		ARRAY OBJECT:C1221($articoli;0)
		For ($i;1;Size of array:C274($barcodeGruppo1))
			$barcodeJson:=utlEsplosioneBarcode ($barcodeGruppo1{$i})
			ARRAY OBJECT:C1221($barcode;0)
			JSON PARSE ARRAY:C1219($barcodeJson;$barcode)
			For ($j;1;Size of array:C274($barcode))
				CLEAR VARIABLE:C89($articolo)
				OB SET:C1220($articolo;"id";Generate UUID:C1066)
				OB SET:C1220($articolo;"idPromozioni";$idPromozione)
				OB SET:C1220($articolo;"codiceArticolo";OB Get:C1224($barcode{$j};"codice";Is text:K8:3))
				OB SET:C1220($articolo;"codiceReparto";"")
				OB SET:C1220($articolo;"barcode";OB Get:C1224($barcode{$j};"barcode";Is text:K8:3))
				OB SET:C1220($articolo;"descrizione";OB Get:C1224($barcode{$j};"descrizione";Is text:K8:3))
				OB SET:C1220($articolo;"molteplicita";1)
				OB SET:C1220($articolo;"gruppo";1)
				APPEND TO ARRAY:C911($articoli;$articolo)
			End for 
		End for 
		For ($i;1;Size of array:C274($barcodeGruppo2))
			$barcodeJson:=utlEsplosioneBarcode ($barcodeGruppo2{$i})
			ARRAY OBJECT:C1221($barcode;0)
			JSON PARSE ARRAY:C1219($barcodeJson;$barcode)
			For ($j;1;Size of array:C274($barcode))
				CLEAR VARIABLE:C89($articolo)
				OB SET:C1220($articolo;"id";Generate UUID:C1066)
				OB SET:C1220($articolo;"idPromozioni";$idPromozione)
				OB SET:C1220($articolo;"codiceArticolo";OB Get:C1224($barcode{$j};"codice";Is text:K8:3))
				OB SET:C1220($articolo;"codiceReparto";"")
				OB SET:C1220($articolo;"barcode";OB Get:C1224($barcode{$j};"barcode";Is text:K8:3))
				OB SET:C1220($articolo;"descrizione";OB Get:C1224($barcode{$j};"descrizione";Is text:K8:3))
				OB SET:C1220($articolo;"molteplicita";1)
				OB SET:C1220($articolo;"gruppo";2)
				APPEND TO ARRAY:C911($articoli;$articolo)
			End for 
		End for 
		
		OB SET ARRAY:C1227($promozione;"articoli";$articoli)
		
		$negoziJson:=utlElencoNegozi 
		C_OBJECT:C1216($sede)
		ARRAY OBJECT:C1221($sedi;0)
		If ($negoziJson#"")
			ARRAY OBJECT:C1221($negozi;0)
			JSON PARSE ARRAY:C1219($negoziJson;$negozi)
			For ($i;1;Size of array:C274($negozi))
				$dataApertura:=OB Get:C1224($negozi{$i};"data_inizio";Is date:K8:7)
				$dataChiusura:=OB Get:C1224($negozi{$i};"data_fine";Is date:K8:7)
				$codice:=OB Get:C1224($negozi{$i};"codice";Is text:K8:3)
				If (utlMatchRegex ("^(?:01|04|05|31|36)";$codice))
					If ($dataChiusura=!00-00-00!)
						CLEAR VARIABLE:C89($sede)
						OB SET:C1220($sede;"id";Generate UUID:C1066)
						OB SET:C1220($sede;"idPromozioni";$idPromozione)
						OB SET:C1220($sede;"codiceSede";$codice)
						APPEND TO ARRAY:C911($sedi;$sede)
					End if 
				End if 
			End for 
		End if 
		OB SET ARRAY:C1227($promozione;"sedi";$sedi)
		
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"salva")
		OB SET:C1220($request;"promozione";$promozione)
		
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
			$0:=True:C214
		End if 
	End if 
	
End if 
