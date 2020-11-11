//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 11/07/19, 17:40:20
  // ----------------------------------------------------
  // Method: pfCreazioneFile
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_BOOLEAN:C305($0)

C_TEXT:C284($1)  //id promo da esportare

$0:=False:C215

ARRAY OBJECT:C1221($sedi;0)

C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"promozione2file")
OB SET:C1220($request;"id";$1)

$body:=JSON Stringify:C1217($request)
  //SET TEXT TO PASTEBOARD($body)

ARRAY TEXT:C222($arHeaderNames;0)
ARRAY TEXT:C222($arHeaderValues;0)
APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
APPEND TO ARRAY:C911($arHeaderValues;"application/json")

$sql:="/promozioni/src/promozioni.php"
C_TEXT:C284($response)
$response:=""

<>error:=0
HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
ON ERR CALL:C155("utlOnErrCall")
$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
ON ERR CALL:C155("")
If ($httpResponse=200) & (<>error=0)
	$0:=True:C214
End if 




