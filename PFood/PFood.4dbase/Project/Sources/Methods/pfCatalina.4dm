//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 15/03/20, 11:34:09
  // ----------------------------------------------------
  // Method: pfCatalina
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
		C_LONGINT:C283(<>catalina)
		If (<>catalina=0)
			<>catalina:=New process:C317("pfCatalina";1024*1024;"Catalina Caricamento Promozioni";"creaFinestra";*)
		Else 
			SHOW PROCESS:C325(<>catalina)
			BRING TO FRONT:C326(<>catalina)
		End if 
	: ($azione="creaFinestra")
		pfNegozi ("inizializza")
		$wRef:=Open form window:C675("pfCatalina";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfCatalina")
		If (ok=1)
			
		End if 
		
	: ($azione="inizializzaArray")
		ARRAY LONGINT:C221(arTC_id;0)
		ARRAY TEXT:C222(arTC_descrizione;0)
		ARRAY TEXT:C222(arTC_categoria;0)
		ARRAY TEXT:C222(arTC_tipo;0)
		ARRAY REAL:C219(arTC_valore;0)
		ARRAY REAL:C219(arTC_soglia;0)
		ARRAY DATE:C224(arTC_inizio;0)
		ARRAY DATE:C224(arTC_fine;0)
		ARRAY TEXT:C222(arTC_barcode;0)
		
	: ($azione="aggiungiRigaAdArray")
		APPEND TO ARRAY:C911(arTC_id;0)
		APPEND TO ARRAY:C911(arTC_descrizione;"")
		APPEND TO ARRAY:C911(arTC_categoria;"")
		APPEND TO ARRAY:C911(arTC_tipo;"")
		APPEND TO ARRAY:C911(arTC_valore;0)
		APPEND TO ARRAY:C911(arTC_soglia;0)
		APPEND TO ARRAY:C911(arTC_inizio;!00-00-00!)
		APPEND TO ARRAY:C911(arTC_fine;!00-00-00!)
		APPEND TO ARRAY:C911(arTC_barcode;"")
		
	: ($azione="aggiornaDisplay")
		pfCatalina ("updateDisplay")
		AL_SetAreaLongProperty (alpCatalina;ALP_Area_ScrollTop;0)
		AL_SetAreaLongProperty (alpCatalina;ALP_Area_SelRow;0)
		
	: ($azione="updateDisplay")
		AL_SetAreaLongProperty (alpCatalina;ALP_Area_UpdateData;0)
		
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
				
				$sql:="/ordiniNF/src/catalina2templatePromozioni.php"
				C_TEXT:C284($response)
				
				$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
				If ($httpResponse=200)
					$promozioni:=JSON Parse:C1218($response;Is object:K8:27)
					ARRAY OBJECT:C1221($righe;0)
					OB GET ARRAY:C1229($promozioni;"values";$righe)
					If (Size of array:C274($righe)>0)
						pfCatalina ("inizializzaArray")
						
						  // eleimino dal caricamento i codici promozione già utilizzati
						ARRAY LONGINT:C221($elencoCodici;0)
						For ($i;1;Size of array:C274($righe))
							$descrizione:=OB Get:C1224($righe{$i};"fascia";Is text:K8:3)
							If ($descrizione#"@OMAGGIO@")
								APPEND TO ARRAY:C911($elencoCodici;OB Get:C1224($righe{$i};"mclu";Is longint:K8:6))
							End if 
						End for 
						$elencoCodiciUsatiJson:=utlElencoCodiciCatalinaUsati (->$elencoCodici)
						ARRAY LONGINT:C221($elencoCodiciUsati;0)
						JSON PARSE ARRAY:C1219($elencoCodiciUsatiJson;$elencoCodiciUsati)
						
						For ($i;1;Size of array:C274($righe))
							$descrizione:=OB Get:C1224($righe{$i};"fascia";Is text:K8:3)
							$codice:=OB Get:C1224($righe{$i};"mclu";Is longint:K8:6)
							
							If ($descrizione#"@OMAGGIO@") & (Find in array:C230($elencoCodiciUsati;$codice)<0)
								pfCatalina ("aggiungiRigaAdArray")
								$nRec:=Size of array:C274(arTC_id)
								
								arTC_id{$nRec}:=$codice
								arTC_descrizione{$nRec}:=$descrizione
								arTC_categoria{$nRec}:=OB Get:C1224($righe{$i};"tipologia";Is text:K8:3)
								
								$tipo:=""
								Case of 
									: (arTC_categoria{$nRec}="PUNTI")
										$tipo:="ACPT"
									: (arTC_categoria{$nRec}="€")
										$tipo:="0481"
										If (arTC_descrizione{$nRec}="Total Store")
											$tipo:="0503"
										End if 
									: (arTC_categoria{$nRec}="%")
										$tipo:="0492"
								End case 
								arTC_tipo{$nRec}:=$tipo
								arTC_valore{$nRec}:=OB Get:C1224($righe{$i};"valoreFacciale";Is real:K8:4)
								arTC_soglia{$nRec}:=OB Get:C1224($righe{$i};"minimoSpesa";Is real:K8:4)
								arTC_inizio{$nRec}:=OB Get:C1224($righe{$i};"inizioValidita";Is date:K8:7)
								arTC_fine{$nRec}:=OB Get:C1224($righe{$i};"fineValidita";Is date:K8:7)
								$barcode:=OB Get:C1224($righe{$i};"barcode";Is text:K8:3)
								If ($barcode="0")
									$barcode:=""
								End if 
								arTC_barcode{$nRec}:=$barcode
							End if 
						End for 
						
						pfCatalina ("aggiornaDisplay")
					End if 
				Else 
					ALERT:C41("Errore nel caricamento file!";"Annulla")
				End if 
			End if 
			
		End if 
		
End case 
