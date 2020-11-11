//%attributes = {}
$id:="8261"
$dataInizio:=!2020-10-19!
$dataFine:=!2020-11-01!
$soglia:=10
$punti:=250
$barcode:="29909216"

ARRAY TEXT:C222($reparti;0)
APPEND TO ARRAY:C911($reparti;"2")
APPEND TO ARRAY:C911($reparti;"200")
APPEND TO ARRAY:C911($reparti;"210")
APPEND TO ARRAY:C911($reparti;"250")

$text:=utlCreaPmtDaTemplate ($id;$dataInizio;$dataFine;$soglia;$punti;$barcode;->$reparti)

SET TEXT TO PASTEBOARD:C523($text)
TRACE:C157
