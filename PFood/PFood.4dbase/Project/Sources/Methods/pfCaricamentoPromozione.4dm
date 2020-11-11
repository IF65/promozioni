//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 11/07/19, 17:57:55
  // ----------------------------------------------------
  // Method: pfCaricaPromozione
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_TEXT:C284($0)  //json promo
C_TEXT:C284($1)  //id promo

$0:=""

ARRAY TEXT:C222($arHeaderNames;0)
ARRAY TEXT:C222($arHeaderValues;0)
APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
APPEND TO ARRAY:C911($arHeaderValues;"application/json")

  //parametri
C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"elencoPromozioni")
OB SET:C1220($request;"id";$1)

$body:=JSON Stringify:C1217($request)
  //SET TEXT TO PASTEBOARD($body)
$sql:="/promozioni/src/promozioni.php"
C_TEXT:C284($response)

<>error:=0
HTTP SET OPTION:C1160(HTTP timeout:K71:10;20)
ON ERR CALL:C155("utlOnErrCall")
$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
ON ERR CALL:C155("")
If ($httpResponse=200) & (<>error=0)
	$0:=$response
End if 