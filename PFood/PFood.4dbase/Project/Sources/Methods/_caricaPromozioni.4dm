//%attributes = {}
ARRAY TEXT:C222($arHeaderNames; 0)
ARRAY TEXT:C222($arHeaderValues; 0)
APPEND TO ARRAY:C911($arHeaderNames; "Content-Type")
APPEND TO ARRAY:C911($arHeaderValues; "application/json")

//parametri
C_OBJECT:C1216($request)
OB SET:C1220($request; "function"; "elencoPromozioni")
OB SET:C1220($request; "tipo"; "0492")

$body:=JSON Stringify:C1217($request)
$sql:="/promozioni/src/promozioni.php"
C_TEXT:C284($response)

<>error:=0
HTTP SET OPTION:C1160(HTTP timeout:K71:10; 45)
ON ERR CALL:C155("utlOnErrCall")
$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2; <>itmServer+$sql; $body; $response; $arHeaderNames; $arHeaderValues)
ON ERR CALL:C155("")
If ($httpResponse=200) & (<>error=0)
	ARRAY OBJECT:C1221($elenco; 0)
	JSON PARSE ARRAY:C1219($response; $elenco)
	
	$promozioni:=New collection:C1472()
	For ($i; 1; Size of array:C274($elenco))
		$promozione:=cs:C1710.Promozione.new($elenco{$i})
		
		$promozioni.push($promozione)
		
	End for 
End if 


TRACE:C157

