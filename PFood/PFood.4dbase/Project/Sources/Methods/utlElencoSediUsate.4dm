//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 15/11/20, 08:07:37
  // ----------------------------------------------------
  // Method: utlElencoSediUsate
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($1)  //array id promozioni

$0:="{}"

ARRAY TEXT:C222($arHeaderNames;0)
ARRAY TEXT:C222($arHeaderValues;0)
APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
APPEND TO ARRAY:C911($arHeaderValues;"application/json")

  //parametri
C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"elencoSediUsate")
OB SET ARRAY:C1227($request;"codiciPromozione";$1->)

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
	If ($response#"")
		$0:=$response
	End if 
End if 
