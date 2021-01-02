//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 26/03/20, 11:16:46
  // ----------------------------------------------------
  // Method: utlEsplosioneBarcode
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1)

$0:=""

$barcode:="8000500260043"
If (Count parameters:C259=1)
	$barcode:=$1
End if 

C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"esplosioneBarcode")
OB SET:C1220($request;"barcode";$barcode)

$body:=JSON Stringify:C1217($request)
SET TEXT TO PASTEBOARD:C523($body)

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
	$0:=$response
End if 












