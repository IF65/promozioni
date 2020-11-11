ARRAY OBJECT:C1221($sedi;0)

C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"creaImmaginiBarcode")
OB SET:C1220($request;"barcode";"9882723103005")

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
	$immagini:=JSON Parse:C1218($response)
	
	C_TEXT:C284($immagine)
	$immagine:=OB Get:C1224($immagini;"immagine";Is text:K8:3)
	C_BLOB:C604($targetBlob)
	BASE64 DECODE:C896($immagine;$targetBlob)  //Decoding of text
	BLOB TO DOCUMENT:C526(Convert path POSIX to system:C1107("/Users/if65/Desktop/immagine.jpeg");$targetBlob)
	TRACE:C157
End if 
