//%attributes = {}
  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 20/08/19, 10:11:28
  // ----------------------------------------------------
  // Method: pfNegozi
  // Description
  // 
  //
  // Parameters
  // ----------------------------------------------------

C_TEXT:C284($1)
C_LONGINT:C283($2)

$azione:=""
If (Count parameters:C259>=1)
	$azione:=$1
End if 

Case of 
	: ($azione="")
		C_LONGINT:C283(<>Negozi)
		If (<>Negozi=0)
			<>Negozi:=New process:C317("pfNegozi";1024*1024;"Sedi";"creaFinestra";*)
		Else 
			SHOW PROCESS:C325(<>Negozi)
			BRING TO FRONT:C326(<>Negozi)
		End if 
	: ($azione="creaFinestra")
		pfNegozi ("inizializza")
		$wRef:=Open form window:C675("pfNegozi";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfNegozi")
		If (ok=1)
			
		End if 
		
	: ($azione="inizializzaRicerca")
		ARRAY TEXT:C222(srcSocietaCodice;0)
		ARRAY TEXT:C222(srcSocietaDescrizione;0)
		For ($i;1;Size of array:C274(<>sedi))
			If (Find in array:C230(srcSocietaCodice;<>sedi{$i}.societa)<0)
				APPEND TO ARRAY:C911(srcSocietaCodice;<>sedi{$i}.societa)
				APPEND TO ARRAY:C911(srcSocietaDescrizione;<>sedi{$i}.societa+" - "+<>sedi{$i}.societa_descrizione)
			End if 
		End for 
		SORT ARRAY:C229(srcSocietaDescrizione;srcSocietaCodice;>)
		INSERT IN ARRAY:C227(srcSocietaCodice;1;2)
		INSERT IN ARRAY:C227(srcSocietaDescrizione;1;2)
		srcSocietaCodice{1}:=""
		srcSocietaDescrizione{1}:="TUTTE LE SOCIETA'"
		srcSocietaCodice{2}:=""
		srcSocietaDescrizione{2}:="-"
		srcSocietaDescrizione:=1
		
		ARRAY TEXT:C222(srcMarchio;0)
		For ($i;1;Size of array:C274(<>sedi))
			If (Find in array:C230(srcMarchio;<>sedi{$i}.marchio)<0)
				APPEND TO ARRAY:C911(srcMarchio;<>sedi{$i}.marchio)
			End if 
		End for 
		SORT ARRAY:C229(srcMarchio;>)
		INSERT IN ARRAY:C227(srcMarchio;1;2)
		srcMarchio{1}:="TUTTI I MARCHI"
		srcMarchio{2}:="-"
		srcMarchio:=1
		
		srcNegozioCodice:=""
		srcNegozioDescrizione:=""
		srcSoloNegoziAperti:=1
		srcSottoreparti:=2
		
	: ($azione="inizializzaArray")
		ARRAY BOOLEAN:C223(arNEG_abilita;0)
		ARRAY TEXT:C222(arNEG_catalina_codice_catena;0)
		ARRAY TEXT:C222(arNEG_catalina_codice_negozio;0)
		ARRAY BOOLEAN:C223(arNEG_chalco;0)
		ARRAY TEXT:C222(arNEG_codice;0)
		ARRAY TEXT:C222(arNEG_codice_ca;0)
		ARRAY TEXT:C222(arNEG_codice_gameTekk;0)
		ARRAY TEXT:C222(arNEG_codice_interno;0)
		ARRAY TEXT:C222(arNEG_codice_mt;0)
		ARRAY DATE:C224(arNEG_data_fine;0)
		ARRAY DATE:C224(arNEG_data_inizio;0)
		ARRAY BOOLEAN:C223(arNEG_invio_dati_copre;0)
		ARRAY BOOLEAN:C223(arNEG_invio_dati_gre;0)
		ARRAY BOOLEAN:C223(arNEG_invio_giacenze_copre;0)
		ARRAY BOOLEAN:C223(arNEG_invio_giacenze_gre;0)
		ARRAY TEXT:C222(arNEG_ip;0)
		ARRAY TEXT:C222(arNEG_ip_mtx;0)
		ARRAY TEXT:C222(arNEG_marchio;0)
		ARRAY TEXT:C222(arNEG_negozio;0)
		ARRAY TEXT:C222(arNEG_negozio_descrizione;0)
		ARRAY TEXT:C222(arNEG_password;0)
		ARRAY TEXT:C222(arNEG_percorso;0)
		ARRAY BOOLEAN:C223(arNEG_recupero_anagdafi;0)
		ARRAY TEXT:C222(arNEG_rootPassword;0)
		ARRAY TEXT:C222(arNEG_rootUser;0)
		ARRAY TEXT:C222(arNEG_societa;0)
		ARRAY TEXT:C222(arNEG_societa_descrizione;0)
		ARRAY BOOLEAN:C223(arNEG_sottoreparti;0)
		ARRAY TEXT:C222(arNEG_tipo;0)
		ARRAY TEXT:C222(arNEG_utente;0)
		
	: ($azione="caricaArray")
		For ($i;1;Size of array:C274(selezioneSedi))
			APPEND TO ARRAY:C911(arNEG_abilita;(selezioneSedi{$i}.abilita="1"))
			APPEND TO ARRAY:C911(arNEG_catalina_codice_catena;selezioneSedi{$i}.catalina_codice_catena)
			APPEND TO ARRAY:C911(arNEG_catalina_codice_negozio;selezioneSedi{$i}.catalina_codice_negozio)
			APPEND TO ARRAY:C911(arNEG_chalco;(selezioneSedi{$i}.chalco="1"))
			APPEND TO ARRAY:C911(arNEG_codice;selezioneSedi{$i}.codice)
			APPEND TO ARRAY:C911(arNEG_codice_ca;selezioneSedi{$i}.codice_ca)
			APPEND TO ARRAY:C911(arNEG_codice_gameTekk;Choose:C955(selezioneSedi{$i}.codice_gameTekk=Null:C1517;"";selezioneSedi{$i}.codice_gameTekk))
			APPEND TO ARRAY:C911(arNEG_codice_interno;selezioneSedi{$i}.codice_interno)
			APPEND TO ARRAY:C911(arNEG_codice_mt;selezioneSedi{$i}.codice_mt)
			APPEND TO ARRAY:C911(arNEG_data_fine;Choose:C955(selezioneSedi{$i}.data_fine=Null:C1517;!00-00-00!;selezioneSedi{$i}.data_fine))
			APPEND TO ARRAY:C911(arNEG_data_inizio;selezioneSedi{$i}.data_inizio)
			APPEND TO ARRAY:C911(arNEG_invio_dati_copre;(selezioneSedi{$i}.invio_dati_copre="1"))
			APPEND TO ARRAY:C911(arNEG_invio_dati_gre;(selezioneSedi{$i}.invio_dati_gre="1"))
			APPEND TO ARRAY:C911(arNEG_invio_giacenze_copre;(selezioneSedi{$i}.invio_giacenze_copre="1"))
			APPEND TO ARRAY:C911(arNEG_invio_giacenze_gre;(selezioneSedi{$i}.invio_giacenze_gre="1"))
			APPEND TO ARRAY:C911(arNEG_ip;selezioneSedi{$i}.ip)
			APPEND TO ARRAY:C911(arNEG_ip_mtx;selezioneSedi{$i}.ip_mtx)
			APPEND TO ARRAY:C911(arNEG_marchio;selezioneSedi{$i}.marchio)
			APPEND TO ARRAY:C911(arNEG_negozio;selezioneSedi{$i}.negozio)
			APPEND TO ARRAY:C911(arNEG_negozio_descrizione;selezioneSedi{$i}.negozio_descrizione)
			APPEND TO ARRAY:C911(arNEG_password;selezioneSedi{$i}.password)
			APPEND TO ARRAY:C911(arNEG_percorso;selezioneSedi{$i}.percorso)
			APPEND TO ARRAY:C911(arNEG_recupero_anagdafi;(selezioneSedi{$i}.recupero_anagdafi="1"))
			APPEND TO ARRAY:C911(arNEG_rootPassword;selezioneSedi{$i}.rootPassword)
			APPEND TO ARRAY:C911(arNEG_rootUser;selezioneSedi{$i}.rootUser)
			APPEND TO ARRAY:C911(arNEG_societa;selezioneSedi{$i}.societa)
			APPEND TO ARRAY:C911(arNEG_societa_descrizione;selezioneSedi{$i}.societa_descrizione)
			APPEND TO ARRAY:C911(arNEG_sottoreparti;(selezioneSedi{$i}.sottoreparti="1"))
			APPEND TO ARRAY:C911(arNEG_tipo;selezioneSedi{$i}.tipo)
			APPEND TO ARRAY:C911(arNEG_utente;selezioneSedi{$i}.utente)
		End for 
		SORT ARRAY:C229(arNEG_codice;arNEG_catalina_codice_catena;arNEG_catalina_codice_negozio;arNEG_chalco;\
			arNEG_abilita;arNEG_codice_ca;arNEG_codice_gameTekk;arNEG_codice_interno;arNEG_codice_mt;\
			arNEG_data_fine;arNEG_data_inizio;arNEG_invio_dati_copre;arNEG_invio_dati_gre;arNEG_invio_giacenze_copre;\
			arNEG_invio_giacenze_gre;arNEG_ip;arNEG_ip_mtx;arNEG_marchio;arNEG_negozio;arNEG_negozio_descrizione;\
			arNEG_password;arNEG_percorso;arNEG_recupero_anagdafi;arNEG_rootPassword;arNEG_rootUser;arNEG_societa;\
			arNEG_societa_descrizione;arNEG_sottoreparti;arNEG_tipo;arNEG_utente;>)
		
	: ($azione="ricerca")
		$sediJson:=utlElencoNegozi 
		JSON PARSE ARRAY:C1219($sediJson;<>sedi)
		
		pfNegozi ("inizializzaArray")
		If (Size of array:C274(<>sedi)>0)
			COPY ARRAY:C226(<>sedi;selezioneSedi)
			
			If (srcSocietaDescrizione>1)
				For ($i;Size of array:C274(selezioneSedi);1;-1)
					If (selezioneSedi{$i}.societa#srcSocietaCodice{srcSocietaDescrizione})
						DELETE FROM ARRAY:C228(selezioneSedi;$i;1)
					End if 
				End for 
			End if 
			
			If (srcMarchio>1)
				For ($i;Size of array:C274(selezioneSedi);1;-1)
					If (selezioneSedi{$i}.marchio#srcMarchio{srcMarchio})
						DELETE FROM ARRAY:C228(selezioneSedi;$i;1)
					End if 
				End for 
			End if 
			
			If (srcSottoreparti<2)
				For ($i;Size of array:C274(selezioneSedi);1;-1)
					If (selezioneSedi{$i}.sottoreparti#String:C10(srcSottoreparti))
						DELETE FROM ARRAY:C228(selezioneSedi;$i;1)
					End if 
				End for 
			End if 
			
			If (srcSoloNegoziAperti<2)
				For ($i;Size of array:C274(selezioneSedi);1;-1)
					If (selezioneSedi{$i}.abilita#String:C10(srcSoloNegoziAperti))
						DELETE FROM ARRAY:C228(selezioneSedi;$i;1)
					End if 
				End for 
			End if 
			
			If (srcNegozioCodice#"")
				For ($i;Size of array:C274(selezioneSedi);1;-1)
					If (selezioneSedi{$i}.codice#(srcNegozioCodice+"@"))
						DELETE FROM ARRAY:C228(selezioneSedi;$i;1)
					End if 
				End for 
			End if 
			
			If (srcNegozioDescrizione#"")
				For ($i;Size of array:C274(selezioneSedi);1;-1)
					If (selezioneSedi{$i}.negozio_descrizione#("@"+srcNegozioDescrizione+"@"))
						DELETE FROM ARRAY:C228(selezioneSedi;$i;1)
					End if 
				End for 
			End if 
			
			pfNegozi ("caricaArray")
		End if 
		
	: ($azione="salva")
		  //$row:=AL_GetAreaLongProperty (alpNegozi;ALP_Area_SelRow)
		  //If ($row>0)
		  //C_OBJECT($gruppo)
		  //OB SET($gruppo;"id";arGR_id{$row})
		  //OB SET($gruppo;"descrizione";arGR_descrizione{$row})
		  //OB SET ARRAY($gruppo;"sedi";arSE_codiceSede)
		
		  //C_OBJECT($request)
		  //OB SET($request;"function";"salvaGruppoSedi")
		  //OB SET($request;"gruppoSedi";$gruppo)
		
		  //$body:=JSON Stringify($request)
		  //  //SET TEXT TO PASTEBOARD($body)
		
		  //ARRAY TEXT($arHeaderNames;0)
		  //ARRAY TEXT($arHeaderValues;0)
		  //APPEND TO ARRAY($arHeaderNames;"Content-Type")
		  //APPEND TO ARRAY($arHeaderValues;"application/json")
		
		  //$sql:="/promozioni/src/promozioni.php"
		  //C_TEXT($response)
		
		  //<>error:=0
		  //HTTP SET OPTION(HTTP timeout;30)
		  //ON ERR CALL("utlOnErrCall")
		  //$httpResponse:=HTTP Request(HTTP POST method;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		  //ON ERR CALL("")
		  //If ($httpResponse=200) & (<>error=0)
		  //TRACE
		  //End if 
		
		  //End if 
		
	: ($azione="aggiornaDisplay")
		pfNegozi ("updateDisplay")
		AL_SetAreaLongProperty (alpNegozi;ALP_Area_ScrollTop;0)
		AL_SetAreaLongProperty (alpNegozi;ALP_Area_SelRow;0)
		
	: ($azione="updateDisplay")
		AL_SetAreaLongProperty (alpNegozi;ALP_Area_UpdateData;0)
		
		$size:=Size of array:C274(arNEG_codice)
		$msg:="Gestione Negozi: "
		Case of 
			: ($size=0)
				$msg:=$msg+"Nessun Negozio Selezionato"
			: ($size=1)
				$msg:=$msg+"1 Negozio Selezionato"
			Else 
				$msg:=$msg+String:C10($size;"###,###,##0")+" Negozi Selezionati"
		End case 
		
		SET WINDOW TITLE:C213($msg)
		
End case 
