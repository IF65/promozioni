Class constructor()
	var id : Text
	var codice : Text
	var codiceCatalina : Text
	var tipo : Text
	var tipoDescrizione : Text
	var descrizione : Text
	var ripetibilita : Integer
	var dataInizio : Date
	var dataFine : Date
	var oraInizio : Text  // hh:min
	var oraFine : Text  // hh:min
	var tipoCliente : Integer
	var categoria : Integer
	var calendarioSettimanale : Text
	var do : Boolean
	var lu : Boolean
	var ma : Boolean
	var me : Boolean
	var gi : Boolean
	var ve : Boolean
	var sa : Boolean
	var sottoreparti : Integer
	var bozza : Boolean
	var stampato : Boolean
	var pmt : Boolean
	var barcode : Text
	var testo : Text
	var soglia : Real
	var importo : Real
	var numeroSedi : Integer
	var immagineBarcode : Text
	
	var ricompense : Collection
	var sedi : Collection
	var articoli : Collection
	
	This:C1470.init()
	
Function init()
	This:C1470.id:=Generate UUID:C1066
	This:C1470.codice:=0
	This:C1470.codiceCatalina:=0
	This:C1470.tipo:=""
	This:C1470.tipoDescrizione:=""
	This:C1470.descrizione:=""
	This:C1470.ripetibilita:=0
	This:C1470.dataInizio:=!00-00-00!
	This:C1470.dataFine:=!00-00-00!
	This:C1470.oraInizio:="00:00"
	This:C1470.oraFine:="00:00"
	This:C1470.tipoCliente:=0
	This:C1470.categoria:=0
	This:C1470.calendarioSettimanale:=""
	This:C1470.do:=True:C214
	This:C1470.lu:=True:C214
	This:C1470.ma:=True:C214
	This:C1470.me:=True:C214
	This:C1470.gi:=True:C214
	This:C1470.ve:=True:C214
	This:C1470.sa:=True:C214
	This:C1470.sottoreparti:=0
	This:C1470.bozza:=True:C214
	This:C1470.stampato:=False:C215
	This:C1470.pmt:=False:C215
	This:C1470.barcode:=""
	This:C1470.testo:=""
	This:C1470.soglia:=0
	This:C1470.importo:=0
	This:C1470.numeroSedi:=0
	This:C1470.immagineBarcode:=""
	
	This:C1470.ricompense:=New collection:C1472()
	This:C1470.sedi:=New collection:C1472()
	This:C1470.articoli:=New collection:C1472()
	
