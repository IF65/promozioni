ARRAY LONGINT:C221($selezione;0)
$err:=AL_GetObjects (alpPromozioni;ALP_Object_Selection;$selezione)
If (Size of array:C274($selezione)>0)
	  //$mainFolder:=Convert path system to POSIX(System folder(Desktop)+"promozioni_invio/")
	$mainFolder:=Convert path system to POSIX:C1106(System folder:C487(Desktop:K41:16))+"/promozioni_invio/"
	If (Test path name:C476(Convert path POSIX to system:C1107($mainFolder))#Is a folder:K24:2)
		CREATE FOLDER:C475(Convert path POSIX to system:C1107($mainFolder))
	End if 
	
	ARRAY TEXT:C222($id;0)
	ARRAY LONGINT:C221($codice;0)
	ARRAY TEXT:C222($tipo;0)
	ARRAY BOOLEAN:C223($pmt;0)
	For ($i;1;Size of array:C274($selezione))
		APPEND TO ARRAY:C911($codice;arPR_codice{$selezione{$i}})
		APPEND TO ARRAY:C911($id;arPR_id{$selezione{$i}})
		APPEND TO ARRAY:C911($tipo;arPR_tipo{$selezione{$i}})
		APPEND TO ARRAY:C911($pmt;arPR_pmt{$selezione{$i}})
	End for 
	SORT ARRAY:C229($codice;$id;$tipo;>)
	
	For ($i;1;Size of array:C274($id))
		
		$text:=""
		ARRAY OBJECT:C1221($sedi;0)
		pfCreazioneFile ($id{$i};->$text;->$sedi)
		  //pfCreazioneFileLocal($id{$i};->$text;->$sedi)
		
		$nomeFile:="TIPO_0000_"
		Case of 
			: ($tipo{$i}="0034")
				$nomeFile:="PROMO_0034_"
			: ($tipo{$i}="0054")
				$nomeFile:="PROMO_0054_"
			: ($tipo{$i}="0055")
				$nomeFile:="PROMO_0055_"
			: ($tipo{$i}="0061")
				$nomeFile:="PROMO_0061_"
			: ($tipo{$i}="0070")
				$nomeFile:="PROMO_0070_"
			: ($tipo{$i}="0481")
				$nomeFile:="PROMO_0481_"
			: ($tipo{$i}="0482")
				$nomeFile:="PROMO_0482_"
			: ($tipo{$i}="0492")
				$nomeFile:="PROMO_0492_"
			: ($tipo{$i}="0493")
				$nomeFile:="PROMO_0493_"
			: ($tipo{$i}="0501")
				$nomeFile:="PROMO_0501_"
			: ($tipo{$i}="0503")
				$nomeFile:="PROMO_0503_"
			: ($tipo{$i}="ACPT")
				$nomeFile:="PROMO_ACPT_"
			: ($tipo{$i}="EMBU")
				$nomeFile:="PROMO_EMBU_"
			: ($tipo{$i}="REBU")
				$nomeFile:="PROMO_REBU_"
			: ($tipo{$i}="REGN")
				$nomeFile:="PROMO_REGN_"
			: ($tipo{$i}="COUP")
				$nomeFile:="COUPON_"
		End case 
		$nomeFile:=$nomeFile+String:C10($codice{$i})
		
		For ($j;1;Size of array:C274($sedi))
			
			$currentFolder:=$mainFolder+$sedi{$j}.codiceSede+"/"
			If (Test path name:C476(Convert path POSIX to system:C1107($currentFolder))#Is a folder:K24:2)
				CREATE FOLDER:C475(Convert path POSIX to system:C1107($currentFolder))
			End if 
			$gmrecFolder:=$currentFolder+"gmrec/"
			If (Test path name:C476(Convert path POSIX to system:C1107($gmrecFolder))#Is a folder:K24:2)
				CREATE FOLDER:C475(Convert path POSIX to system:C1107($gmrecFolder))
			End if 
			
			  //invio file nella cartella di smistamento
			If (True:C214)
				<>error:=0
				ON ERR CALL:C155("utlOnErrCall")
				
				  //creazione file promo
				$usedFolder:=$currentFolder
				$usedExtension:=".DAT"
				If ($tipo{$i}="REGN") | ($tipo{$i}="ACPT") | ($tipo{$i}="EMBU") | ($tipo{$i}="REBU") | ($tipo{$i}="COUP") | ($pmt{$i})
					$usedFolder:=$gmrecFolder
					$usedExtension:=".PMT"
				End if 
				TEXT TO DOCUMENT:C1237(Convert path POSIX to system:C1107($usedFolder+$nomeFile+$usedExtension);$text;"ISO-8859-1";Document with CRLF:K24:20)
				If (<>error=0)
					$fRef:=Create document:C266(Convert path POSIX to system:C1107($usedFolder+$nomeFile+".CTL"))
					CLOSE DOCUMENT:C267($fRef)
				End if 
				
				  //creazione gmrecmnt
				$textGmRec:=""
				DOCUMENT LIST:C474(Convert path POSIX to system:C1107($gmrecFolder);$documents;Posix path:K24:15+Ignore invisible:K24:16)
				For ($k;1;Size of array:C274($documents))
					ARRAY TEXT:C222($g;0)
					If (utlMatchRegex ("^((?:PROMO|COUPON).*)\\.CTL$";$documents{$k};->$g))
						$textGmRec:=$textGmRec+fill_right ("p "+$g{1}+".PMT";78)+Char:C90(Carriage return:K15:38)
					End if 
				End for 
				If ($textGmRec#"")
					<>error:=0
					ON ERR CALL:C155("utlOnErrCall")
					TEXT TO DOCUMENT:C1237(Convert path POSIX to system:C1107($gmrecFolder+"GMRECMNT.DAT");$textGmRec;"ISO-8859-1";Document with CRLF:K24:20)
					If (<>error=0)
						$fRef:=Create document:C266(Convert path POSIX to system:C1107($gmrecFolder+"GMRECMNT.CTL"))
						CLOSE DOCUMENT:C267($fRef)
					End if 
				End if 
				
				ON ERR CALL:C155("")
			End if 
			
		End for 
	End for 
	  //SET TEXT TO PASTEBOARD($text)
End if 

ALERT:C41("Dati creati!";"Continua")
