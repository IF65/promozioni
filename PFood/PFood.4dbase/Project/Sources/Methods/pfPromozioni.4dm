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
			<>promozioni:=New process:C317("pfPromozioni"; 1024*1024; "Promozioni Food"; "creaFinestra"; *)
		Else 
			SHOW PROCESS:C325(<>promozioni)
			BRING TO FRONT:C326(<>promozioni)
		End if 
	: ($azione="creaFinestra")
		$wRef:=Open form window:C675("pfPromozioni"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("pfPromozioni")
		
	: ($azione="inizializzaRicerca")
		$currentDate:=Current date:C33(*)
		COPY ARRAY:C226(<>promoTipo; srcTipoPromozione)
		COPY ARRAY:C226(<>promoTipoCodice; srcTipoPromozioneCodice)
		srcTipoPromozione:=1
		srcBozza:=0
		srcUsaDataCorrente:=True:C214
		srcDataCorrente:=$currentDate
		srcDataDa:=Date:C102(String:C10(Year of:C25($currentDate)-1; "0000")+"-01-01T00:00:00")
		srcDataA:=Date:C102(String:C10(Year of:C25($currentDate)+1; "0000")+"-12-31T00:00:00")
		srcCodicePromozione:=0
		srcBarcode:=""
		srcDescrizione:=""
		
	: ($azione="inizializzaArray")
		C_COLLECTION:C1488(promozioni)
		promozioni:=New collection:C1472()
		
	: ($azione="caricaArray")
		ARRAY TEXT:C222($arHeaderNames; 0)
		ARRAY TEXT:C222($arHeaderValues; 0)
		APPEND TO ARRAY:C911($arHeaderNames; "Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues; "application/json")
		
		//parametri
		C_OBJECT:C1216($request)
		OB SET:C1220($request; "function"; "elencoPromozioni")
		If (srcCodicePromozione#0)
			OB SET:C1220($request; "codice"; srcCodicePromozione)
		End if 
		If (srcBarcode#"")
			OB SET:C1220($request; "barcode"; srcBarcode)
		End if 
		If (srcDescrizione#"")
			OB SET:C1220($request; "descrizione"; srcDescrizione)
		End if 
		If (srcTipoPromozione>1)
			OB SET:C1220($request; "tipo"; srcTipoPromozioneCodice{srcTipoPromozione})
		End if 
		If (srcUsaDataCorrente)
			If (srcDataCorrente#!00-00-00!)
				OB SET:C1220($request; "dataCorrente"; Substring:C12(String:C10(srcDataCorrente; ISO date:K1:8); 1; 10))
			End if 
		Else 
			If (srcDataDa#!00-00-00!)
				OB SET:C1220($request; "dallaData"; Substring:C12(String:C10(srcDataDa; ISO date:K1:8); 1; 10))
			End if 
			If (srcDataA#!00-00-00!)
				OB SET:C1220($request; "allaData"; Substring:C12(String:C10(srcDataA; ISO date:K1:8); 1; 10))
			End if 
		End if 
		If (srcBozza=0)
			OB SET:C1220($request; "bozza"; False:C215)
		End if 
		If (srcBozza=1)
			OB SET:C1220($request; "bozza"; True:C214)
		End if 
		utlTermometro("apri")
		utlTermometro("mostra"; "Caricamento in corso...")
		
		$body:=JSON Stringify:C1217($request)
		//SET TEXT TO PASTEBOARD($body)
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10; 45)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2; <>itmServer+$sql; $body; $response; $arHeaderNames; $arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse=200) & (<>error=0)
			pfPromozioni("inizializzaArray")
			ARRAY OBJECT:C1221($elencoPromozioni; 0)
			JSON PARSE ARRAY:C1219($response; $elencoPromozioni)
			For ($i; 1; Size of array:C274($elencoPromozioni))
				$promozione:=cs:C1710.Promozione.new()
				If ($promozione.object2Promozione(->$elencoPromozioni{$i}))
					promozioni.push($promozione)
				Else 
					ALERT:C41("Promozione non caricata!"; "Continua")
				End if 
			End for 
		End if 
		
		utlTermometro("chiudi")
		
	: ($azione="inserimento")
		C_OBJECT:C1216($bkp)
		promozioneCorrente.promozione2Object(->$bkp)
		
		$wRef:=Open form window:C675("pfPromozioniInserimento"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("pfPromozioniInserimento")
		If (ok=1)
			If (promozioneCorrente.codice=0) & (Not:C34(promozioneCorrente.bozza))
				$codice:=utlProgressivoCrea(<>progPromozione)
				If ($codice>0)
					promozioneCorrente.codice:=$codice
				End if 
			End if 
			
			C_OBJECT:C1216($promozione)
			$test:=promozioneCorrente.promozione2Object(->$promozione)
			
			ARRAY TEXT:C222($arHeaderNames; 0)
			ARRAY TEXT:C222($arHeaderValues; 0)
			APPEND TO ARRAY:C911($arHeaderNames; "Content-Type")
			APPEND TO ARRAY:C911($arHeaderValues; "application/json")
			
			C_OBJECT:C1216($request)
			OB SET:C1220($request; "function"; "salva")
			OB SET:C1220($request; "promozione"; $promozione)
			
			$body:=JSON Stringify:C1217($request)
			SET TEXT TO PASTEBOARD:C523($body)
			$sql:="/promozioni/src/promozioni.php"
			C_TEXT:C284($response)
			
			<>error:=0
			HTTP SET OPTION:C1160(HTTP timeout:K71:10; 30)
			ON ERR CALL:C155("utlOnErrCall")
			$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2; <>itmServer+$sql; $body; $response; $arHeaderNames; $arHeaderValues)
			ON ERR CALL:C155("")
			If ($httpResponse#200) | (<>error#0)
				promozioni[promozioneCorrentePosizione].object2Promozione(->$bkp)
				ALERT:C41("Errore durante il salvataggio dei dati!"; "Continua")
			End if 
			
		Else 
			promozioni[promozioneCorrentePosizione-1].object2Promozione(->$bkp)
		End if 
		
	: ($azione="visualizzaRicompense")
		Case of 
			: (promozioneCorrente.tipo="0034")
				OBJECT SET VISIBLE:C603(*; "articoli@"; False:C215)
				
				OBJECT GET COORDINATES:C663(*; "ricompense02"; $left; $top; $right; $bottom)
				If ($left<=500)
					OBJECT MOVE:C664(*; "ricompense01"; 0; 0; 372; 0)
					OBJECT MOVE:C664(*; "ricompense02"; 372; 0)
					OBJECT MOVE:C664(*; "ricompense03"; 372; 0)
				End if 
				
				//AL_SetColumnLongProperty(alpRicompense; 3; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 5; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 6; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 7; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 8; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 9; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 10; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 11; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 12; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 13; ALP_Column_Visible; 0; 1)
				
				//AL_SetColumnTextProperty(alpRicompense; 5; ALP_Column_HeaderText; "Soglia")  //arRI_ammontare->"Imp."->40
				//AL_SetColumnRealProperty(alpRicompense; 5; ALP_Column_Width; 60; 1)
				//AL_SetColumnTextProperty(alpRicompense; 6; ALP_Column_HeaderText; "Ammont.")  //arRI_ammontare->"Imp."->40
				//AL_SetColumnTextProperty(alpRicompense; 6; ALP_Column_Format; <>formatInteger; 1)
				//AL_SetColumnLongProperty(alpRicompense; 6; ALP_Column_HorAlign; 2; 1)  //center
				//AL_SetColumnRealProperty(alpRicompense; 6; ALP_Column_Width; 60; 1)
				//AL_SetColumnTextProperty(alpRicompense; 7; ALP_Column_HeaderText; "Passo")  //arRI_limiteSconto->"Lim."->40
				//AL_SetColumnRealProperty(alpRicompense; 7; ALP_Column_Width; 60; 1)
				//AL_SetColumnTextProperty(alpRicompense; 8; ALP_Column_HeaderText; "Pt. Passo")  //arRI_taglio->"Taglio"->40
				//AL_SetColumnTextProperty(alpRicompense; 8; ALP_Column_Format; <>formatInteger; 1)
				//AL_SetColumnLongProperty(alpRicompense; 8; ALP_Column_HorAlign; 2; 1)  //center
				//AL_SetColumnRealProperty(alpRicompense; 8; ALP_Column_Width; 60; 1)
				
				//AL_SetAreaLongProperty(alpRicompense; ALP_Area_AutoResizeColumn; 4)
			: (promozioneCorrente.tipo="0070")
				OBJECT SET VISIBLE:C603(*; "articoli@"; False:C215)
				
				OBJECT GET COORDINATES:C663(*; "ricompense02"; $left; $top; $right; $bottom)
				If ($left<=500)
					OBJECT MOVE:C664(*; "ricompense01"; 0; 0; 372; 0)
					OBJECT MOVE:C664(*; "ricompense02"; 372; 0)
					OBJECT MOVE:C664(*; "ricompense03"; 372; 0)
				End if 
				
				//AL_SetColumnLongProperty(alpRicompense; 3; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 5; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 6; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 7; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 8; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 9; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 10; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 11; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 12; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 13; ALP_Column_Visible; 1; 1)
			Else 
				OBJECT SET VISIBLE:C603(*; "articoli@"; True:C214)
				OBJECT GET COORDINATES:C663(*; "ricompense02"; $left; $top; $right; $bottom)
				If ($left>500)
					OBJECT MOVE:C664(*; "ricompense01"; 0; 0; -372; 0)
					OBJECT MOVE:C664(*; "ricompense02"; -372; 0)
					OBJECT MOVE:C664(*; "ricompense03"; -372; 0)
				End if 
				//AL_SetColumnLongProperty(alpRicompense; 3; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 5; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 6; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 7; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 8; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 9; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 10; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 11; ALP_Column_Visible; 1; 1)
				//AL_SetColumnLongProperty(alpRicompense; 12; ALP_Column_Visible; 0; 1)
				//AL_SetColumnLongProperty(alpRicompense; 13; ALP_Column_Visible; 0; 1)
				
				//AL_SetColumnTextProperty(alpRicompense; 5; ALP_Column_HeaderText; "Sogl.")  //arRI_ammontare->"Imp."->40
				//AL_SetColumnRealProperty(alpRicompense; 5; ALP_Column_Width; 40; 1)
				//AL_SetColumnTextProperty(alpRicompense; 6; ALP_Column_HeaderText; "Imp.")  //arRI_ammontare->"Imp."->40
				//AL_SetColumnTextProperty(alpRicompense; 6; ALP_Column_Format; <>formatCurrency; 1)
				//AL_SetColumnLongProperty(alpRicompense; 6; ALP_Column_HorAlign; 3; 1)  //center
				//AL_SetColumnRealProperty(alpRicompense; 6; ALP_Column_Width; 40; 1)
				//AL_SetColumnTextProperty(alpRicompense; 7; ALP_Column_HeaderText; "Lim.")  //arRI_limiteSconto->"Lim."->40
				//AL_SetColumnRealProperty(alpRicompense; 7; ALP_Column_Width; 40; 1)
				//AL_SetColumnTextProperty(alpRicompense; 8; ALP_Column_HeaderText; "Taglio")  //arRI_taglio->"Taglio"->40
				//AL_SetColumnTextProperty(alpRicompense; 8; ALP_Column_Format; <>formatCurrency; 1)
				//AL_SetColumnLongProperty(alpRicompense; 8; ALP_Column_HorAlign; 3; 1)  //center
				//AL_SetColumnRealProperty(alpRicompense; 8; ALP_Column_Width; 40; 1)
				
		End case 
		
End case 
