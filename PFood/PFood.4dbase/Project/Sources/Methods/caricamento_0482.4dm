//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 29/06/20, 17:42:21
  // ----------------------------------------------------
  // Method: caricamento_0482
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------


C_BOOLEAN:C305($0)


C_DATE:C307($1;$2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

$0:=False:C215

If (Count parameters:C259=4)
	$soglia:=0
	$importo:=0
	$dataInizio:=$1
	$dataFine:=$2
	$promoVar:=$3
	$sedeSelezionata:=$4
	
	$codicePromozione:=utlProgressivoCrea (<>progPromozione)
	  //$promoVar:=utlProgressivoCrea (<>progPromovarPI)
	$barcode:=utlCreaBarcodeCatalina ("0481";$promoVar;$importo)  // lo stesso dei 0481
	
	C_OBJECT:C1216($promozione)
	$idPromozione:=Generate UUID:C1066
	OB SET:C1220($promozione;"id";$idPromozione)
	OB SET:C1220($promozione;"codice";$codicePromozione)
	OB SET:C1220($promozione;"codiceCatalina";0)
	OB SET:C1220($promozione;"tipo";"0482")
	OB SET:C1220($promozione;"descrizione";"RED. BUONO LIBRI "+String:C10(Year of:C25($dataInizio))+" "+$sedeSelezionata)
	OB SET:C1220($promozione;"ripetibilita";1)
	OB SET:C1220($promozione;"dataInizio";$dataInizio)
	OB SET:C1220($promozione;"dataFine";$dataFine)
	OB SET:C1220($promozione;"oraInizio";"00:00:00")
	OB SET:C1220($promozione;"oraFine";"23:59:00")
	OB SET:C1220($promozione;"calendarioSettimanale";"1111111")
	OB SET:C1220($promozione;"tipoCliente";1)
	OB SET:C1220($promozione;"categoria";0)
	OB SET:C1220($promozione;"sottoreparti";0)
	OB SET:C1220($promozione;"bozza";0)
	OB SET:C1220($promozione;"stampato";0)
	OB SET:C1220($promozione;"pmt";0)
	OB SET:C1220($promozione;"barcode";$barcode)
	OB SET:C1220($promozione;"testo";"")
	
	C_OBJECT:C1216($ricompensa)
	ARRAY OBJECT:C1221($ricompense;0)
	OB SET:C1220($ricompensa;"id";Generate UUID:C1066)
	OB SET:C1220($ricompensa;"idPromozioni";$idPromozione)
	OB SET:C1220($ricompensa;"soglia";$soglia)
	OB SET:C1220($ricompensa;"ammontare";$importo)
	OB SET:C1220($ricompensa;"limiteSconto";0)
	OB SET:C1220($ricompensa;"taglio";0)
	OB SET:C1220($ricompensa;"descrizione";"SCONTO")
	OB SET:C1220($ricompensa;"recordM";"00:0482-"+String:C10($codicePromozione))
	OB SET:C1220($ricompensa;"accumulatore";"")
	OB SET:C1220($ricompensa;"promovar";$promoVar)
	OB SET:C1220($ricompensa;"tipoArea";0)
	OB SET:C1220($ricompensa;"ordinamentoInArea";0)
	OB SET:C1220($ricompensa;"progressivo";0)
	APPEND TO ARRAY:C911($ricompense;$ricompensa)
	OB SET ARRAY:C1227($promozione;"ricompense";$ricompense)
	
	C_OBJECT:C1216($articolo)
	ARRAY OBJECT:C1221($articoli;0)
	OB SET ARRAY:C1227($promozione;"articoli";$articoli)
	
	C_OBJECT:C1216($sede)
	ARRAY OBJECT:C1221($sedi;0)
	OB SET:C1220($sede;"id";Generate UUID:C1066)
	OB SET:C1220($sede;"idPromozioni";$idPromozione)
	OB SET:C1220($sede;"codiceSede";$sedeSelezionata)
	APPEND TO ARRAY:C911($sedi;$sede)
	OB SET ARRAY:C1227($promozione;"sedi";$sedi)
	
	ARRAY TEXT:C222($arHeaderNames;0)
	ARRAY TEXT:C222($arHeaderValues;0)
	APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
	APPEND TO ARRAY:C911($arHeaderValues;"application/json")
	
	C_OBJECT:C1216($request)
	OB SET:C1220($request;"function";"salva")
	OB SET:C1220($request;"promozione";$promozione)
	
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
		$0:=True:C214
	End if 
End if 
