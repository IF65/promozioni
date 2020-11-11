//%attributes = {}
$promoVar:=utlProgressivoCrea (<>progPromovarPI)
$importo:=1.2
$barcode:=utlCreaBarcodeCatalina ("0503";$promoVar;$importo)
SET TEXT TO PASTEBOARD:C523($barcode)
TRACE:C157
