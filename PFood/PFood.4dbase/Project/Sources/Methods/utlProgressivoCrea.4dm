//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 30/11/19, 14:56:53
  // ----------------------------------------------------
  // Method: utlNuovoCodicePromozione
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_LONGINT:C283($0)
C_LONGINT:C283($1)  //tipo progressivo

$0:=-1

ARRAY TEXT:C222($arHeaderNames;0)
ARRAY TEXT:C222($arHeaderValues;0)
APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
APPEND TO ARRAY:C911($arHeaderValues;"application/json")
C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"creaNuovoCodice")
OB SET:C1220($request;"tipo";$1)  //0 sono le promozioni
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
	$responseObj:=JSON Parse:C1218($response)
	If (OB Is defined:C1231($responseObj;"codice"))
		$0:=OB Get:C1224($responseObj;"codice";Is longint:K8:6)
	End if 
End if 