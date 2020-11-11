//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 22/03/20, 20:30:54
  // ----------------------------------------------------
  // Method: catalinaCaricamento_0481
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_BOOLEAN:C305($0)

C_LONGINT:C283($1)
C_TEXT:C284($2)
C_REAL:C285($3;$4)
C_DATE:C307($5;$6)
C_TEXT:C284($7)

$0:=False:C215

If (Count parameters:C259=7)
	$idCatalina:=$1
	$repartoDescrizione:=$2
	$soglia:=$3
	$importo:=$4
	$dataInizio:=$5
	$dataFine:=$6
	$barcode:=$7
	
	$promoOk:=True:C214
	If ($idCatalina#0)
		ARRAY LONGINT:C221($elencoCodici;0)
		APPEND TO ARRAY:C911($elencoCodici;$idCatalina)
		$elencoCodiciUsatiJson:=utlElencoCodiciCatalinaUsati (->$elencoCodici)
		ARRAY LONGINT:C221($elencoCodiciUsati;0)
		JSON PARSE ARRAY:C1219($elencoCodiciUsatiJson;$elencoCodiciUsati)
		If (Find in array:C230($elencoCodiciUsati;$idCatalina)>0)
			$promoOk:=False:C215
		End if 
	End if 
	
	$promoVar:=0
	If ($barcode#"")
		ARRAY TEXT:C222($matches;0)
		If (utlMatchRegex ("^9872(\\d{4})\\d{5}$";$barcode;->$matches))
			$promoVar:=Num:C11($matches{1})
			$barcodeTest:=utlCreaBarcodeCatalina ("0481";$promoVar;$importo)
			If ($barcodeTest#$barcode)
				$promoOk:=False:C215
			End if 
		Else 
			$promoOk:=False:C215
		End if 
	End if 
	
	If ($promoVar#0)
		$result:=utlProgressivoVerificaEsistenza (<>progPromovarPI;$promoVar)
		If ($result=$promoVar)
			$promoOk:=False:C215
		End if 
	End if 
	
	If (Not:C34(OB Is defined:C1231(<>reparti;$repartoDescrizione)))
		$promoOk:=False:C215
	End if 
	
	If ($promoOk)
		$codicePromozione:=utlProgressivoCrea (<>progPromozione)
		
		If ($promoVar#0)
			$result:=utlProgressivoSalvaCodiceEsiste (<>progPromovarPI;$promoVar)
		Else 
			$promoVar:=utlProgressivoCrea (<>progPromovarPI)
			$barcode:=utlCreaBarcodeCatalina ("0481";$promoVar;$importo)
		End if 
		
		C_OBJECT:C1216($promozione)
		$idPromozione:=Generate UUID:C1066
		OB SET:C1220($promozione;"id";$idPromozione)
		OB SET:C1220($promozione;"codice";$codicePromozione)
		OB SET:C1220($promozione;"codiceCatalina";$idCatalina)
		OB SET:C1220($promozione;"tipo";"0481")
		OB SET:C1220($promozione;"descrizione";$repartoDescrizione)
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
		OB SET:C1220($promozione;"barcode";$barcode)
		OB SET:C1220($promozione;"testo";"")
		
		C_OBJECT:C1216($ricompensa)
		ARRAY OBJECT:C1221($ricompense;0)
		OB SET:C1220($ricompensa;"id";Generate UUID:C1066)
		OB SET:C1220($ricompensa;"idPromozioni";$idPromozione)
		OB SET:C1220($ricompensa;"soglia";$soglia)
		OB SET:C1220($ricompensa;"ammontare";$importo)
		OB SET:C1220($ricompensa;"limiteSconto";0)
		OB SET:C1220($ricompensa;"taglio";0)
		OB SET:C1220($ricompensa;"descrizione";"SCONTO")
		OB SET:C1220($ricompensa;"recordM";"00:0481-"+String:C10($codicePromozione))
		OB SET:C1220($ricompensa;"accumulatore";"")
		OB SET:C1220($ricompensa;"promovar";$promoVar)
		OB SET:C1220($ricompensa;"tipoArea";0)
		OB SET:C1220($ricompensa;"ordinamentoInArea";0)
		OB SET:C1220($ricompensa;"progressivo";0)
		APPEND TO ARRAY:C911($ricompense;$ricompensa)
		OB SET ARRAY:C1227($promozione;"ricompense";$ricompense)
		
		ARRAY TEXT:C222($repartoCodici;0)
		OB GET ARRAY:C1229(<>reparti;$repartoDescrizione;$repartoCodici)
		C_OBJECT:C1216($articolo)
		ARRAY OBJECT:C1221($articoli;0)
		For ($i;1;Size of array:C274($repartoCodici))
			CLEAR VARIABLE:C89($articolo)
			OB SET:C1220($articolo;"id";Generate UUID:C1066)
			OB SET:C1220($articolo;"idPromozioni";$idPromozione)
			OB SET:C1220($articolo;"codiceArticolo";"")
			OB SET:C1220($articolo;"codiceReparto";$repartoCodici{$i})
			OB SET:C1220($articolo;"barcode";"")
			OB SET:C1220($articolo;"descrizione";$repartoCodici{$i})
			OB SET:C1220($articolo;"molteplicita";0)
			OB SET:C1220($articolo;"gruppo";1)
			APPEND TO ARRAY:C911($articoli;$articolo)
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
		  //SET TEXT TO PASTEBOARD($body)
		
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
