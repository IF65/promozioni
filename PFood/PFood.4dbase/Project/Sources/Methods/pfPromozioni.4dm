//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 05/07/19, 11:14:04
  // ----------------------------------------------------
  // Method: pfPromozioni
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1)

$azione:=""
If (Count parameters:C259=1)
	$azione:=$1
End if 

Case of 
	: ($azione="")
		C_LONGINT:C283(<>promozioni)
		If (<>promozioni=0)
			<>promozioni:=New process:C317("pfPromozioni";1024*1024;"Promozioni Food";"creaFinestra";*)
		Else 
			SHOW PROCESS:C325(<>promozioni)
			BRING TO FRONT:C326(<>promozioni)
		End if 
	: ($azione="creaFinestra")
		$wRef:=Open form window:C675("pfPromozioni";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfPromozioni")
		
	: ($azione="inizializzaRicerca")
		$currentDate:=Current date:C33(*)
		COPY ARRAY:C226(<>promoTipo;srcTipoPromozione)
		COPY ARRAY:C226(<>promoTipoCodice;srcTipoPromozioneCodice)
		srcTipoPromozione:=1
		srcBozza:=0
		srcUsaDataCorrente:=True:C214
		srcDataCorrente:=$currentDate
		srcDataDa:=Date:C102(String:C10(Year of:C25($currentDate)-1;"0000")+"-01-01T00:00:00")
		srcDataA:=Date:C102(String:C10(Year of:C25($currentDate)+1;"0000")+"-12-31T00:00:00")
		srcCodicePromozione:=0
		srcBarcode:=""
		srcDescrizione:=""
		
	: ($azione="inizializzaArray")
		ARRAY TEXT:C222(arPR_id;0)
		ARRAY LONGINT:C221(arPR_codice;0)
		ARRAY LONGINT:C221(arPR_codiceCatalina;0)
		ARRAY TEXT:C222(arPR_tipo;0)
		ARRAY TEXT:C222(arPR_descrizione;0)
		ARRAY LONGINT:C221(arPR_ripetibilita;0)
		ARRAY DATE:C224(arPR_dataInizio;0)
		ARRAY DATE:C224(arPR_dataFine;0)
		ARRAY TEXT:C222(arPR_oraInizio;0)
		ARRAY TEXT:C222(arPR_oraFine;0)
		ARRAY LONGINT:C221(arPR_tipoCliente;0)
		ARRAY LONGINT:C221(arPR_categoria;0)
		ARRAY TEXT:C222(arPR_calendarioSettimanale;0)
		ARRAY BOOLEAN:C223(arPR_Do;0)
		ARRAY BOOLEAN:C223(arPR_Lu;0)
		ARRAY BOOLEAN:C223(arPR_Ma;0)
		ARRAY BOOLEAN:C223(arPR_Me;0)
		ARRAY BOOLEAN:C223(arPR_Gi;0)
		ARRAY BOOLEAN:C223(arPR_Ve;0)
		ARRAY BOOLEAN:C223(arPR_Sa;0)
		ARRAY LONGINT:C221(arPR_sottoreparti;0)
		ARRAY BOOLEAN:C223(arPR_bozza;0)
		ARRAY BOOLEAN:C223(arPR_stampato;0)
		ARRAY BOOLEAN:C223(arPR_pmt;0)
		ARRAY TEXT:C222(arPR_barcode;0)
		ARRAY TEXT:C222(arPR_testo;0)
		ARRAY REAL:C219(arPR_soglia;0)
		ARRAY REAL:C219(arPR_importo;0)
		ARRAY LONGINT:C221(arPR_numeroSedi;0)
		ARRAY BLOB:C1222(arPR_immagineBarcode;0)
		
	: ($azione="caricaArray")
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		  //parametri
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"elencoPromozioni")
		If (srcCodicePromozione#0)
			OB SET:C1220($request;"codice";srcCodicePromozione)
		End if 
		If (srcBarcode#"")
			OB SET:C1220($request;"barcode";srcBarcode)
		End if 
		If (srcDescrizione#"")
			OB SET:C1220($request;"descrizione";srcDescrizione)
		End if 
		If (srcTipoPromozione>1)
			OB SET:C1220($request;"tipo";srcTipoPromozioneCodice{srcTipoPromozione})
		End if 
		If (srcUsaDataCorrente)
			If (srcDataCorrente#!00-00-00!)
				OB SET:C1220($request;"dataCorrente";Substring:C12(String:C10(srcDataCorrente;ISO date:K1:8);1;10))
			End if 
		Else 
			If (srcDataDa#!00-00-00!)
				OB SET:C1220($request;"dallaData";Substring:C12(String:C10(srcDataDa;ISO date:K1:8);1;10))
			End if 
			If (srcDataA#!00-00-00!)
				OB SET:C1220($request;"allaData";Substring:C12(String:C10(srcDataA;ISO date:K1:8);1;10))
			End if 
		End if 
		If (srcBozza=0)
			OB SET:C1220($request;"bozza";False:C215)
		End if 
		If (srcBozza=1)
			OB SET:C1220($request;"bozza";True:C214)
		End if 
		utlTermometro ("apri")
		utlTermometro ("mostra";"Caricamento in corso...")
		
		$body:=JSON Stringify:C1217($request)
		  //SET TEXT TO PASTEBOARD($body)
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;45)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse=200) & (<>error=0)
			pfPromozioni ("inizializzaArray")
			ARRAY OBJECT:C1221($elencoPromozioni;0)
			JSON PARSE ARRAY:C1219($response;$elencoPromozioni)
			
			For ($i;1;Size of array:C274($elencoPromozioni))
				C_BLOB:C604($immagine)
				$text:=OB Get:C1224($elencoPromozioni{$i};"immagineBarcode";Is text:K8:3)
				$calendario:=OB Get:C1224($elencoPromozioni{$i};"calendarioSettimanale";Is text:K8:3)
				BASE64 DECODE:C896($text;$immagine)
				
				APPEND TO ARRAY:C911(arPR_id;OB Get:C1224($elencoPromozioni{$i};"id";Is text:K8:3))
				APPEND TO ARRAY:C911(arPR_codice;OB Get:C1224($elencoPromozioni{$i};"codice";Is longint:K8:6))
				APPEND TO ARRAY:C911(arPR_codiceCatalina;OB Get:C1224($elencoPromozioni{$i};"codiceCatalina";Is longint:K8:6))
				APPEND TO ARRAY:C911(arPR_tipo;OB Get:C1224($elencoPromozioni{$i};"tipo";Is text:K8:3))
				APPEND TO ARRAY:C911(arPR_descrizione;OB Get:C1224($elencoPromozioni{$i};"descrizione";Is text:K8:3))
				APPEND TO ARRAY:C911(arPR_ripetibilita;OB Get:C1224($elencoPromozioni{$i};"ripetibilita";Is longint:K8:6))
				APPEND TO ARRAY:C911(arPR_dataInizio;OB Get:C1224($elencoPromozioni{$i};"dataInizio";Is date:K8:7))
				APPEND TO ARRAY:C911(arPR_dataFine;OB Get:C1224($elencoPromozioni{$i};"dataFine";Is date:K8:7))
				APPEND TO ARRAY:C911(arPR_oraInizio;OB Get:C1224($elencoPromozioni{$i};"oraInizio";Is text:K8:3))
				APPEND TO ARRAY:C911(arPR_oraFine;OB Get:C1224($elencoPromozioni{$i};"oraFine";Is text:K8:3))
				APPEND TO ARRAY:C911(arPR_tipoCliente;OB Get:C1224($elencoPromozioni{$i};"tipoCliente";Is longint:K8:6))
				APPEND TO ARRAY:C911(arPR_categoria;OB Get:C1224($elencoPromozioni{$i};"categoria";Is longint:K8:6))
				APPEND TO ARRAY:C911(arPR_calendarioSettimanale;$calendario)
				APPEND TO ARRAY:C911(arPR_Do;Substring:C12($calendario;1;1)="1")
				APPEND TO ARRAY:C911(arPR_Lu;Substring:C12($calendario;2;1)="1")
				APPEND TO ARRAY:C911(arPR_Ma;Substring:C12($calendario;3;1)="1")
				APPEND TO ARRAY:C911(arPR_Me;Substring:C12($calendario;4;1)="1")
				APPEND TO ARRAY:C911(arPR_Gi;Substring:C12($calendario;5;1)="1")
				APPEND TO ARRAY:C911(arPR_Ve;Substring:C12($calendario;6;1)="1")
				APPEND TO ARRAY:C911(arPR_Sa;Substring:C12($calendario;7;1)="1")
				APPEND TO ARRAY:C911(arPR_sottoreparti;OB Get:C1224($elencoPromozioni{$i};"sottoreparti";Is longint:K8:6))
				APPEND TO ARRAY:C911(arPR_bozza;OB Get:C1224($elencoPromozioni{$i};"bozza";Is longint:K8:6)=1)
				APPEND TO ARRAY:C911(arPR_stampato;OB Get:C1224($elencoPromozioni{$i};"stampato";Is longint:K8:6)=1)
				APPEND TO ARRAY:C911(arPR_pmt;OB Get:C1224($elencoPromozioni{$i};"pmt";Is longint:K8:6)=1)
				APPEND TO ARRAY:C911(arPR_barcode;OB Get:C1224($elencoPromozioni{$i};"barcode";Is text:K8:3))
				APPEND TO ARRAY:C911(arPR_testo;OB Get:C1224($elencoPromozioni{$i};"testo";Is text:K8:3))
				APPEND TO ARRAY:C911(arPR_immagineBarcode;$immagine)
				
				ARRAY OBJECT:C1221($ricompense;0)
				OB GET ARRAY:C1229($elencoPromozioni{$i};"ricompense";$ricompense)
				If (Size of array:C274($ricompense)=1)
					APPEND TO ARRAY:C911(arPR_soglia;OB Get:C1224($ricompense{1};"soglia";Is real:K8:4))
					APPEND TO ARRAY:C911(arPR_importo;OB Get:C1224($ricompense{1};"ammontare";Is real:K8:4))
				Else 
					APPEND TO ARRAY:C911(arPR_soglia;0)
					APPEND TO ARRAY:C911(arPR_importo;0)
				End if 
				
				$numeroSedi:=0
				ARRAY OBJECT:C1221($sedi;0)
				OB GET ARRAY:C1229($elencoPromozioni{$i};"sedi";$sedi)
				If (Size of array:C274($ricompense)>0)
					$numeroSedi:=Size of array:C274($sedi)
				End if 
				APPEND TO ARRAY:C911(arPR_numeroSedi;$numeroSedi)
				
			End for 
			SORT ARRAY:C229(arPR_codice;arPR_codiceCatalina;arPR_id;arPR_tipo;arPR_descrizione;arPR_ripetibilita;arPR_dataInizio;arPR_dataFine;\
				arPR_oraInizio;arPR_oraFine;arPR_tipoCliente;arPR_categoria;arPR_calendarioSettimanale;arPR_Do;\
				arPR_Lu;arPR_Ma;arPR_Me;arPR_Gi;arPR_Ve;arPR_Sa;arPR_sottoreparti;arPR_bozza;arPR_stampato;\
				arPR_pmt;arPR_barcode;arPR_testo;arPR_soglia;arPR_importo;arPR_numeroSedi;>)
		End if 
		
		utlTermometro ("chiudi")
	: ($azione="modificaPromozione")
		pfPromozioniInserimento ("creaFinestra")
		pfPromozioni ("updateDisplay")
		
	: ($azione="nuovaPromozione")
		promozioneSelezionata:=0
		pfPromozioni ("modificaPromozione")
		
	: ($azione="aggiornaDisplay")
		pfPromozioni ("updateDisplay")
		AL_SetAreaLongProperty (alpPromozioni;ALP_Area_ScrollTop;0)
		AL_SetAreaLongProperty (alpPromozioni;ALP_Area_SelRow;0)
		
	: ($azione="updateDisplay")
		AL_SetAreaLongProperty (alpPromozioni;ALP_Area_UpdateData;0)
		
	: ($azione="eliminaPromozioni")
		
	: ($azione="stampa")
		
		  //ARRAY TEXT(arPR_id;0)
		  //ARRAY LONGINT(arPR_codice;0)
		  //ARRAY TEXT(arPR_tipo;0)
		  //ARRAY TEXT(arPR_descrizione;0)
		  //ARRAY LONGINT(arPR_ripetibilita;0)
		  //ARRAY DATE(arPR_dataInizio;0)
		  //ARRAY DATE(arPR_dataFine;0)
		  //ARRAY TEXT(arPR_oraInizio;0)
		  //ARRAY TEXT(arPR_oraFine;0)
		  //ARRAY LONGINT(arPR_tipoCliente;0)
		  //ARRAY LONGINT(arPR_categoria;0)
		  //ARRAY TEXT(arPR_calendarioSettimanale;0)
		  //ARRAY BOOLEAN(arPR_Do;0)
		  //ARRAY BOOLEAN(arPR_Lu;0)
		  //ARRAY BOOLEAN(arPR_Ma;0)
		  //ARRAY BOOLEAN(arPR_Me;0)
		  //ARRAY BOOLEAN(arPR_Gi;0)
		  //ARRAY BOOLEAN(arPR_Ve;0)
		  //ARRAY BOOLEAN(arPR_Sa;0)
		  //ARRAY LONGINT(arPR_sottoreparti;0)
		  //ARRAY BOOLEAN(arPR_bozza;0)
		  //ARRAY BOOLEAN(arPR_stampato;0)
		  //ARRAY TEXT(arPR_barcode;0)
		  //ARRAY TEXT(arPR_testo;0)
		  //ARRAY REAL(arPR_soglia;0)
		  //ARRAY REAL(arPR_importo;0)
		  //ARRAY LONGINT(arPR_numeroSedi;0)
		  //ARRAY BLOB(arPR_immagineBarcode;0)
		
		ARRAY LONGINT:C221($selezione;0)
		$err:=AL_GetObjects (alpPromozioni;ALP_Object_Selection;$selezione)
		If (Size of array:C274($selezione)>0)
			
			C_REAL:C285(hPaper;wPaper)
			GET PRINTABLE AREA:C703(hPaper;wPaper)  // Paper size
			
			pagina:=1
			stPagina:="Pag."+String:C10(pagina)
			stOra:=String:C10(Current date:C33;ISO date:K1:8;Current time:C178)
			
			
			$h:=Print form:C5("stampaListaPromozioni";Form header:K43:3)
			For ($i;1;Size of array:C274($selezione))
				st_codice:=arPR_codice{$i}
				st_tipo:=arPR_tipo{$i}
				st_descrizione:=arPR_descrizione{$i}
				  //st_ripetibilita:=arPR_ripetibilita{$i}
				st_dataInizio:=String:C10(arPR_dataInizio{$i})
				st_dataFine:=String:C10(arPR_dataFine{$i})
				st_oraInizio:=arPR_oraInizio{$i}
				st_oraFine:=arPR_oraFine{$i}
				  //st_tipoCliente:=arPR_tipoCliente{$i}
				  //st_categoria:=arPR_categoria{$i}
				st_calendarioSettimanale:=arPR_calendarioSettimanale{$i}
				  //st_Do:=arPR_Do{$i}
				  //st_Lu:=arPR_Lu{$i}
				  //st_Ma:=arPR_Ma{$i}
				  //st_Me:=arPR_Me{$i}
				  //st_Gi:=arPR_Gi{$i}
				  //st_Ve:=arPR_Ve{$i}
				  //st_Sa:=arPR_Sa{$i}
				  //st_sottoreparti:=arPR_sottoreparti{$i}
				  //st_bozza:=arPR_bozza{$i}
				  //st_stampato:=arPR_stampato{$i}
				  //st_barcode:=arPR_barcode{$i}
				  //st_testo:=arPR_testo{$i}
				  //st_soglia:=arPR_soglia{$i}
				  //st_importo:=arPR_importo{$i}
				
				
				
				
				C_PICTURE:C286($picture)
				BLOB TO PICTURE:C682(arPR_immagineBarcode{$i};$picture;"image/jpeg")
				st_immagineBarcode:=$picture
				
				If ($h>(hPaper-120))
					  //$h:=Print form("stampaListaPromozioni";Form footer)
					PAGE BREAK:C6(>)
					  //$h:=Print form("stampaListaPromozioni";Form header)
					  //pagina:=pagina+1
					  //stPagina:="Pag."+String(pagina)
				End if 
				
				$h:=$h+Print form:C5("stampaListaPromozioni";Form detail:K43:1)
			End for 
			  //While ($h<(hPaper-45))
			  //$h:=$h+Print form("stampaListaPromozioni";Form break0)
			  //If ($h>(hPaper-45))
			  //$h:=$h+Print form("stampaListaPromozioni";Form footer)
			  //End if 
			  //End while 
			PAGE BREAK:C6
		End if 
		
		
End case 