Function isValid() : Boolean
	$0:=False:C215
	If (This:C1470.id#"") & (This:C1470.codice#0) & (This:C1470.tipo#"")
		$0:=True:C214
	End if 
	
Function promozione2Object($promozione : Pointer) : Boolean
	
	$0:=False:C215
	If (This:C1470.isValid())
		This:C1470.soglia:=This:C1470.ricompense.max("soglia")
		This:C1470.importo:=This:C1470.ricompense.max("ammontare")
		This:C1470.numeroSedi:=This:C1470.sedi.count()
		
		OB SET:C1220($promozione->; "id"; This:C1470.id)
		OB SET:C1220($promozione->; "codice"; This:C1470.codice)
		OB SET:C1220($promozione->; "codiceCatalina"; This:C1470.codiceCatalina)
		OB SET:C1220($promozione->; "tipo"; This:C1470.tipo)
		OB SET:C1220($promozione->; "descrizione"; This:C1470.descrizione)
		OB SET:C1220($promozione->; "ripetibilita"; This:C1470.ripetibilita)
		OB SET:C1220($promozione->; "dataInizio"; This:C1470.dataInizio)
		OB SET:C1220($promozione->; "dataFine"; This:C1470.dataFine)
		OB SET:C1220($promozione->; "oraInizio"; This:C1470.oraInizio)
		OB SET:C1220($promozione->; "oraFine"; This:C1470.oraFine)
		OB SET:C1220($promozione->; "calendarioSettimanale"; This:C1470.calendarioSettimanale)
		OB SET:C1220($promozione->; "tipoCliente"; This:C1470.tipoCliente)
		OB SET:C1220($promozione->; "categoria"; This:C1470.categoria)
		OB SET:C1220($promozione->; "sottoreparti"; This:C1470.sottoreparti)
		OB SET:C1220($promozione->; "bozza"; Choose:C955(This:C1470.bozza; 1; 0))
		OB SET:C1220($promozione->; "stampato"; Choose:C955(This:C1470.stampato; 1; 0))
		OB SET:C1220($promozione->; "pmt"; Choose:C955(This:C1470.pmt; 1; 0))
		OB SET:C1220($promozione->; "barcode"; This:C1470.barcode)
		OB SET:C1220($promozione->; "testo"; This:C1470.testo)
		
		C_OBJECT:C1216($ricompensa)
		ARRAY OBJECT:C1221($ricompense; 0)
		For each ($item; This:C1470.ricompense)
			If (This:C1470.codice#0) & (Not:C34(This:C1470.bozza)) & ($item.recordM="")
				$item.recordM:=This:C1470.tipo+"-"+String:C10(This:C1470.codice)
			End if 
			
			CLEAR VARIABLE:C89($ricompensa)
			OB SET:C1220($ricompensa; "id"; $item.id)
			OB SET:C1220($ricompensa; "idPromozioni"; $item.idPromozioni)
			OB SET:C1220($ricompensa; "soglia"; $item.soglia)
			OB SET:C1220($ricompensa; "ammontare"; $item.ammontare)
			OB SET:C1220($ricompensa; "limiteSconto"; $item.limiteSconto)
			OB SET:C1220($ricompensa; "taglio"; $item.taglio)
			OB SET:C1220($ricompensa; "descrizione"; $item.descrizione)
			OB SET:C1220($ricompensa; "recordM"; $item.recordM)
			OB SET:C1220($ricompensa; "accumulatore"; $item.accumulatore)
			OB SET:C1220($ricompensa; "promovar"; $item.promovar)
			OB SET:C1220($ricompensa; "tipoArea"; $item.tipoArea)
			OB SET:C1220($ricompensa; "ordinamentoInArea"; $item.ordinamentoInArea)
			OB SET:C1220($ricompensa; "progressivo"; $item.progressivo)
			
			APPEND TO ARRAY:C911($ricompense; $ricompensa)
		End for each 
		OB SET ARRAY:C1227($promozione->; "ricompense"; $ricompense)
		
		C_OBJECT:C1216($articolo)
		ARRAY OBJECT:C1221($articoli; 0)
		For each ($item; This:C1470.articoli)
			CLEAR VARIABLE:C89($articolo)
			OB SET:C1220($articolo; "id"; $item.id)
			OB SET:C1220($articolo; "idPromozioni"; $item.idPromozioni)
			OB SET:C1220($articolo; "codiceArticolo"; $item.codiceArticolo)
			OB SET:C1220($articolo; "codiceReparto"; $item.codiceReparto)
			OB SET:C1220($articolo; "barcode"; $item.barcode)
			OB SET:C1220($articolo; "descrizione"; $item.descrizione)
			OB SET:C1220($articolo; "molteplicita"; $item.molteplicita)
			OB SET:C1220($articolo; "gruppo"; $item.gruppo)
			APPEND TO ARRAY:C911($articoli; $articolo)
		End for each 
		OB SET ARRAY:C1227($promozione->; "articoli"; $articoli)
		
		C_OBJECT:C1216($sede)
		ARRAY OBJECT:C1221($sedi; 0)
		For each ($item; This:C1470.sedi)
			CLEAR VARIABLE:C89($sede)
			OB SET:C1220($sede; "id"; $item.id)
			OB SET:C1220($sede; "idPromozioni"; $item.idPromozioni)
			OB SET:C1220($sede; "codiceSede"; $item.codiceSede)
			APPEND TO ARRAY:C911($sedi; $sede)
		End for each 
		OB SET ARRAY:C1227($promozione->; "sedi"; $sedi)
		
		$0:=True:C214
	End if 
	
Function object2Promozione($object : Pointer) : Boolean
	
	This:C1470.init()
	
	//C_BLOB($immagine)
	//$text:=OB Get($object; "immagineBarcode"; Is text)
	//BASE64 DECODE($text; $immagine)
	
	$calendario:=OB Get:C1224($object->; "calendarioSettimanale"; Is text:K8:3)
	
	This:C1470.id:=OB Get:C1224($object->; "id"; Is text:K8:3)
	This:C1470.codice:=OB Get:C1224($object->; "codice"; Is longint:K8:6)
	This:C1470.codiceCatalina:=OB Get:C1224($object->; "codiceCatalina"; Is longint:K8:6)
	This:C1470.tipo:=OB Get:C1224($object->; "tipo"; Is text:K8:3)
	This:C1470.tipoDescrizione:=OB Get:C1224(<>promoDescrizione; This:C1470.tipo; Is text:K8:3)
	This:C1470.descrizione:=OB Get:C1224($object->; "descrizione"; Is text:K8:3)
	This:C1470.ripetibilita:=OB Get:C1224($object->; "ripetibilita"; Is longint:K8:6)
	This:C1470.dataInizio:=OB Get:C1224($object->; "dataInizio"; Is date:K8:7)
	This:C1470.dataFine:=OB Get:C1224($object->; "dataFine"; Is date:K8:7)
	This:C1470.oraInizio:=Substring:C12(OB Get:C1224($object->; "oraInizio"; Is text:K8:3); 1; 5)
	This:C1470.oraFine:=Substring:C12(OB Get:C1224($object->; "oraFine"; Is text:K8:3); 1; 5)
	This:C1470.tipoCliente:=OB Get:C1224($object->; "tipoCliente"; Is longint:K8:6)
	This:C1470.categoria:=OB Get:C1224($object->; "categoria"; Is longint:K8:6)
	This:C1470.calendarioSettimanale:=$calendario
	This:C1470.do:=Substring:C12($calendario; 1; 1)="1"
	This:C1470.lu:=Substring:C12($calendario; 2; 1)="1"
	This:C1470.ma:=Substring:C12($calendario; 3; 1)="1"
	This:C1470.me:=Substring:C12($calendario; 4; 1)="1"
	This:C1470.gi:=Substring:C12($calendario; 5; 1)="1"
	This:C1470.ve:=Substring:C12($calendario; 6; 1)="1"
	This:C1470.sa:=Substring:C12($calendario; 7; 1)="1"
	This:C1470.sottoreparti:=OB Get:C1224($object->; "sottoreparti"; Is longint:K8:6)
	This:C1470.bozza:=OB Get:C1224($object->; "bozza"; Is longint:K8:6)=1
	This:C1470.stampato:=OB Get:C1224($object->; "stampato"; Is longint:K8:6)=1
	This:C1470.pmt:=OB Get:C1224($object->; "pmt"; Is longint:K8:6)=1
	This:C1470.barcode:=OB Get:C1224($object->; "barcode"; Is text:K8:3)
	This:C1470.testo:=OB Get:C1224($object->; "testo"; Is text:K8:3)
	This:C1470.immagineBarcode:=OB Get:C1224($object->; "immagineBarcode"; Is text:K8:3)
	
	ARRAY OBJECT:C1221($elencoRicompense; 0)
	OB GET ARRAY:C1229($object->; "ricompense"; $elencoRicompense)
	For ($j; 1; Size of array:C274($elencoRicompense))
		$ricompensa:=cs:C1710.Ricompensa.new()
		
		$ricompensa.id:=OB Get:C1224($elencoRicompense{$j}; "id"; Is text:K8:3)
		$ricompensa.idPromozioni:=OB Get:C1224($elencoRicompense{$j}; "idPromozioni"; Is text:K8:3)
		$ricompensa.soglia:=OB Get:C1224($elencoRicompense{$j}; "soglia"; Is real:K8:4)
		$ricompensa.ammontare:=OB Get:C1224($elencoRicompense{$j}; "ammontare"; Is real:K8:4)
		$ricompensa.limiteSconto:=OB Get:C1224($elencoRicompense{$j}; "limiteSconto"; Is real:K8:4)
		$ricompensa.taglio:=OB Get:C1224($elencoRicompense{$j}; "taglio"; Is real:K8:4)
		$ricompensa.descrizione:=OB Get:C1224($elencoRicompense{$j}; "descrizione"; Is text:K8:3)
		$ricompensa.recordM:=OB Get:C1224($elencoRicompense{$j}; "recordM"; Is text:K8:3)
		$ricompensa.accumulatore:=OB Get:C1224($elencoRicompense{$j}; "accumulatore"; Is text:K8:3)
		$ricompensa.promovar:=OB Get:C1224($elencoRicompense{$j}; "promovar"; Is text:K8:3)
		$ricompensa.tipoArea:=OB Get:C1224($elencoRicompense{$j}; "tipoArea"; Is longint:K8:6)
		$ricompensa.ordinamentoInArea:=; OB Get:C1224($elencoRicompense{$j}; "ordinamentoInArea"; Is longint:K8:6)
		$ricompensa.progressivo:=OB Get:C1224($elencoRicompense{$j}; "progressivo"; Is longint:K8:6)
		
		This:C1470.ricompense.push($ricompensa)
	End for 
	
	ARRAY OBJECT:C1221($elencoSedi; 0)
	OB GET ARRAY:C1229($object->; "sedi"; $elencoSedi)
	For ($j; 1; Size of array:C274($elencoSedi))
		$sede:=cs:C1710.PromozioneSede.new()
		
		$sede.id:=OB Get:C1224($elencoSedi{$j}; "id"; Is text:K8:3)
		$sede.idPromozioni:=OB Get:C1224($elencoSedi{$j}; "idPromozioni"; Is text:K8:3)
		$sede.codiceSede:=OB Get:C1224($elencoSedi{$j}; "codiceSede"; Is text:K8:3)
		$sede.descrizione:=$sede.codiceSede+" - "+OB Get:C1224(<>sediDescrizione; $sede.codiceSede; Is text:K8:3)
		
		This:C1470.sedi.push($sede)
	End for 
	This:C1470.sedi:=This:C1470.sedi.orderBy("descrizione asc")
	
	ARRAY OBJECT:C1221($elencoArticoli; 0)
	OB GET ARRAY:C1229($object->; "articoli"; $elencoArticoli)
	For ($j; 1; Size of array:C274($elencoArticoli))
		$articolo:=cs:C1710.Articolo.new()
		
		$articolo.id:=OB Get:C1224($elencoArticoli{$j}; "id"; Is text:K8:3)
		$articolo.idPromozioni:=OB Get:C1224($elencoArticoli{$j}; "idPromozioni"; Is text:K8:3)
		$articolo.codiceArticolo:=OB Get:C1224($elencoArticoli{$j}; "codiceArticolo"; Is text:K8:3)
		$articolo.codiceReparto:=OB Get:C1224($elencoArticoli{$j}; "codiceReparto"; Is text:K8:3)
		$articolo.barcode:=OB Get:C1224($elencoArticoli{$j}; "barcode"; Is text:K8:3)
		$articolo.descrizione:=OB Get:C1224($elencoArticoli{$j}; "descrizione"; Is text:K8:3)
		$articolo.molteplicita:=OB Get:C1224($elencoArticoli{$j}; "molteplicita"; Is longint:K8:6)
		$articolo.gruppo:=OB Get:C1224($elencoArticoli{$j}; "gruppo"; Is longint:K8:6)
		
		This:C1470.articoli.push($articolo)
	End for 
	
	This:C1470.soglia:=This:C1470.ricompense.max("soglia")
	This:C1470.importo:=This:C1470.ricompense.max("ammontare")
	This:C1470.numeroSedi:=This:C1470.sedi.count()
	
	$0:=True:C214
	