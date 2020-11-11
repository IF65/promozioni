//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 21/03/20, 18:25:46
  // ----------------------------------------------------
  // Method: utlElencoCodiciCatalinaUsati
  // Description
  // Verifica che l'array di codici catalina passato con il 
  // puntatore $1 sia già presente. Dell'eneco passato ritorna
  // i codici già presenti. Quindi se passo solo un codice e 
  // non torna nulla il codice non è usato.
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($1)
C_DATE:C307($2)

ARRAY LONGINT:C221($codici;0)

$dataCorrente:=Current date:C33(*)

$dallaData:=Add to date:C393($dataCorrente;0;1-Month of:C24($dataCorrente);1-Day of:C23($dataCorrente))
If (Count parameters:C259>=1)
	COPY ARRAY:C226($1->;$codici)
	If (Count parameters:C259>=2)
		$dallaData:=$2
	End if 
End if 

ARRAY TEXT:C222($arHeaderNames;0)
ARRAY TEXT:C222($arHeaderValues;0)
APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
APPEND TO ARRAY:C911($arHeaderValues;"application/json")
C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"elencoCodiciCatalinaUsati")
OB SET:C1220($request;"dallaData";Substring:C12(String:C10($dallaData;ISO date:K1:8);1;10))
OB SET ARRAY:C1227($request;"codici";$codici)

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
	$0:=$response
End if 