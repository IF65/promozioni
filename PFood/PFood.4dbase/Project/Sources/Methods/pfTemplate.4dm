//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 15/03/20, 11:34:09
  // ----------------------------------------------------
  // Method: pfTemplate
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
		C_LONGINT:C283(<>template)
		If (<>template=0)
			<>template:=New process:C317("pfTemplate";1024*1024;"IF65 Caricamento Promozioni";"creaFinestra";*)
		Else 
			SHOW PROCESS:C325(<>template)
			BRING TO FRONT:C326(<>template)
		End if 
	: ($azione="creaFinestra")
		pfNegozi ("inizializza")
		$wRef:=Open form window:C675("pfTemplate";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfTemplate")
		If (ok=1)
			
		End if 
		
	: ($azione="inizializzaArray")
		ARRAY TEXT:C222(arTMPL_tipoPromozione;0)
		ARRAY LONGINT:C221(arTMPL_idIF65;0)
		ARRAY LONGINT:C221(arTMPL_numero;0)
		ARRAY LONGINT:C221(arTMPL_promovar;0)
		ARRAY TEXT:C222(arTMPL_denominazione;0)
		ARRAY REAL:C219(arTMPL_percentuale;0)
		ARRAY DATE:C224(arTMPL_dataInizio;0)
		ARRAY DATE:C224(arTMPL_dataFine;0)
		ARRAY TEXT:C222(arTMPL_barcodeGruppo1;0)
		ARRAY TEXT:C222(arTMPL_barcodeGruppo2;0)
		ARRAY TEXT:C222(arTMPL_codiciArticoloGruppo1;0)
		ARRAY TEXT:C222(arTMPL_codiciArticoloGruppo2;0)
		ARRAY TEXT:C222(arTMPL_aderenti;0)
		ARRAY TEXT:C222(arTMPL_aderentiGruppo;0)
		
	: ($azione="aggiungiRigaAdArray")
		APPEND TO ARRAY:C911(arTMPL_tipoPromozione;"")
		APPEND TO ARRAY:C911(arTMPL_idIF65;0)
		APPEND TO ARRAY:C911(arTMPL_numero;0)
		APPEND TO ARRAY:C911(arTMPL_promovar;0)
		APPEND TO ARRAY:C911(arTMPL_denominazione;"")
		APPEND TO ARRAY:C911(arTMPL_percentuale;0)
		APPEND TO ARRAY:C911(arTMPL_dataInizio;!00-00-00!)
		APPEND TO ARRAY:C911(arTMPL_dataFine;!00-00-00!)
		APPEND TO ARRAY:C911(arTMPL_barcodeGruppo1;"")
		APPEND TO ARRAY:C911(arTMPL_barcodeGruppo2;"")
		APPEND TO ARRAY:C911(arTMPL_codiciArticoloGruppo1;"")
		APPEND TO ARRAY:C911(arTMPL_codiciArticoloGruppo2;"")
		APPEND TO ARRAY:C911(arTMPL_aderenti;"")
		APPEND TO ARRAY:C911(arTMPL_aderentiGruppo;"")
		
	: ($azione="aggiornaDisplay")
		pfTemplate ("updateDisplay")
		AL_SetAreaLongProperty (alpTemplate;ALP_Area_ScrollTop;0)
		AL_SetAreaLongProperty (alpTemplate;ALP_Area_SelRow;0)
		
	: ($azione="updateDisplay")
		AL_SetAreaLongProperty (alpTemplate;ALP_Area_UpdateData;0)
		
	: ($azione="caricaArray")
		C_TIME:C306($f)
		$f:=Open document:C264("";".xlsx";Get pathname:K24:6)
		If (ok=1)
			$filePath:=document
			If (Test path name:C476($filePath)=Is a document:K24:1)
				C_BLOB:C604($file)
				DOCUMENT TO BLOB:C525($filePath;$file)
				
				$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				
				C_BLOB:C604($body)
				
				  // il boundary è arbitrario ma la sequenza che utilizzo non deve essere contenuta nel file inviato
				$boundary:=Generate UUID:C1066
				
				  // la costruzione del multipart deve seguire esattamente lo schema seguente
				  // costruisco la testata. Attenzione al Content-Type 
				$body_t:="--"+$boundary+$crlf
				$body_t:=$body_t+"Content-Disposition: form-data; name=\"userfile\"; filename=\""+Generate UUID:C1066+".xlsx\""+$crlf
				$body_t:=$body_t+"Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"+$crlf+$crlf
				TEXT TO BLOB:C554($body_t;$body;UTF8 text without length:K22:17;*)
				
				  // ora aggiungo il file
				$offset:=BLOB size:C605($body)
				COPY BLOB:C558($file;$body;0;$offset;BLOB size:C605($file))
				TEXT TO BLOB:C554($crlf;$body;UTF8 text without length:K22:17;*)
				
				  // e chiudo il multipart
				TEXT TO BLOB:C554("--"+$boundary+"--"+$crlf;$body;UTF8 text without length:K22:17;*)
				
				  // costruisco gli header
				ARRAY TEXT:C222($arHeaderNames;0)
				ARRAY TEXT:C222($arHeaderValues;0)
				APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
				APPEND TO ARRAY:C911($arHeaderValues;"multipart/form-data; boundary="+$boundary)
				APPEND TO ARRAY:C911($arHeaderNames;"Content-Length")
				APPEND TO ARRAY:C911($arHeaderValues;String:C10(BLOB size:C605($body)))
				
				$sql:="/ordiniNF/src/excel2TemplateIF65.php"
				C_TEXT:C284($response)
				
				$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
				If ($httpResponse=200)
					$template:=JSON Parse:C1218($response;Is object:K8:27)
					
					pfTemplate ("inizializzaArray")
					
					ARRAY TEXT:C222($promozioniUsate;0)
					OB GET PROPERTY NAMES:C1232($template;$promozioniUsate)
					For ($i;1;Size of array:C274($promozioniUsate))
						ARRAY OBJECT:C1221($promozioni;0)
						OB GET ARRAY:C1229($template;$promozioniUsate{$i};$promozioni)
						
						For ($j;1;Size of array:C274($promozioni))
							pfTemplate ("aggiungiRigaAdArray")
							$count:=Size of array:C274(arTMPL_idIF65)
							Case of 
								: ($promozioniUsate{$i}="0054")
									arTMPL_tipoPromozione{$count}:=$promozioniUsate{$i}
									arTMPL_idIF65{$count}:=OB Get:C1224($promozioni{$j};"idIF65";Is longint:K8:6)
									arTMPL_numero{$count}:=OB Get:C1224($promozioni{$j};"numero";Is longint:K8:6)
									arTMPL_promovar{$count}:=OB Get:C1224($promozioni{$j};"promovar";Is longint:K8:6)
									arTMPL_denominazione{$count}:=OB Get:C1224($promozioni{$j};"denominazione";Is text:K8:3)
									arTMPL_percentuale{$count}:=OB Get:C1224($promozioni{$j};"percentuale";Is real:K8:4)
									arTMPL_dataInizio{$count}:=OB Get:C1224($promozioni{$j};"dataInizio";Is date:K8:7)
									arTMPL_dataFine{$count}:=OB Get:C1224($promozioni{$j};"dataFine";Is date:K8:7)
									arTMPL_barcodeGruppo1{$count}:=OB Get:C1224($promozioni{$j};"barcodeGruppo1";Is text:K8:3)
									arTMPL_barcodeGruppo2{$count}:=OB Get:C1224($promozioni{$j};"barcodeGruppo2";Is text:K8:3)
									arTMPL_codiciArticoloGruppo1{$count}:=OB Get:C1224($promozioni{$j};"codiciArticoloGruppo1";Is text:K8:3)
									arTMPL_codiciArticoloGruppo2{$count}:=OB Get:C1224($promozioni{$j};"codiciArticoloGruppo2";Is text:K8:3)
									arTMPL_aderenti{$count}:=OB Get:C1224($promozioni{$j};"aderenti";Is text:K8:3)
									arTMPL_aderentiGruppo{$count}:=OB Get:C1224($promozioni{$j};"aderentiGruppo";Is text:K8:3)
							End case 
						End for 
					End for 
					
					pfTemplate ("aggiornaDisplay")
				End if 
			Else 
				ALERT:C41("Errore nel caricamento file!";"Annulla")
			End if 
		End if 
		
End case 
