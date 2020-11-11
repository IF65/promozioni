//%attributes = {"invisible":true}
ARRAY TEXT:C222($arTipo;0)
ARRAY LONGINT:C221($arProgressivo;0)
ARRAY REAL:C219($arImporto;0)
ARRAY TEXT:C222($arBarcode;0)
ARRAY TEXT:C222($arNewBarcode;0)

  //APPEND TO ARRAY($arTipo;"0481")
  //APPEND TO ARRAY($arProgressivo;1108)
  //APPEND TO ARRAY($arImporto;2)
  //APPEND TO ARRAY($arBarcode;"9872703300203")

  //APPEND TO ARRAY($arTipo;"0481")
  //APPEND TO ARRAY($arProgressivo;1111)
  //APPEND TO ARRAY($arImporto;1.5)
  //APPEND TO ARRAY($arBarcode;"9872705300256")


APPEND TO ARRAY:C911($arTipo;"0503")
APPEND TO ARRAY:C911($arProgressivo;1144)
APPEND TO ARRAY:C911($arImporto;3)
APPEND TO ARRAY:C911($arBarcode;"9872705900258")

For ($i;1;Size of array:C274($arBarcode))
	APPEND TO ARRAY:C911($arNewBarcode;utlCreaBarcodeCatalina ($arTipo{$i};$arProgressivo{$i};$arImporto{$i}))
End for 

$text:=""
For ($i;1;Size of array:C274($arBarcode))
	$text:=$text+$arTipo{$i}+"\t"
	$text:=$text+String:C10($arImporto{$i};"##0.00")+"\t"
	$text:=$text+$arBarcode{$i}+"\t"
	$text:=$text+$arNewBarcode{$i}+"\n"
End for 
SET TEXT TO PASTEBOARD:C523($text)
TRACE:C157


