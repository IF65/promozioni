//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 29/03/20, 15:15:20
  // ----------------------------------------------------
  // Method: utlPromozioniIF652Excel
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_BOOLEAN:C305($0)
C_POINTER:C301($1)  //elenco id promozioni

$0:=False:C215

ARRAY TEXT:C222($arHeaderNames;0)
ARRAY TEXT:C222($arHeaderValues;0)
APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
APPEND TO ARRAY:C911($arHeaderValues;"application/json")
C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"templateIF652Excel")

$sedi:=New object:C1471
For ($i;1;Size of array:C274(<>sedi))
	OB SET:C1220($sedi;<>sedi{$i}.codice;<>sedi{$i}.negozio_descrizione)
End for 
OB SET:C1220($request;"sedi";$sedi)

$aderentiGruppi:=New object:C1471()
For ($i;1;Size of array:C274(<>aderenti))
	ARRAY TEXT:C222($elencoSedi;0)
	ARRAY OBJECT:C1221($aderentiSedi;0)
	OB GET ARRAY:C1229(<>aderenti{$i};"sedi";$aderentiSedi)
	For ($j;1;Size of array:C274($aderentiSedi))
		APPEND TO ARRAY:C911($elencoSedi;$aderentiSedi{$j}.codice)
	End for 
	OB SET ARRAY:C1227($aderentiGruppi;<>aderenti{$i}.descrizione;$elencoSedi)
End for 
OB SET:C1220($request;"aderentiGruppi";$aderentiGruppi)

COPY ARRAY:C226(<>promoTipoCodice;$promoTipoCodice)
DELETE FROM ARRAY:C228($promoTipoCodice;1;2)
OB SET ARRAY:C1227($request;"tipoPromozione";$promoTipoCodice)

ARRAY OBJECT:C1221($promozioni;0)
$json:=utlElencoPromozioni ($1)
JSON PARSE ARRAY:C1219($json;$promozioni)
For ($i;1;Size of array:C274($promozioni))
	ARRAY TEXT:C222($elencoSedi;0)
	ARRAY OBJECT:C1221($promozioniSedi;0)
	OB GET ARRAY:C1229($promozioni{$i};"sedi";$sedi)
	For ($j;1;Size of array:C274($promozioniSedi))
		APPEND TO ARRAY:C911($elencoSedi;$promozioniSedi{$j}.codiceSede)
	End for 
	OB SET ARRAY:C1227($promozioni{$i};"sedi";$elencoSedi)
End for 
OB SET ARRAY:C1227($request;"promozioni";$promozioni)

OB SET:C1220($request;"nomeFile";Generate UUID:C1066)

$body:=JSON Stringify:C1217($request)
SET TEXT TO PASTEBOARD:C523($body)
$sql:="/ordiniNF/src/templateIF652Excel.php"
C_BLOB:C604($response)

<>error:=0
HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
ON ERR CALL:C155("utlOnErrCall")
$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
ON ERR CALL:C155("")
If ($httpResponse=200) & (<>error=0)
	BLOB TO DOCUMENT:C526(System folder:C487(Desktop:K41:16)+"test.xlsx";$response)
	ALERT:C41("File creato!";"Continua")
Else 
	ALERT:C41("Il file non è stato creato!";"Continua")
End if 