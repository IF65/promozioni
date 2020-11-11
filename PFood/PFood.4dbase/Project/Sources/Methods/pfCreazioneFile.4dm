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

C_TEXT:C284($1)  //id promo da esportare
C_POINTER:C301($2)  //puntatore a testo su cui accodare le promo
C_POINTER:C301($3)  //puntatore a sedi
C_BOOLEAN:C305($4)  //cancellazione

$cancellazione:=False:C215
If (Count parameters:C259>3)
	$cancellazione:=$4
End if 

ARRAY OBJECT:C1221($sedi;0)

C_OBJECT:C1216($request)
OB SET:C1220($request;"function";"promozione2text")
OB SET:C1220($request;"id";$1)
OB SET:C1220($request;"cancellazione";$cancellazione)

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
	$promozione:=JSON Parse:C1218($response)
	  //SET TEXT TO PASTEBOARD($response)
	OB GET ARRAY:C1229($promozione;"sedi";$sedi)
	COPY ARRAY:C226($sedi;$3->)
	$text:=OB Get:C1224($promozione;"testo";Is text:K8:3)
	If (Count parameters:C259>=3)
		$2->:=$2->+$text
	Else 
		  //SET TEXT TO PASTEBOARD($text)
	End if 
Else 
	COPY ARRAY:C226($sedi;$3->)
End if 




