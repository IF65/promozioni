//%attributes = {}
  // ----------------------------------------------------
  // User name (OS): if65
  // Date and time: 19/12/19, 22:02:38
  // ----------------------------------------------------
  // Method: pfPromozioniInserimento
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
		C_LONGINT:C283(<>promozioniInserimento)
		If (<>promozioniInserimento=0)
			<>promozioniInserimento:=New process:C317("pfPromozioniInserimento";1024*1024;"Promozioni Inserimento";"creaFinestra";*)
		Else 
			SHOW PROCESS:C325(<>promozioniInserimento)
			BRING TO FRONT:C326(<>promozioniInserimento)
		End if 
	: ($azione="creaFinestra")
		$wRef:=Open form window:C675("pfPromozioniInserimento";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("pfPromozioniInserimento")
		If (ok=1)
			pfPromozioniInserimento ("salvaPromozione")
		End if 
		
	: ($azione="inizializzaRicompense")
		ARRAY TEXT:C222(arRI_id;0)  //1
		ARRAY TEXT:C222(arRI_idPromozioni;0)  //2
		ARRAY REAL:C219(arRI_soglia;0)  //3
		ARRAY REAL:C219(arRI_ammontare;0)  //4
		ARRAY REAL:C219(arRI_limiteSconto;0)  //5
		ARRAY REAL:C219(arRI_taglio;0)  //6
		ARRAY TEXT:C222(arRI_descrizione;0)  //7
		ARRAY TEXT:C222(arRI_recordM;0)  //8
		ARRAY TEXT:C222(arRI_accumulatore;0)  //10
		ARRAY TEXT:C222(arRI_promovar;0)  //11
		ARRAY LONGINT:C221(arRI_tipoArea;0)  //12 -> promo messaggio
		ARRAY LONGINT:C221(arRI_ordinamentoInArea;0)  //13 -> promo messaggio
		ARRAY LONGINT:C221(arRI_progressivo;0)
		
	: ($azione="aggiungiRigaRicompense")
		APPEND TO ARRAY:C911(arRI_id;Generate UUID:C1066)
		APPEND TO ARRAY:C911(arRI_idPromozioni;vPR_id)
		APPEND TO ARRAY:C911(arRI_soglia;0)
		APPEND TO ARRAY:C911(arRI_ammontare;0)
		APPEND TO ARRAY:C911(arRI_limiteSconto;0)
		APPEND TO ARRAY:C911(arRI_taglio;0)
		APPEND TO ARRAY:C911(arRI_descrizione;"")
		APPEND TO ARRAY:C911(arRI_recordM;"")
		APPEND TO ARRAY:C911(arRI_accumulatore;"")
		APPEND TO ARRAY:C911(arRI_promovar;"")
		APPEND TO ARRAY:C911(arRI_tipoArea;0)
		APPEND TO ARRAY:C911(arRI_ordinamentoInArea;0)
		APPEND TO ARRAY:C911(arRI_progressivo;0)
		
	: ($azione="eliminaRigaRicompense")
		If (Count parameters:C259>=2) & ($2<=Size of array:C274(arRI_id))
			DELETE FROM ARRAY:C228(arRI_id;$2)
			DELETE FROM ARRAY:C228(arRI_idPromozioni;$2)
			DELETE FROM ARRAY:C228(arRI_soglia;$2)
			DELETE FROM ARRAY:C228(arRI_ammontare;$2)
			DELETE FROM ARRAY:C228(arRI_limiteSconto;$2)
			DELETE FROM ARRAY:C228(arRI_taglio;$2)
			DELETE FROM ARRAY:C228(arRI_descrizione;$2)
			DELETE FROM ARRAY:C228(arRI_recordM;$2)
			DELETE FROM ARRAY:C228(arRI_accumulatore;$2)
			DELETE FROM ARRAY:C228(arRI_promovar;$2)
			DELETE FROM ARRAY:C228(arRI_tipoArea;$2)
			DELETE FROM ARRAY:C228(arRI_ordinamentoInArea;$2)
			DELETE FROM ARRAY:C228(arRI_progressivo;$2)
		End if 
		
	: ($azione="visualizzaRicompense")
		Case of 
			: (vPR_Tipo="0034")
				OBJECT SET VISIBLE:C603(*;"articoli@";False:C215)
				
				OBJECT GET COORDINATES:C663(*;"ricompense02";$left;$top;$right;$bottom)
				If ($left<=500)
					OBJECT MOVE:C664(*;"ricompense01";0;0;372;0)
					OBJECT MOVE:C664(*;"ricompense02";372;0)
					OBJECT MOVE:C664(*;"ricompense03";372;0)
				End if 
				
				AL_SetColumnLongProperty (alpRicompense;3;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;5;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;6;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;7;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;8;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;9;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;10;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;11;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;12;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;13;ALP_Column_Visible;0;1)
				
				AL_SetColumnTextProperty (alpRicompense;5;ALP_Column_HeaderText;"Soglia")  //arRI_ammontare->"Imp."->40
				AL_SetColumnRealProperty (alpRicompense;5;ALP_Column_Width;60;1)
				AL_SetColumnTextProperty (alpRicompense;6;ALP_Column_HeaderText;"Ammont.")  //arRI_ammontare->"Imp."->40
				AL_SetColumnTextProperty (alpRicompense;6;ALP_Column_Format;<>formatInteger;1)
				AL_SetColumnLongProperty (alpRicompense;6;ALP_Column_HorAlign;2;1)  //center
				AL_SetColumnRealProperty (alpRicompense;6;ALP_Column_Width;60;1)
				AL_SetColumnTextProperty (alpRicompense;7;ALP_Column_HeaderText;"Passo")  //arRI_limiteSconto->"Lim."->40
				AL_SetColumnRealProperty (alpRicompense;7;ALP_Column_Width;60;1)
				AL_SetColumnTextProperty (alpRicompense;8;ALP_Column_HeaderText;"Pt. Passo")  //arRI_taglio->"Taglio"->40
				AL_SetColumnTextProperty (alpRicompense;8;ALP_Column_Format;<>formatInteger;1)
				AL_SetColumnLongProperty (alpRicompense;8;ALP_Column_HorAlign;2;1)  //center
				AL_SetColumnRealProperty (alpRicompense;8;ALP_Column_Width;60;1)
				
				AL_SetAreaLongProperty (alpRicompense;ALP_Area_AutoResizeColumn;4)
			: (vPR_Tipo="0070")
				OBJECT SET VISIBLE:C603(*;"articoli@";False:C215)
				
				OBJECT GET COORDINATES:C663(*;"ricompense02";$left;$top;$right;$bottom)
				If ($left<=500)
					OBJECT MOVE:C664(*;"ricompense01";0;0;372;0)
					OBJECT MOVE:C664(*;"ricompense02";372;0)
					OBJECT MOVE:C664(*;"ricompense03";372;0)
				End if 
				
				AL_SetColumnLongProperty (alpRicompense;3;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;5;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;6;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;7;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;8;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;9;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;10;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;11;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;12;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;13;ALP_Column_Visible;1;1)
			Else 
				OBJECT SET VISIBLE:C603(*;"articoli@";True:C214)
				OBJECT GET COORDINATES:C663(*;"ricompense02";$left;$top;$right;$bottom)
				If ($left>500)
					OBJECT MOVE:C664(*;"ricompense01";0;0;-372;0)
					OBJECT MOVE:C664(*;"ricompense02";-372;0)
					OBJECT MOVE:C664(*;"ricompense03";-372;0)
				End if 
				AL_SetColumnLongProperty (alpRicompense;3;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;5;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;6;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;7;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;8;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;9;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;10;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;11;ALP_Column_Visible;1;1)
				AL_SetColumnLongProperty (alpRicompense;12;ALP_Column_Visible;0;1)
				AL_SetColumnLongProperty (alpRicompense;13;ALP_Column_Visible;0;1)
				
				AL_SetColumnTextProperty (alpRicompense;5;ALP_Column_HeaderText;"Sogl.")  //arRI_ammontare->"Imp."->40
				AL_SetColumnRealProperty (alpRicompense;5;ALP_Column_Width;40;1)
				AL_SetColumnTextProperty (alpRicompense;6;ALP_Column_HeaderText;"Imp.")  //arRI_ammontare->"Imp."->40
				AL_SetColumnTextProperty (alpRicompense;6;ALP_Column_Format;<>formatCurrency;1)
				AL_SetColumnLongProperty (alpRicompense;6;ALP_Column_HorAlign;3;1)  //center
				AL_SetColumnRealProperty (alpRicompense;6;ALP_Column_Width;40;1)
				AL_SetColumnTextProperty (alpRicompense;7;ALP_Column_HeaderText;"Lim.")  //arRI_limiteSconto->"Lim."->40
				AL_SetColumnRealProperty (alpRicompense;7;ALP_Column_Width;40;1)
				AL_SetColumnTextProperty (alpRicompense;8;ALP_Column_HeaderText;"Taglio")  //arRI_taglio->"Taglio"->40
				AL_SetColumnTextProperty (alpRicompense;8;ALP_Column_Format;<>formatCurrency;1)
				AL_SetColumnLongProperty (alpRicompense;8;ALP_Column_HorAlign;3;1)  //center
				AL_SetColumnRealProperty (alpRicompense;8;ALP_Column_Width;40;1)
				
		End case 
		
	: ($azione="inizializzaArticoli")
		ARRAY TEXT:C222(arAR_id;0)  //1
		ARRAY TEXT:C222(arAR_idPromozioni;0)  //2
		ARRAY TEXT:C222(arAR_codiceArticolo;0)  //3
		ARRAY TEXT:C222(arAR_codiceReparto;0)  //4
		ARRAY TEXT:C222(arAR_barcode;0)  //5
		ARRAY TEXT:C222(arAR_descrizione;0)  //6
		ARRAY LONGINT:C221(arAR_molteplicita;0)  //7
		ARRAY LONGINT:C221(arAR_gruppo;0)  //8
		
	: ($azione="aggiungiRigaArticoli")
		INSERT IN ARRAY:C227(arAR_id;1)
		INSERT IN ARRAY:C227(arAR_idPromozioni;1)
		INSERT IN ARRAY:C227(arAR_codiceArticolo;1)
		INSERT IN ARRAY:C227(arAR_codiceReparto;1)
		INSERT IN ARRAY:C227(arAR_barcode;1)
		INSERT IN ARRAY:C227(arAR_descrizione;1)
		INSERT IN ARRAY:C227(arAR_molteplicita;1)
		INSERT IN ARRAY:C227(arAR_gruppo;1)
		arAR_id{1}:=Generate UUID:C1066
		arAR_idPromozioni{1}:=vPR_id
		arAR_codiceArticolo{1}:=""
		arAR_codiceReparto{1}:=""
		arAR_barcode{1}:=""
		arAR_descrizione{1}:=""
		arAR_molteplicita{1}:=0
		arAR_gruppo{1}:=1
		
	: ($azione="eliminaRigaArticoli")
		If (Count parameters:C259>=2) & ($2<=Size of array:C274(arAR_id))
			DELETE FROM ARRAY:C228(arAR_id;$2)
			DELETE FROM ARRAY:C228(arAR_idPromozioni;$2)
			DELETE FROM ARRAY:C228(arAR_codiceArticolo;$2)
			DELETE FROM ARRAY:C228(arAR_codiceReparto;$2)
			DELETE FROM ARRAY:C228(arAR_barcode;$2)
			DELETE FROM ARRAY:C228(arAR_descrizione;$2)
			DELETE FROM ARRAY:C228(arAR_molteplicita;$2)
			DELETE FROM ARRAY:C228(arAR_gruppo;$2)
		End if 
		
	: ($azione="inizializzaSedi")
		ARRAY TEXT:C222(arSE_id;0)  //1
		ARRAY TEXT:C222(arSE_idPromozioni;0)  //2
		ARRAY TEXT:C222(arSE_codice;0)  //3
		ARRAY TEXT:C222(arSE_descrizione;0)  //4
		
	: ($azione="inizializza")
		C_TEXT:C284(vPR_id)
		C_LONGINT:C283(vPR_codice)
		C_LONGINT:C283(vPR_codiceCatalina)
		C_TEXT:C284(vPR_tipo)
		C_TEXT:C284(vPR_descrizione)
		C_LONGINT:C283(vPR_ripetibilita)
		C_DATE:C307(vPR_dataInizio)
		C_DATE:C307(vPR_dataFine)
		C_TEXT:C284(vPR_oraInizio)
		C_TEXT:C284(vPR_oraFine)
		C_LONGINT:C283(vPR_tipoCliente)
		C_LONGINT:C283(vPR_categoria)
		C_TEXT:C284(vPR_calendarioSettimanale)
		C_LONGINT:C283(vPR_sottoreparti)
		C_BOOLEAN:C305(vPR_Do)
		C_BOOLEAN:C305(vPR_Lu)
		C_BOOLEAN:C305(vPR_Ma)
		C_BOOLEAN:C305(vPR_Me)
		C_BOOLEAN:C305(vPR_Gi)
		C_BOOLEAN:C305(vPR_Ve)
		C_BOOLEAN:C305(vPR_Sa)
		C_BOOLEAN:C305(vPR_bozza)
		C_BOOLEAN:C305(vPR_Stampato)
		C_BOOLEAN:C305(vPR_pmt)
		C_TEXT:C284(vPR_barcode)
		C_TEXT:C284(vPR_testo)
		
		vPR_id:=Generate UUID:C1066
		vPR_codice:=0
		vPR_codiceCatalina:=0
		vPR_tipo:="0000"
		vPR_descrizione:=""
		vPR_ripetibilita:=0
		vPR_dataInizio:=Current date:C33(*)
		vPR_dataFine:=Current date:C33(*)
		vPR_oraInizio:="00:00:00"
		vPR_oraFine:="23:59:00"
		vPR_tipoCliente:=0
		vPR_categoria:=0
		vPR_calendarioSettimanale:="1111111"
		vPR_sottoreparti:=0
		vPR_Do:=True:C214
		vPR_Lu:=True:C214
		vPR_Ma:=True:C214
		vPR_Me:=True:C214
		vPR_Gi:=True:C214
		vPR_Ve:=True:C214
		vPR_Sa:=True:C214
		vPR_bozza:=True:C214
		vPR_Stampato:=False:C215
		vPR_pmt:=False:C215
		vPR_barcode:=""
		vPR_testo:=""
		
		pfPromozioniInserimento ("inizializzaRicompense")
		pfPromozioniInserimento ("inizializzaArticoli")
		pfPromozioniInserimento ("inizializzaSedi")
		pfPromozioniInserimento ("inizializzaCategorie")
		
		ARRAY TEXT:C222(selTipo;0)
		ARRAY TEXT:C222(selTipoCodice;0)
		If (Size of array:C274(<>promoTipo)>0)
			For ($i;1;Size of array:C274(<>promoTipo))
				APPEND TO ARRAY:C911(selTipo;<>promoTipo{$i})
				APPEND TO ARRAY:C911(selTipoCodice;<>promoTipoCodice{$i})
			End for 
			selTipo:=1
			selTipo{0}:=selTipo{selTipo}
		End if 
		
		ARRAY TEXT:C222(selTipoCliente;0)
		APPEND TO ARRAY:C911(selTipoCliente;"0 - TUTTI")
		APPEND TO ARRAY:C911(selTipoCliente;"1 - CLIENTE")
		APPEND TO ARRAY:C911(selTipoCliente;"2 - DIPENDENTE")
		APPEND TO ARRAY:C911(selTipoCliente;"3 - CLIENTE E DIPENDENTE")
		APPEND TO ARRAY:C911(selTipoCliente;"4 - CLIENTE DI UNA CATEGORIA")
		APPEND TO ARRAY:C911(selTipoCliente;"5 - DIPENDENTE DI UNA CATEGORIA")
		APPEND TO ARRAY:C911(selTipoCliente;"6 - CLIENTE/DIPENDENTE DI UNA CATEGORIA")
		APPEND TO ARRAY:C911(selTipoCliente;"7 - SOLO CLIENTE/DIPENDENTE SENZA TESSERA")
		selTipoCliente:=1
		selTipoCliente{0}:=selTipoCliente{selTipoCliente}
		
	: ($azione="caricaArray")
		If (promozioneSelezionata#0)
			ARRAY TEXT:C222($arHeaderNames;0)
			ARRAY TEXT:C222($arHeaderValues;0)
			APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
			APPEND TO ARRAY:C911($arHeaderValues;"application/json")
			
			  //parametri
			C_OBJECT:C1216($request)
			OB SET:C1220($request;"function";"elencoPromozioni")
			OB SET:C1220($request;"id";arPR_id{promozioneSelezionata})
			
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
				ARRAY OBJECT:C1221($promozioni;0)
				JSON PARSE ARRAY:C1219($response;$promozioni)
				
				If (Size of array:C274($promozioni)=1)
					$calendario:=OB Get:C1224($promozioni{1};"calendarioSettimanale";Is text:K8:3)
					
					vPR_id:=OB Get:C1224($promozioni{1};"id";Is text:K8:3)
					vPR_codice:=OB Get:C1224($promozioni{1};"codice";Is longint:K8:6)
					vPR_codiceCatalina:=OB Get:C1224($promozioni{1};"codiceCatalina";Is longint:K8:6)
					vPR_tipo:=OB Get:C1224($promozioni{1};"tipo";Is text:K8:3)
					vPR_descrizione:=OB Get:C1224($promozioni{1};"descrizione";Is text:K8:3)
					vPR_ripetibilita:=OB Get:C1224($promozioni{1};"ripetibilita";Is real:K8:4)
					vPR_dataInizio:=OB Get:C1224($promozioni{1};"dataInizio";Is date:K8:7)
					vPR_dataFine:=OB Get:C1224($promozioni{1};"dataFine";Is date:K8:7)
					vPR_oraInizio:=OB Get:C1224($promozioni{1};"oraInizio";Is text:K8:3)
					vPR_oraFine:=OB Get:C1224($promozioni{1};"oraFine";Is text:K8:3)
					vPR_tipoCliente:=OB Get:C1224($promozioni{1};"tipoCliente";Is longint:K8:6)
					vPR_categoria:=OB Get:C1224($promozioni{1};"categoria";Is longint:K8:6)
					vPR_calendarioSettimanale:=$calendario
					vPR_Do:=Substring:C12($calendario;1;1)="1"
					vPR_Lu:=Substring:C12($calendario;2;1)="1"
					vPR_Ma:=Substring:C12($calendario;3;1)="1"
					vPR_Me:=Substring:C12($calendario;4;1)="1"
					vPR_Gi:=Substring:C12($calendario;5;1)="1"
					vPR_Ve:=Substring:C12($calendario;6;1)="1"
					vPR_Sa:=Substring:C12($calendario;7;1)="1"
					vPR_sottoreparti:=OB Get:C1224($promozioni{1};"sottoreparti";Is longint:K8:6)
					vPR_bozza:=(OB Get:C1224($promozioni{1};"bozza";Is longint:K8:6)=1)
					vPR_stampato:=(OB Get:C1224($promozioni{1};"stampato";Is longint:K8:6)=1)
					vPR_pmt:=(OB Get:C1224($promozioni{1};"pmt";Is longint:K8:6)=1)
					vPR_barcode:=OB Get:C1224($promozioni{1};"barcode";Is text:K8:3)
					vPR_testo:=OB Get:C1224($promozioni{1};"testo";Is text:K8:3)
					
					$n:=Find in array:C230(selTipoCodice;vPR_tipo)
					If ($n>0)
						selTipo:=$n
						selTipo{0}:=selTipo{$n}
					End if 
					
					selTipoCliente:=vPR_tipoCliente+1
					selTipoCliente{0}:=selTipoCliente{vPR_tipoCliente+1}
					
					  //ricompense - 01
					ARRAY OBJECT:C1221($ricompense;0)
					OB GET ARRAY:C1229($promozioni{1};"ricompense";$ricompense)
					For ($i;1;Size of array:C274($ricompense))
						APPEND TO ARRAY:C911(arRI_id;OB Get:C1224($ricompense{$i};"id";Is text:K8:3))
						APPEND TO ARRAY:C911(arRI_idPromozioni;OB Get:C1224($ricompense{$i};"idPromozioni";Is text:K8:3))
						APPEND TO ARRAY:C911(arRI_soglia;OB Get:C1224($ricompense{$i};"soglia";Is real:K8:4))
						APPEND TO ARRAY:C911(arRI_ammontare;OB Get:C1224($ricompense{$i};"ammontare";Is real:K8:4))
						APPEND TO ARRAY:C911(arRI_limiteSconto;OB Get:C1224($ricompense{$i};"limiteSconto";Is real:K8:4))
						APPEND TO ARRAY:C911(arRI_taglio;OB Get:C1224($ricompense{$i};"taglio";Is real:K8:4))
						APPEND TO ARRAY:C911(arRI_descrizione;OB Get:C1224($ricompense{$i};"descrizione";Is text:K8:3))
						APPEND TO ARRAY:C911(arRI_recordM;OB Get:C1224($ricompense{$i};"recordM";Is text:K8:3))
						APPEND TO ARRAY:C911(arRI_accumulatore;OB Get:C1224($ricompense{$i};"accumulatore";Is text:K8:3))
						APPEND TO ARRAY:C911(arRI_promovar;OB Get:C1224($ricompense{$i};"promovar";Is text:K8:3))
						APPEND TO ARRAY:C911(arRI_tipoArea;OB Get:C1224($ricompense{$i};"tipoArea";Is longint:K8:6))
						APPEND TO ARRAY:C911(arRI_ordinamentoInArea;OB Get:C1224($ricompense{$i};"ordinamentoInArea";Is longint:K8:6))
						APPEND TO ARRAY:C911(arRI_progressivo;OB Get:C1224($ricompense{$i};"progressivo";Is longint:K8:6))
					End for 
					
					  //articoli - 02
					ARRAY OBJECT:C1221($articoli;0)
					OB GET ARRAY:C1229($promozioni{1};"articoli";$articoli)
					For ($i;1;Size of array:C274($articoli))
						APPEND TO ARRAY:C911(arAR_id;OB Get:C1224($articoli{$i};"id";Is text:K8:3))
						APPEND TO ARRAY:C911(arAR_idPromozioni;OB Get:C1224($articoli{$i};"idPromozioni";Is text:K8:3))
						APPEND TO ARRAY:C911(arAR_codiceArticolo;OB Get:C1224($articoli{$i};"codiceArticolo";Is text:K8:3))
						APPEND TO ARRAY:C911(arAR_codiceReparto;OB Get:C1224($articoli{$i};"codiceReparto";Is text:K8:3))
						APPEND TO ARRAY:C911(arAR_barcode;OB Get:C1224($articoli{$i};"barcode";Is text:K8:3))
						APPEND TO ARRAY:C911(arAR_descrizione;OB Get:C1224($articoli{$i};"descrizione";Is text:K8:3))
						APPEND TO ARRAY:C911(arAR_molteplicita;OB Get:C1224($articoli{$i};"molteplicita";Is longint:K8:6))
						APPEND TO ARRAY:C911(arAR_gruppo;OB Get:C1224($articoli{$i};"gruppo";Is longint:K8:6))
					End for 
					SORT ARRAY:C229(arAR_codiceReparto;arAR_barcode;arAR_codiceArticolo;arAR_descrizione;arAR_molteplicita;arAR_idPromozioni;arAR_gruppo;arAR_id;>)
					
					  //sedi
					ARRAY OBJECT:C1221($sedi;0)
					OB GET ARRAY:C1229($promozioni{1};"sedi";$sedi)
					For ($i;1;Size of array:C274($sedi))
						$sedeSelezionata:=OB Get:C1224($sedi{$i};"codiceSede";Is text:K8:3)
						For ($n;1;Size of array:C274(<>sedi))
							If (<>sedi{$n}.codice=$sedeSelezionata)
								APPEND TO ARRAY:C911(arSE_id;$sedi{$i}.id)
								APPEND TO ARRAY:C911(arSE_idPromozioni;$sedi{$i}.idPromozioni)
								APPEND TO ARRAY:C911(arSE_codice;<>sedi{$n}.codice)
								APPEND TO ARRAY:C911(arSE_descrizione;<>sedi{$n}.codice+" - "+<>sedi{$n}.negozio_descrizione)
							End if 
						End for 
					End for 
					SORT ARRAY:C229(arSE_codice;arSE_descrizione;arSE_idPromozioni;arSE_id;>)
				End if 
			End if 
		End if 
		
	: ($azione="salvaPromozione")
		If (vPR_codice=0) & (Not:C34(vPR_bozza))
			$codice:=utlProgressivoCrea (<>progPromozione)
			If ($codice>0)
				vPR_codice:=$codice
			End if 
		End if 
		
		C_OBJECT:C1216($promozione)
		OB SET:C1220($promozione;"id";vPR_id)
		OB SET:C1220($promozione;"codice";vPR_codice)
		OB SET:C1220($promozione;"codiceCatalina";vPR_codiceCatalina)
		OB SET:C1220($promozione;"tipo";vPR_tipo)
		OB SET:C1220($promozione;"descrizione";vPR_descrizione)
		OB SET:C1220($promozione;"ripetibilita";vPR_ripetibilita)
		OB SET:C1220($promozione;"dataInizio";vPR_dataInizio)
		OB SET:C1220($promozione;"dataFine";vPR_dataFine)
		OB SET:C1220($promozione;"oraInizio";vPR_oraInizio)
		OB SET:C1220($promozione;"oraFine";vPR_oraFine)
		OB SET:C1220($promozione;"calendarioSettimanale";vPR_calendarioSettimanale)
		OB SET:C1220($promozione;"tipoCliente";vPR_tipoCliente)
		OB SET:C1220($promozione;"categoria";vPR_categoria)
		OB SET:C1220($promozione;"sottoreparti";vPR_sottoreparti)
		OB SET:C1220($promozione;"bozza";Choose:C955(vPR_bozza;1;0))
		OB SET:C1220($promozione;"stampato";Choose:C955(vPR_stampato;1;0))
		OB SET:C1220($promozione;"pmt";Choose:C955(vPR_pmt;1;0))
		OB SET:C1220($promozione;"barcode";vPR_barcode)
		OB SET:C1220($promozione;"testo";vPR_testo)
		
		$recordM:=""
		If (Not:C34(vPR_bozza))
			$recordM:="00:"+vPR_tipo+"-"+String:C10(vPR_codice)
		End if 
		
		C_OBJECT:C1216($ricompensa)
		ARRAY OBJECT:C1221($ricompense;0)
		For ($i;1;Size of array:C274(arRI_id))
			CLEAR VARIABLE:C89($ricompensa)
			OB SET:C1220($ricompensa;"id";arRI_id{$i})
			OB SET:C1220($ricompensa;"idPromozioni";arRI_idPromozioni{$i})
			OB SET:C1220($ricompensa;"soglia";arRI_soglia{$i})
			OB SET:C1220($ricompensa;"ammontare";arRI_ammontare{$i})
			OB SET:C1220($ricompensa;"limiteSconto";arRI_limiteSconto{$i})
			OB SET:C1220($ricompensa;"taglio";arRI_taglio{$i})
			OB SET:C1220($ricompensa;"descrizione";arRI_descrizione{$i})
			OB SET:C1220($ricompensa;"recordM";Choose:C955(arRI_recordM{$i}#"";arRI_recordM{$i};$recordM))
			OB SET:C1220($ricompensa;"accumulatore";arRI_accumulatore{$i})
			OB SET:C1220($ricompensa;"promovar";arRI_promovar{$i})
			OB SET:C1220($ricompensa;"tipoArea";arRI_tipoArea{$i})
			OB SET:C1220($ricompensa;"ordinamentoInArea";arRI_ordinamentoInArea{$i})
			OB SET:C1220($ricompensa;"progressivo";arRI_progressivo{$i})
			
			APPEND TO ARRAY:C911($ricompense;$ricompensa)
		End for 
		OB SET ARRAY:C1227($promozione;"ricompense";$ricompense)
		
		C_OBJECT:C1216($articolo)
		ARRAY OBJECT:C1221($articoli;0)
		For ($i;1;Size of array:C274(arAR_id))
			CLEAR VARIABLE:C89($articolo)
			OB SET:C1220($articolo;"id";arAR_id{$i})
			OB SET:C1220($articolo;"idPromozioni";arAR_idPromozioni{$i})
			OB SET:C1220($articolo;"codiceArticolo";arAR_codiceArticolo{$i})
			OB SET:C1220($articolo;"codiceReparto";arAR_codiceReparto{$i})
			OB SET:C1220($articolo;"barcode";arAR_barcode{$i})
			OB SET:C1220($articolo;"descrizione";arAR_descrizione{$i})
			OB SET:C1220($articolo;"molteplicita";arAR_molteplicita{$i})
			OB SET:C1220($articolo;"gruppo";arAR_gruppo{$i})
			APPEND TO ARRAY:C911($articoli;$articolo)
		End for 
		OB SET ARRAY:C1227($promozione;"articoli";$articoli)
		
		C_OBJECT:C1216($sede)
		ARRAY OBJECT:C1221($sedi;0)
		For ($i;1;Size of array:C274(arSE_id))
			CLEAR VARIABLE:C89($sede)
			OB SET:C1220($sede;"id";arSE_id{$i})
			OB SET:C1220($sede;"idPromozioni";arSE_idPromozioni{$i})
			OB SET:C1220($sede;"codiceSede";arSE_codice{$i})
			APPEND TO ARRAY:C911($sedi;$sede)
		End for 
		OB SET ARRAY:C1227($promozione;"sedi";$sedi)
		
		ARRAY TEXT:C222($arHeaderNames;0)
		ARRAY TEXT:C222($arHeaderValues;0)
		APPEND TO ARRAY:C911($arHeaderNames;"Content-Type")
		APPEND TO ARRAY:C911($arHeaderValues;"application/json")
		
		C_OBJECT:C1216($request)
		OB SET:C1220($request;"function";"salva")
		OB SET:C1220($request;"promozione";$promozione)
		
		  //$text:=JSON Stringify($request;*)
		  //SET TEXT TO PASTEBOARD($text)
		
		$body:=JSON Stringify:C1217($request)
		
		$sql:="/promozioni/src/promozioni.php"
		C_TEXT:C284($response)
		
		<>error:=0
		HTTP SET OPTION:C1160(HTTP timeout:K71:10;30)
		ON ERR CALL:C155("utlOnErrCall")
		$httpResponse:=HTTP Request:C1158(HTTP POST method:K71:2;<>itmServer+$sql;$body;$response;$arHeaderNames;$arHeaderValues)
		ON ERR CALL:C155("")
		If ($httpResponse=200) & (<>error=0)
			If (promozioneSelezionata=0)
				APPEND TO ARRAY:C911(arPR_id;vPR_id)
				APPEND TO ARRAY:C911(arPR_codice;vPR_codice)
				APPEND TO ARRAY:C911(arPR_codiceCatalina;vPR_codiceCatalina)
				APPEND TO ARRAY:C911(arPR_tipo;vPR_tipo)
				APPEND TO ARRAY:C911(arPR_descrizione;vPR_descrizione)
				APPEND TO ARRAY:C911(arPR_ripetibilita;vPR_ripetibilita)
				APPEND TO ARRAY:C911(arPR_dataInizio;vPR_dataInizio)
				APPEND TO ARRAY:C911(arPR_dataFine;vPR_dataFine)
				APPEND TO ARRAY:C911(arPR_oraInizio;vPR_oraInizio)
				APPEND TO ARRAY:C911(arPR_oraFine;vPR_oraFine)
				APPEND TO ARRAY:C911(arPR_tipoCliente;vPR_tipoCliente)
				APPEND TO ARRAY:C911(arPR_categoria;vPR_categoria)
				APPEND TO ARRAY:C911(arPR_calendarioSettimanale;vPR_calendarioSettimanale)
				APPEND TO ARRAY:C911(arPR_Do;vPR_Do)
				APPEND TO ARRAY:C911(arPR_Lu;vPR_Lu)
				APPEND TO ARRAY:C911(arPR_Ma;vPR_Ma)
				APPEND TO ARRAY:C911(arPR_Me;vPR_Me)
				APPEND TO ARRAY:C911(arPR_Gi;vPR_Gi)
				APPEND TO ARRAY:C911(arPR_Ve;vPR_Ve)
				APPEND TO ARRAY:C911(arPR_Sa;vPR_Sa)
				APPEND TO ARRAY:C911(arPR_sottoreparti;vPR_sottoreparti)
				APPEND TO ARRAY:C911(arPR_bozza;vPR_bozza)
				APPEND TO ARRAY:C911(arPR_stampato;vPR_stampato)
				APPEND TO ARRAY:C911(arPR_pmt;vPR_pmt)
				APPEND TO ARRAY:C911(arPR_barcode;vPR_barcode)
				APPEND TO ARRAY:C911(arPR_testo;vPR_testo)
				APPEND TO ARRAY:C911(arPR_soglia;0)
				APPEND TO ARRAY:C911(arPR_importo;0)
				APPEND TO ARRAY:C911(arPR_numeroSedi;0)
				
			Else 
				arPR_id{promozioneSelezionata}:=vPR_id
				arPR_codice{promozioneSelezionata}:=vPR_codice
				arPR_codiceCatalina{promozioneSelezionata}:=vPR_codiceCatalina
				arPR_tipo{promozioneSelezionata}:=vPR_tipo
				arPR_descrizione{promozioneSelezionata}:=vPR_descrizione
				arPR_ripetibilita{promozioneSelezionata}:=vPR_ripetibilita
				arPR_dataInizio{promozioneSelezionata}:=vPR_dataInizio
				arPR_dataFine{promozioneSelezionata}:=vPR_dataFine
				arPR_oraInizio{promozioneSelezionata}:=vPR_oraInizio
				arPR_oraFine{promozioneSelezionata}:=vPR_oraFine
				arPR_calendarioSettimanale{promozioneSelezionata}:=vPR_calendarioSettimanale
				arPR_tipoCliente{promozioneSelezionata}:=vPR_tipoCliente
				arPR_categoria{promozioneSelezionata}:=vPR_categoria
				arPR_Do{promozioneSelezionata}:=vPR_Do
				arPR_Lu{promozioneSelezionata}:=vPR_Lu
				arPR_Ma{promozioneSelezionata}:=vPR_Ma
				arPR_Me{promozioneSelezionata}:=vPR_Me
				arPR_Gi{promozioneSelezionata}:=vPR_Gi
				arPR_Ve{promozioneSelezionata}:=vPR_Ve
				arPR_Sa{promozioneSelezionata}:=vPR_Sa
				arPR_sottoreparti{promozioneSelezionata}:=vPR_sottoreparti
				arPR_bozza{promozioneSelezionata}:=vPR_bozza
				arPR_stampato{promozioneSelezionata}:=vPR_stampato
				arPR_pmt{promozioneSelezionata}:=vPR_pmt
				arPR_barcode{promozioneSelezionata}:=vPR_barcode
				arPR_testo{promozioneSelezionata}:=vPR_testo
				
				arPR_soglia{promozioneSelezionata}:=0
				arPR_importo{promozioneSelezionata}:=0
				If (Size of array:C274(arRI_id)=1)
					arPR_soglia{promozioneSelezionata}:=arRI_soglia{1}
					arPR_importo{promozioneSelezionata}:=arRI_ammontare{1}
				End if 
				
				arPR_numeroSedi{promozioneSelezionata}:=Size of array:C274(arSE_id)
				
			End if 
			CANCEL:C270
		Else 
			ALERT:C41("Errore durante il salvataggio dei dati!";"Continua")
		End if 
		
End case 
