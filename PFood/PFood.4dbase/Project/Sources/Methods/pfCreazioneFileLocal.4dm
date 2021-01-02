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

$soloCancellazione:=False:C215

$promozioneJson:=pfCaricamentoPromozione ($1)

ARRAY OBJECT:C1221($promozioni;0)
JSON PARSE ARRAY:C1219($promozioneJson;$promozioni)

If (Size of array:C274($promozioni)=1)
	ARRAY OBJECT:C1221($sedi;0)
	OB GET ARRAY:C1229($promozioni{1};"sedi";$sedi)
	COPY ARRAY:C226($sedi;$3->)
	
	$tipoPromozione:=OB Get:C1224($promozioni{1};"tipo";Is text:K8:3)
	
	ARRAY OBJECT:C1221($ricompense;0)
	OB GET ARRAY:C1229($promozioni{1};"ricompense";$ricompense)
	ARRAY OBJECT:C1221($articoli;0)
	OB GET ARRAY:C1229($promozioni{1};"articoli";$articoli)
	
	$testo:=OB Get:C1224($promozioni{1};"testo";Is text:K8:3)
	ARRAY TEXT:C222($righeTesto;0)
	utlExplode (Replace string:C233($testo;Char:C90(Line feed:K15:40);"");->$righeTesto)
	$ultimaRigaVuota:=True:C214
	For ($i;Size of array:C274($righeTesto);1;-1)
		$righeTesto{$i}:=trim_right ($righeTesto{$i})
		If ($righeTesto{$i}#"")
			$ultimaRigaVuota:=False:C215
		End if 
		If ($ultimaRigaVuota)
			DELETE FROM ARRAY:C228($righeTesto;$i)
		End if 
	End for 
	
	If ($tipoPromozione#"REGN") & ($tipoPromozione#"ACPT") & ($tipoPromozione#"EMBU") & ($tipoPromozione#"REBU") & ($tipoPromozione#"COUP")
		  //record 00D (Cancellazione)
		Case of 
			: ($tipoPromozione="0061")
				$numeroPromozione:=String:C10(OB Get:C1224($promozioni{1};"codice";Is longint:K8:6);"000000000")
			: ($tipoPromozione="0481")
				$numeroPromozione:=String:C10(OB Get:C1224($promozioni{1};"codice";Is longint:K8:6);"000000000")  //"00898"
			: ($tipoPromozione="0492")
				$numeroPromozione:=String:C10(OB Get:C1224($promozioni{1};"codice";Is longint:K8:6);"000000000")
			: ($tipoPromozione="0501")
				$numeroPromozione:=String:C10(OB Get:C1224($promozioni{1};"codice";Is longint:K8:6);"000000000")
			: ($tipoPromozione="0503")
				$numeroPromozione:=String:C10(OB Get:C1224($promozioni{1};"codice";Is longint:K8:6);"000000000")  //"00898"
		End case 
		
		$text:="00D"+$numeroPromozione
		$text:=$text+fill_right ($tipoPromozione;4)
		$text:=$text+fill_right (OB Get:C1224($promozioni{1};"descrizione";Is text:K8:3);40)
		$text:=$text+String:C10(OB Get:C1224($promozioni{1};"limite";Is longint:K8:6);"000")
		$text:=$text+fill_right ("";27)
		$text:=$text+Replace string:C233(Substring:C12(String:C10(OB Get:C1224($promozioni{1};"dataInizio";Is date:K8:7);ISO date:K1:8);1;10);"-";"")
		$text:=$text+Replace string:C233(Substring:C12(String:C10(OB Get:C1224($promozioni{1};"dataFine";Is date:K8:7);ISO date:K1:8);1;10);"-";"")
		$text:=$text+Replace string:C233(OB Get:C1224($promozioni{1};"oraInizio";Is text:K8:3);":";"")
		$text:=$text+Replace string:C233(OB Get:C1224($promozioni{1};"oraFine";Is text:K8:3);":";"")
		$text:=$text+fill_left (OB Get:C1224($promozioni{1};"calendarioSettimanale";Is text:K8:3);7)
		$text:=$text+String:C10(OB Get:C1224($promozioni{1};"tipoCliente";Is longint:K8:6);"0")
		$text:=$text+String:C10(OB Get:C1224($promozioni{1};"categoria";Is longint:K8:6);"00000")
		$text:=$text+String:C10(Size of array:C274($righeTesto);"00")  //miscellaneo
		$text:=$text+String:C10(Size of array:C274($ricompense);"00")
		$text:=$text+String:C10(Size of array:C274($articoli);"0000")
		$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		
		If (Not:C34($soloCancellazione))
			  //record 00I (Invio)
			$text:=$text+"00I"+$numeroPromozione
			$text:=$text+fill_right (OB Get:C1224($promozioni{1};"tipo";Is text:K8:3);4)
			$text:=$text+fill_right (OB Get:C1224($promozioni{1};"descrizione";Is text:K8:3);40)
			$text:=$text+String:C10(OB Get:C1224($promozioni{1};"limite";Is longint:K8:6);"000")
			$text:=$text+fill_right ("";27)
			$text:=$text+Replace string:C233(Substring:C12(String:C10(OB Get:C1224($promozioni{1};"dataInizio";Is date:K8:7);ISO date:K1:8);1;10);"-";"")
			$text:=$text+Replace string:C233(Substring:C12(String:C10(OB Get:C1224($promozioni{1};"dataFine";Is date:K8:7);ISO date:K1:8);1;10);"-";"")
			$text:=$text+Replace string:C233(OB Get:C1224($promozioni{1};"oraInizio";Is text:K8:3);":";"")
			$text:=$text+Replace string:C233(OB Get:C1224($promozioni{1};"oraFine";Is text:K8:3);":";"")
			$text:=$text+fill_left (OB Get:C1224($promozioni{1};"calendarioSettimanale";Is text:K8:3);7)
			$text:=$text+String:C10(OB Get:C1224($promozioni{1};"tipoCliente";Is longint:K8:6);"0")
			$text:=$text+String:C10(OB Get:C1224($promozioni{1};"categoria";Is longint:K8:6);"00000")
			$text:=$text+String:C10(Size of array:C274($righeTesto);"00")  //miscellaneo
			$text:=$text+String:C10(Size of array:C274($ricompense);"00")
			$text:=$text+String:C10(Size of array:C274($articoli);"0000")
			$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
			
			  //records 01 (ricompense)
			Case of 
				: ($tipoPromozione="0061")
					For ($i;1;Size of array:C274($ricompense))
						$text:=$text+"01"+$numeroPromozione
						$text:=$text+String:C10($i;"00")  //sequenziale
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"soglia";Is real:K8:4);0);"00000000")  //soglia
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"ammontare";Is real:K8:4);0);"00000000")  //ammontare (non usato in questa promo)
						$text:=$text+"0000"  //reparto contabile
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"limiteSconto";Is real:K8:4)*100;0);"00000000")
						$text:=$text+String:C10(OB Get:C1224($ricompense{$i};"ripetibilita";Is longint:K8:6);"0")  //ripetibilita
						$text:=$text+fill_right (OB Get:C1224($ricompense{$i};"descrizione";Is text:K8:3);40)  //descrizione
						$text:=$text+fill_right (OB Get:C1224($ricompense{$i};"recordM";Is text:K8:3);15)  //record m
						$text:=$text+fill_right ("";38;"0")
						$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					End for 
				: ($tipoPromozione="0481")
					For ($i;1;Size of array:C274($ricompense))
						$text:=$text+"01"+$numeroPromozione
						$text:=$text+String:C10($i;"00")  //sequenziale
						$text:=$text+fill_right ("";8;"0")  //soglia/taglio
						$text:=$text+"00000000"  //ammontare (non usato in questa promo)
						$text:=$text+"0000"  //reparto contabile
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"limiteSconto";Is real:K8:4)*100;0);"00000000")
						$text:=$text+String:C10(OB Get:C1224($ricompense{$i};"ripetibilita";Is longint:K8:6);"0")  //ripetibilita
						$text:=$text+fill_right ("BUONO SCONTO";40)  //descrizione
						$text:=$text+fill_right (OB Get:C1224($ricompense{$i};"recordM";Is text:K8:3);15)  //record m
						$codice:=String:C10(OB Get:C1224($promozioni{1};"codice";Is longint:K8:6))
						$codice:=Substring:C12($codice;Length:C16($codice)-3)
						$text:=$text+fill_right ("0111"+$codice;38;"0")
						$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					End for 
				: ($tipoPromozione="0492")
					For ($i;1;Size of array:C274($ricompense))
						$text:=$text+"01"+$numeroPromozione
						$text:=$text+String:C10($i;"00")  //sequenziale
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"soglia";Is real:K8:4);0);"00000000")  //soglia/taglio
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"ammontare";Is real:K8:4);0);"00000000")  //ammontare (%)
						$text:=$text+"0000"  //reparto contabile
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"limiteSconto";Is real:K8:4)*100;0);"00000000")
						$text:=$text+String:C10(OB Get:C1224($ricompense{$i};"ripetibilita";Is longint:K8:6);"0")  //ripetibilita
						$text:=$text+fill_right (OB Get:C1224($ricompense{$i};"descrizione";Is text:K8:3);40)  //descrizione
						$text:=$text+fill_right (OB Get:C1224($ricompense{$i};"recordM";Is text:K8:3);15)  //record m
						$text:=$text+fill_right ("";16)  //filler
						$text:=$text+fill_right ("";22;"0")  //filler
						$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					End for 
				: ($tipoPromozione="0501")
					For ($i;1;Size of array:C274($ricompense))
						$text:=$text+"01"+$numeroPromozione
						$text:=$text+String:C10($i;"00")  //sequenziale
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"sogliaTaglio";Is real:K8:4)*100;0);"00000000")  //soglia/taglio
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"ammontare";Is real:K8:4)*100;0);"00000000")  //soglia/taglio
						$text:=$text+"0000"  //reparto contabile
						$text:=$text+fill_right ("";8;"0")  //filler
						$text:=$text+String:C10(OB Get:C1224($ricompense{$i};"ripetibilita";Is longint:K8:6);"0")  //ripetibilita
						$text:=$text+fill_right ("";40)  //descrizione
						$text:=$text+fill_right ("";15)  //record m
						$text:=$text+fill_left (OB Get:C1224($ricompense{$i};"promovar";Is text:K8:3);8;"0")  //promovar
						$text:=$text+fill_right ("";8;"0")  //taglio
						$text:=$text+fill_right ("";22)  //filler
						$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					End for 
				: ($tipoPromozione="0503")
					For ($i;1;Size of array:C274($ricompense))
						$text:=$text+"01"+$numeroPromozione
						$text:=$text+String:C10($i;"00")  //sequenziale
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"sogliaTaglio";Is real:K8:4)*100;0);"00000000")  //soglia/taglio
						$text:=$text+"00000000"  //ammontare (non usato in questa promo)
						$text:=$text+"0000"  //reparto contabile
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"limiteSconto";Is real:K8:4)*100;0);"00000000")
						$text:=$text+"1"  //ripetibilita (1 fisso sempre attiva)
						$text:=$text+fill_right ("BUONO SCONTO";40)  //descrizione (fisso BUONO SCONTO)
						$text:=$text+fill_right (OB Get:C1224($ricompense{$i};"recordM";Is text:K8:3);15)  //record m
						$codice:=String:C10(OB Get:C1224($promozioni{1};"codice";Is longint:K8:6))
						$codice:=Substring:C12($codice;Length:C16($codice)-3)
						$text:=$text+"0111"+$codice  //promovar fittizia
						$text:=$text+String:C10(Round:C94(OB Get:C1224($ricompense{$i};"sogliaTaglio";Is real:K8:4)*100;0);"00000000")  //taglio uguale a soglia se ripetibilita 1
						$text:=$text+fill_right ("";22;"0")  //filler
						$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					End for 
			End case 
			
			  //records 02 (articoli)
			Case of 
				: ($tipoPromozione="0481")
					For ($i;1;Size of array:C274($articoli))
						$text:=$text+"02"+$numeroPromozione
						$text:=$text+String:C10($i;"0000")  //sequenziale
						$text:=$text+fill_left (fill_left (OB Get:C1224($articoli{$i};"codiceReparto";Is text:K8:3);4;"0");13)  //reparto
						$text:=$text+String:C10(OB Get:C1224($articoli{$i};"molteplicita";Is longint:K8:6);"00000000")  //molteplicita
						$text:=$text+"000"  //codice gruppo
						$text:=$text+fill_right ("";96;"0")
						$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					End for 
				: ($tipoPromozione="0492")
					For ($i;1;Size of array:C274($articoli))
						$text:=$text+"02"+$numeroPromozione
						$text:=$text+String:C10($i;"0000")  //sequenziale
						$text:=$text+fill_left (OB Get:C1224($articoli{$i};"barcode";Is text:K8:3);13;"0")  //reparto
						$text:=$text+"00000000"  //molteplicita
						$text:=$text+"000"  //codice gruppo
						$text:=$text+fill_right ("";96;"0")
						$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
					End for 
				: ($tipoPromozione="0503")
					  //non ha record di tipo 02
			End case 
		End if 
		
		
		  //records 03 (miscellaneo)
		Case of 
			: ($tipoPromozione="0492")
				For ($i;1;Size of array:C274($righeTesto))
					$text:=$text+"03"+$numeroPromozione
					$text:=$text+String:C10($i;"00")  //sequenziale
					$text:=$text+fill_right ($righeTesto{$i};122)
					$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				End for 
			: ($tipoPromozione="0501")
				For ($i;1;Size of array:C274($righeTesto))
					$text:=$text+"03"+$numeroPromozione
					$text:=$text+String:C10($i;"00")  //sequenziale
					$text:=$text+fill_right ($righeTesto{$i};122)
					$text:=$text+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
				End for 
		End case 
		
	Else 
		$text:=$testo
	End if 
	
	If (Count parameters:C259=3)
		$2->:=$2->+$text
	Else 
		  //SET TEXT TO PASTEBOARD($text)
	End if 
	
End if 


