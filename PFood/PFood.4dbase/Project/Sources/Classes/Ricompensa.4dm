Class constructor()
	var id : Text
	var idPromozioni : Text
	var soglia : Real
	var ammontare : Real
	var limiteSconto : Real
	var taglio : Real
	var descrizione : Text
	var recordM : Text
	var accumulatore : Text
	var promovar : Text
	var tipoArea : Integer
	var ordinamentoInArea : Integer
	var progressivo : Integer
	This:C1470.init()
	
Function init()
	This:C1470.id:=Generate UUID:C1066
	This:C1470.idPromozioni:=""
	This:C1470.soglia:=0
	This:C1470.ammontare:=0
	This:C1470.limiteSconto:=0
	This:C1470.taglio:=0
	This:C1470.descrizione:=""
	This:C1470.recordM:=""
	This:C1470.accumulatore:=""
	This:C1470.promovar:=""
	This:C1470.tipoArea:=0
	This:C1470.ordinamentoInArea:=0
	This:C1470.progressivo:=0
	
	