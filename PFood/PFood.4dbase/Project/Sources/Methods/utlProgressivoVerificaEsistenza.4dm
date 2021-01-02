//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 22/03/20, 17:48:15
  // ----------------------------------------------------
  // Method: utlProgressivoVerificaEsistenza
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)  //tipo progressivo
C_LONGINT:C283($2)  //progressivo

$0:=-1

If (Count parameters:C259=2)
	ARRAY TEXT:C222($arHeaderNames;0)
	ARRAY TEXT:C222($arHeaderValues;0)
	APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
	APPEND TO ARRAY:C911($arHeaderValues;"application/json")
	C_OBJECT:C1216($request)
	OB SET:C1220($request;"function";"verificaEsistenzaCodice")
	OB SET:C1220($request;"tipo";$1)
	OB SET:C1220($request;"codice";$2)
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
End if 
