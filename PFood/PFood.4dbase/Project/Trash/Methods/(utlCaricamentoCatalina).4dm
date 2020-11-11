//%attributes = {"invisible":true}
ARRAY TEXT:C222($descrizione;0)
ARRAY LONGINT:C221($reparto;0)
ARRAY TEXT:C222($sottoreparto;0)
ARRAY DATE:C224($inizio;0)
ARRAY DATE:C224($fine;0)
ARRAY REAL:C219($importo;0)
ARRAY REAL:C219($soglia;0)
ARRAY LONGINT:C221($progressivo;0)
ARRAY TEXT:C222($tipo;0)

APPEND TO ARRAY:C911($descrizione;"TOTALE SPESA")
APPEND TO ARRAY:C911($reparto;0)
APPEND TO ARRAY:C911($sottoreparto;"")
APPEND TO ARRAY:C911($inizio;!2019-09-16!)
APPEND TO ARRAY:C911($fine;!2020-01-12!)
APPEND TO ARRAY:C911($importo;3)
APPEND TO ARRAY:C911($soglia;30)
APPEND TO ARRAY:C911($progressivo;7312)
APPEND TO ARRAY:C911($tipo;"0503")

For ($i;1;Size of array:C274($descrizione))
	
	If ($tipo{$i}="0481") & (False:C215)
		C_OBJECT:C1216($promozione)
		
		$sottoreparti:=0
		
		$id:=Generate UUID:C1066
		OB SET:C1220($promozione;"id";$id)
		OB SET:C1220($promozione;"codice";$progressivo{$i})
		OB SET:C1220($promozione;"tipo";$tipo{$i})
		OB SET:C1220($promozione;"descrizione";$descrizione{$i})
		OB SET:C1220($promozione;"limite";1)
		OB SET:C1220($promozione;"dataInizio";$inizio{$i})
		OB SET:C1220($promozione;"dataFine";$fine{$i})
		OB SET:C1220($promozione;"oraInizio";"00:00:00")
		OB SET:C1220($promozione;"oraFine";"23:59:00")
		OB SET:C1220($promozione;"dipendenteCliente";1)
		OB SET:C1220($promozione;"tipoCliente";0)
		OB SET:C1220($promozione;"calendarioSettimanale";"1111111")
		OB SET:C1220($promozione;"sottoreparti";$sottoreparti)
		OB SET:C1220($promozione;"bozza";True:C214)
		OB SET:C1220($promozione;"stampato";False:C215)
		OB SET:C1220($promozione;"pmt";False:C215)
		OB SET:C1220($promozione;"barcode";utlCreaBarcodeCatalina ($tipo{$i};$progressivo{$i};$importo{$i}))
		
		C_OBJECT:C1216($ricompensa)
		ARRAY OBJECT:C1221($ricompense;0)
		OB SET:C1220($ricompensa;"id";Generate UUID:C1066)
		OB SET:C1220($ricompensa;"idPromozioni";$id)
		OB SET:C1220($ricompensa;"sogliaTaglio";$soglia{$i})
		OB SET:C1220($ricompensa;"ammontare";$importo{$i})
		OB SET:C1220($ricompensa;"limiteSconto";0)
		OB SET:C1220($ricompensa;"ripetibilita";0)
		OB SET:C1220($ricompensa;"descrizione";$descrizione{$i})
		OB SET:C1220($ricompensa;"recordM";"00:"+$tipo{$i}+"C8"+String:C10($progressivo{$i};"0000")+"00")
		APPEND TO ARRAY:C911($ricompense;$ricompensa)
		OB SET ARRAY:C1227($promozione;"ricompense";$ricompense)
		
		C_OBJECT:C1216($categoria)
		ARRAY OBJECT:C1221($categorie;0)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";1)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";10)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";11)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";12)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";13)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		OB SET ARRAY:C1227($promozione;"categorie";$categorie)
		
		If ($sottoreparti=0)
			C_OBJECT:C1216($articolo)
			ARRAY OBJECT:C1221($articoli;0)
			OB SET:C1220($articolo;"id";Generate UUID:C1066)
			OB SET:C1220($articolo;"idPromozioni";$id)
			OB SET:C1220($articolo;"codiceArticolo";"")
			OB SET:C1220($articolo;"codiceReparto";String:C10($reparto{$i}))
			OB SET:C1220($articolo;"barcode";"")
			OB SET:C1220($articolo;"descrizione";String:C10($reparto{$i};"00"))
			OB SET:C1220($articolo;"molteplicita";0)
			APPEND TO ARRAY:C911($articoli;$articolo)
			OB SET ARRAY:C1227($promozione;"articoli";$articoli)
		Else 
			ARRAY LONGINT:C221($dettaglioReparto;0)
			$p:=Position:C15("-";$sottoreparto{$i})
			While ($p#0)
				APPEND TO ARRAY:C911($dettaglioReparto;Num:C11(Substring:C12($sottoreparto{$i};1;$p-1)))
				$sottoreparto{$i}:=Substring:C12($sottoreparto{$i};$p+1)
				$p:=Position:C15("-";$sottoreparto{$i})
			End while 
			APPEND TO ARRAY:C911($dettaglioReparto;Num:C11($sottoreparto{$i}))
			
			ARRAY OBJECT:C1221($articoli;0)
			For ($j;1;Size of array:C274($dettaglioReparto))
				CLEAR VARIABLE:C89($articolo)
				C_OBJECT:C1216($articolo)
				OB SET:C1220($articolo;"id";Generate UUID:C1066)
				OB SET:C1220($articolo;"idPromozioni";$id)
				OB SET:C1220($articolo;"codiceArticolo";"")
				OB SET:C1220($articolo;"codiceReparto";String:C10($dettaglioReparto{$j}))
				OB SET:C1220($articolo;"barcode";"")
				OB SET:C1220($articolo;"descrizione";String:C10($dettaglioReparto{$j};"0000"))
				OB SET:C1220($articolo;"molteplicita";0)
				APPEND TO ARRAY:C911($articoli;$articolo)
			End for 
			OB SET ARRAY:C1227($promozione;"articoli";$articoli)
		End if 
		
		$negoziJson:=utlElencoNegozi ($sottoreparti)
		C_OBJECT:C1216($sede)
		ARRAY OBJECT:C1221($sedi;0)
		If ($negoziJson#"")
			ARRAY OBJECT:C1221($negozi;0)
			JSON PARSE ARRAY:C1219($negoziJson;$negozi)
			For ($j;1;Size of array:C274($negozi))
				CLEAR VARIABLE:C89($sede)
				OB SET:C1220($sede;"id";Generate UUID:C1066)
				OB SET:C1220($sede;"idPromozioni";$id)
				OB SET:C1220($sede;"codiceSede";$negozi{$j}.codice)
				APPEND TO ARRAY:C911($sedi;$sede)
			End for 
		End if 
		OB SET ARRAY:C1227($promozione;"sedi";$sedi)
		
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"salva")
		OB SET:C1220($request;"promozione";$promozione)
		
		$text:=JSON Stringify:C1217($request;*)
		  //SET TEXT TO PASTEBOARD($text)
		
		$body:=JSON Stringify:C1217($request)
		
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse#200) | (<>error#0)
			TRACE:C157
		End if 
	End if 
	
	If ($tipo{$i}="0503") & (True:C214)
		C_OBJECT:C1216($promozione)
		
		$sottoreparti:=1
		
		$id:=Generate UUID:C1066
		OB SET:C1220($promozione;"id";$id)
		OB SET:C1220($promozione;"codice";$progressivo{$i})
		OB SET:C1220($promozione;"tipo";$tipo{$i})
		OB SET:C1220($promozione;"descrizione";$descrizione{$i})
		OB SET:C1220($promozione;"limite";1)
		OB SET:C1220($promozione;"dataInizio";$inizio{$i})
		OB SET:C1220($promozione;"dataFine";$fine{$i})
		OB SET:C1220($promozione;"oraInizio";"00:00:00")
		OB SET:C1220($promozione;"oraFine";"23:59:00")
		OB SET:C1220($promozione;"dipendenteCliente";1)
		OB SET:C1220($promozione;"tipoCliente";0)
		OB SET:C1220($promozione;"calendarioSettimanale";"1111111")
		OB SET:C1220($promozione;"sottoreparti";$sottoreparti)
		OB SET:C1220($promozione;"bozza";True:C214)
		OB SET:C1220($promozione;"stampato";False:C215)
		OB SET:C1220($promozione;"pmt";False:C215)
		OB SET:C1220($promozione;"barcode";utlCreaBarcodeCatalina ($tipo{$i};$progressivo{$i};$importo{$i}))
		
		C_OBJECT:C1216($ricompensa)
		ARRAY OBJECT:C1221($ricompense;0)
		OB SET:C1220($ricompensa;"id";Generate UUID:C1066)
		OB SET:C1220($ricompensa;"idPromozioni";$id)
		OB SET:C1220($ricompensa;"sogliaTaglio";$soglia{$i})
		OB SET:C1220($ricompensa;"ammontare";$importo{$i})
		OB SET:C1220($ricompensa;"limiteSconto";0)
		OB SET:C1220($ricompensa;"ripetibilita";0)
		OB SET:C1220($ricompensa;"descrizione";$descrizione{$i})
		OB SET:C1220($ricompensa;"recordM";"00:"+$tipo{$i}+"C8"+String:C10($progressivo{$i};"0000")+"00")
		APPEND TO ARRAY:C911($ricompense;$ricompensa)
		OB SET ARRAY:C1227($promozione;"ricompense";$ricompense)
		
		C_OBJECT:C1216($categoria)
		ARRAY OBJECT:C1221($categorie;0)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";1)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";10)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";11)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";12)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		CLEAR VARIABLE:C89($categoria)
		OB SET:C1220($categoria;"id";Generate UUID:C1066)
		OB SET:C1220($categoria;"idPromozioni";$id)
		OB SET:C1220($categoria;"codice";13)
		APPEND TO ARRAY:C911($categorie;$categoria)
		
		OB SET ARRAY:C1227($promozione;"categorie";$categorie)
		
		$negoziJson:=utlElencoNegozi 
		C_OBJECT:C1216($sede)
		ARRAY OBJECT:C1221($sedi;0)
		If ($negoziJson#"")
			ARRAY OBJECT:C1221($negozi;0)
			JSON PARSE ARRAY:C1219($negoziJson;$negozi)
			For ($j;1;Size of array:C274($negozi))
				CLEAR VARIABLE:C89($sede)
				OB SET:C1220($sede;"id";Generate UUID:C1066)
				OB SET:C1220($sede;"idPromozioni";$id)
				OB SET:C1220($sede;"codiceSede";$negozi{$j}.codice)
				APPEND TO ARRAY:C911($sedi;$sede)
			End for 
		End if 
		OB SET ARRAY:C1227($promozione;"sedi";$sedi)
		
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"salva")
		OB SET:C1220($request;"promozione";$promozione)
		
		$text:=JSON Stringify:C1217($request;*)
		  //SET TEXT TO PASTEBOARD($text)
		
		$body:=JSON Stringify:C1217($request)
		
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse#200) | (<>error#0)
			TRACE:C157
		End if 
	End if 
	
	CLEAR VARIABLE:C89($promozione)
End for 

