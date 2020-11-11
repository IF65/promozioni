//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 29/06/20, 16:07:17
  // ----------------------------------------------------
  // Method: caricamentoPromoLibri
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_BOOLEAN:C305($0)

C_DATE:C307($1;$2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

$0:=False:C215

If (Count parameters:C259=5)
	$codice1:=utlProgressivoCrea (<>progPromozione)
	$codice2:=utlProgressivoCrea (<>progPromozione)
	$codice3:=utlProgressivoCrea (<>progPromozione)
	$codice4:=utlProgressivoCrea (<>progPromozione)
	$dataInizio:=$1
	$dataFine:=$2
	$promoVarPerTotale:=utlProgressivoCrea (<>progPromovarPI)
	$promoVarPerBuono:=utlProgressivoCrea (<>progPromovarPI)
	$barcode:=$3
	$percentualeSconto:=$4
	$sedeSelezionata:=$5
	
	$testo:=utlCreaPmtLibriDaTemplate ($codice1;$codice2;$codice3;$codice4;$dataInizio;$dataFine;$promoVarPerTotale;$promoVarPerBuono;$barcode;$percentualeSconto)
	
	
	
	C_OBJECT:C1216($promozione)
	$idPromozione:=Generate UUID:C1066
	OB SET:C1220($promozione;"id";$idPromozione)
	OB SET:C1220($promozione;"codice";$codice1)
	OB SET:C1220($promozione;"codiceCatalina";0)
	OB SET:C1220($promozione;"tipo";"EMBU")
	OB SET:C1220($promozione;"descrizione";"BUONO LIBRI "+String:C10($percentualeSconto)+"% "+String:C10(Year of:C25($dataInizio))+" "+$sedeSelezionata)
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
	OB SET:C1220($promozione;"testo";$testo)
	
	ARRAY OBJECT:C1221($articoli;0)
	OB SET ARRAY:C1227($promozione;"articoli";$articoli)
	
	C_OBJECT:C1216($ricompensa)
	ARRAY OBJECT:C1221($ricompense;0)
	OB SET:C1220($ricompensa;"id";Generate UUID:C1066)
	OB SET:C1220($ricompensa;"idPromozioni";$idPromozione)
	OB SET:C1220($ricompensa;"soglia";0)
	OB SET:C1220($ricompensa;"ammontare";0)
	OB SET:C1220($ricompensa;"limiteSconto";0)
	OB SET:C1220($ricompensa;"taglio";0.01)
	OB SET:C1220($ricompensa;"descrizione";"SCONTO")
	OB SET:C1220($ricompensa;"recordM";"00:EMBU-"+String:C10($codice1))
	OB SET:C1220($ricompensa;"accumulatore";"")
	OB SET:C1220($ricompensa;"promovar";"")
	OB SET:C1220($ricompensa;"tipoArea";0)
	OB SET:C1220($ricompensa;"ordinamentoInArea";0)
	OB SET:C1220($ricompensa;"progressivo";0)
	APPEND TO ARRAY:C911($ricompense;$ricompensa)
	OB SET ARRAY:C1227($promozione;"ricompense";$ricompense)
	
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
	SET TEXT TO PASTEBOARD:C523($body)
	
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

