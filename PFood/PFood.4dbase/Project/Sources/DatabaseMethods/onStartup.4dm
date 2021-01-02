// Versione
// -------------------------------------------------
<>versioneCodice:=2
<>versioneSottoCodice:=14
<>versioneData:=!2019-05-10!

// impostazione server
// -------------------------------------------------
<>itmServer:="10.11.14.78"

// tipo progressivi
// -------------------------------------------------
<>progPromozione:=0
<>progPromovarPI:=1
<>progPromovarPMT:=2

// reparti
// -------------------------------------------------
<>reparti:=New object:C1471()

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "3")
APPEND TO ARRAY:C911($codiciReparto; "300")
APPEND TO ARRAY:C911($codiciReparto; "310")
APPEND TO ARRAY:C911($codiciReparto; "350")
OB SET ARRAY:C1227(<>reparti; "ORTOFRUTTA"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "1")
APPEND TO ARRAY:C911($codiciReparto; "111")
OB SET ARRAY:C1227(<>reparti; "COLAZIONE"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "1")
APPEND TO ARRAY:C911($codiciReparto; "125")
OB SET ARRAY:C1227(<>reparti; "DETERSIVI"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "4")
APPEND TO ARRAY:C911($codiciReparto; "400")
APPEND TO ARRAY:C911($codiciReparto; "420")
APPEND TO ARRAY:C911($codiciReparto; "450")
OB SET ARRAY:C1227(<>reparti; "LATTICINI"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "2")
APPEND TO ARRAY:C911($codiciReparto; "200")
APPEND TO ARRAY:C911($codiciReparto; "210")
APPEND TO ARRAY:C911($codiciReparto; "250")
OB SET ARRAY:C1227(<>reparti; "MACELLERIA"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "1")
APPEND TO ARRAY:C911($codiciReparto; "114")
OB SET ARRAY:C1227(<>reparti; "PETFOOD"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "4")
APPEND TO ARRAY:C911($codiciReparto; "400")
APPEND TO ARRAY:C911($codiciReparto; "420")
APPEND TO ARRAY:C911($codiciReparto; "450")
OB SET ARRAY:C1227(<>reparti; "SALUMERIA"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "4")
APPEND TO ARRAY:C911($codiciReparto; "400")
APPEND TO ARRAY:C911($codiciReparto; "420")
APPEND TO ARRAY:C911($codiciReparto; "450")
OB SET ARRAY:C1227(<>reparti; "SALUMERIA-BA"; $codiciReparto)

ARRAY TEXT:C222($codiciReparto; 0)
APPEND TO ARRAY:C911($codiciReparto; "1")
APPEND TO ARRAY:C911($codiciReparto; "112")
OB SET ARRAY:C1227(<>reparti; "SURGELATI"; $codiciReparto)

// impostazione colori
// -------------------------------------------------
<>Black:=0
<>Blue:=(0 << 16)+(0 << 8)+(255)
<>White:=(255 << 16)+(255 << 8)+(255)
<>Snow:=(255 << 16)+(250 << 8)+(250)
<>GhostWhite:=(248 << 16)+(248 << 8)+(255)
<>AntiqueWhite:=(250 << 16)+(235 << 8)+(215)
<>HoneyDew:=(240 << 16)+(255 << 8)+(240)
<>LightGrey:=(224 << 16)+(224 << 8)+(224)
<>LemonChiffon:=(255 << 16)+(250 << 8)+(220)
<>AzzurroTenue:=(237 << 16)+(240 << 8)+(251)
<>ForestGreen:=(34 << 16)+(139 << 8)+(34)
<>Red:=(255 << 16)+(0 << 8)+(0)
<>Green:=(0 << 16)+(255 << 8)+(0)
<>test:=(240 << 16)+(240 << 8)+(240)

<>Scenario:=(50 << 16)+(50 << 8)+(210)
<>TableBackground:=<>White
<>AlternateTableBackground:=<>test

<>formatInteger:="<c black>###,###,##0</c>;<c red>-###,###,##0</c>;<c>0</c>"
<>formatCurrency:="<c black>###,###,##0.00</c>;<c red>-###,###,##0.00</c>;<c>0.00</c>"
<>formatCurrency1d:="<c black>###,###,##0.0</c>;<c red>-###,###,##0.0</c>;<c>0.0</c>"

ARRAY TEXT:C222(<>promoTipo; 0)
ARRAY TEXT:C222(<>promoTipoCodice; 0)
APPEND TO ARRAY:C911(<>promoTipo; "TUTTE LE PROMOZIONI")
APPEND TO ARRAY:C911(<>promoTipo; "-")
APPEND TO ARRAY:C911(<>promoTipo; "ACPT - ACCELERATORE PUNTI")
APPEND TO ARRAY:C911(<>promoTipo; "COUP - COUPON CATALINA NIMIS")
APPEND TO ARRAY:C911(<>promoTipo; "EMBU - EMISSIONE BUONI (NON CATALINA)")
APPEND TO ARRAY:C911(<>promoTipo; "REBU - REDENZIONE BUONI (NON CATALINA)")
APPEND TO ARRAY:C911(<>promoTipo; "REGN - REGALO NIMIS")
APPEND TO ARRAY:C911(<>promoTipo; "0024 - CONVERSIONE PUNTI IN SCONTO")
APPEND TO ARRAY:C911(<>promoTipo; "0034 - PROMOZIONE PUNTI SOGLIA")
APPEND TO ARRAY:C911(<>promoTipo; "0054 - SCONTO SET %")
APPEND TO ARRAY:C911(<>promoTipo; "0055 - SCONTO SET VAL.")
APPEND TO ARRAY:C911(<>promoTipo; "0061 - SCONTO TRANS. %")
APPEND TO ARRAY:C911(<>promoTipo; "0070 - MESSAGGI SU SCONTRINO")
APPEND TO ARRAY:C911(<>promoTipo; "0481 - SCONTO VAL. REP.")
APPEND TO ARRAY:C911(<>promoTipo; "0482 - SCONTO VAL./% SULLA TRANSAZIONE")
APPEND TO ARRAY:C911(<>promoTipo; "0492 - BOLLONI IN %")
APPEND TO ARRAY:C911(<>promoTipo; "0493 - SCONTO ARTICOLO IN %")
APPEND TO ARRAY:C911(<>promoTipo; "0501 - BUONO A VAL. TR.")
APPEND TO ARRAY:C911(<>promoTipo; "0503 - SCONTO VAL. TR.")
APPEND TO ARRAY:C911(<>promoTipo; "0504 - SCONTO SET %")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0000")
APPEND TO ARRAY:C911(<>promoTipoCodice; "-")
APPEND TO ARRAY:C911(<>promoTipoCodice; "ACPT")
APPEND TO ARRAY:C911(<>promoTipoCodice; "COUP")
APPEND TO ARRAY:C911(<>promoTipoCodice; "EMBU")
APPEND TO ARRAY:C911(<>promoTipoCodice; "REBU")
APPEND TO ARRAY:C911(<>promoTipoCodice; "REGN")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0024")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0034")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0054")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0055")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0061")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0070")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0481")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0482")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0492")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0493")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0501")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0503")
APPEND TO ARRAY:C911(<>promoTipoCodice; "0504")

C_OBJECT:C1216(<>promoDescrizione)
For ($i; 1; Size of array:C274(<>promoTipoCodice))
	OB SET:C1220(<>promoDescrizione; <>promoTipoCodice{$i}; <>promoTipo{$i})
End for 

WEB SET OPTION:C1210(Web HTTP compression level:K73:11; 9)

// creazione del data file
// -------------------------------------------------
//C_OBJECT($file)
//$file:=New object
//$file:=Path to object(Structure file)

//$dataPath:=$file.name+".4DD"
//If (Test path name($dataPath)#Is a document)
//CREATE DATA FILE($dataPath)
//End if 

//$alp_licences:="001700-509549029-RBURTUBWU4XP4KPXZP-W5WF4241-H7-LSL7-9U-711TUTT4"
//$alp_licences:=$alp_licences+";001701-1879717-QY7U7Q7YQAPAYA-W5WF4241-H7-4TFU-2EEE88-77SVUU73"
//$alp_licences:=$alp_licences+";001896-211297151-WQQWU7QRQZYYZPAY4Y-W5WF4241-H7-4TFU-2EEE88-7XTXUB4B"
//$alp_licences:=$alp_licences+";001897-211297151-N44NVD484HMMH8YM2M-D8DXSJSK-4I-74GW-ODDK55-VP3H9V5S"
//$alp_licences:=$alp_licences+";001898-213706230-WQ97BZW9BZYJAX3ZJX-W5WF4241-H7-LSL7-9U-76YYUY22"
//$alp_licences:=$alp_licences+";001899-213706230-N4HDJUNHJHMFYZGHFZ-D8DXSJSK-4I-WHCV-ZD-VPVU9V9N"
//$alp_licences:=$alp_licences+";002112-509549029-8JV8KVJNV2Z8238ZH8-D8DXSJSK-4I-WHCV-ZD-VSHP9YSV"
//$alp_licences:=$alp_licences+";002113-1879717-4BDVD4DMRY8YMY-D8DXSJSK-4I-74GW-ODDK55-VV7P99HV"
//$alp_licences:=$alp_licences+";002117-473542207-KDH8KNNJD3YF23HHZY-D8DXSJSK-4I-WHCV-ZD-VSI79Y0H"
//$alp_licences:=$alp_licences+";002118-45941677-K8VK4UDD3283MGYY-D8DXSJSK-4I-74GW-ODDK55-VSEE9YCC"
//$alp_licences:=$alp_licences+";002119-475959797-KD8V8VDVD3Y2828Y8Y-D8DXSJSK-4I-WHCV-ZD-VSVS9Y9Y"
//$alp_licences:=$alp_licences+";002120-213559159-N4H88V48VHMF228M28-D8DXSJSK-4I-74GW-ODDK55-VPHV9VS9"
//$alp_licences:=$alp_licences+";002121-473542207-T79RTWWB7KAJ4KZZXA-W5WF4241-H7-LSL7-9U-76Z1UYRT"
//$alp_licences:=$alp_licences+";002122-45941677-TRUTQZ77K4PKY3AA-W5WF4241-H7-4TFU-2EEE88-76YTUY24"
//$alp_licences:=$alp_licences+";002123-475959797-T7RURU7U7KA4P4PAPA-W5WF4241-H7-LSL7-9U-766ZUYYR"
//$alp_licences:=$alp_licences+";002124-213559159-WQ9RRUQRUZYJ44PY4P-W5WF4241-H7-4TFU-2EEE88-7W1SUNT7"
//$alp_licences:=$alp_licences+";003036-45760039-K8DUJJHV32YGZZF8-D8DXSJSK-4I-WHCV-ZD-VV7U99HN"
//$alp_licences:=$alp_licences+";003037-1589530046-48BV8HJJKUM2R82FZZ3G-D8DXSJSK-4I-74GW-ODDK55-V3UH95NS"
//$alp_licences:=$alp_licences+";003038-1444423341-4KKKKNHHK4M3333HFF3M-D8DXSJSK-4I-74GW-ODDK55-V7VU9H9N"
//$alp_licences:=$alp_licences+";003039-3880559-HBBJ88VFRRZ228-D8DXSJSK-4I-WHCV-ZD-VHV79S9H"
//$alp_licences:=$alp_licences+";003036-1151285991-SLvq9bZs68PySsOJDFn77y7+6ncMZ/Rn"
//$alp_licences:=$alp_licences+";003037-1593654781-spQxqt6BAwvXuVROkrUDtHb2a9fq4rZC"
//$alp_licences:=$alp_licences+";004432-1492718767-nqpbUt0ZHjmQqBvAoNIXoJ0d8GrnKu0s"
//$alp_licences:=$alp_licences+";004457-1318805806-/qPPDn6JB9hqTy6ZH4QQ2jQB/aIfwC18"
//$alp_licences:=$alp_licences+";004471-1478082992-3t5plBRPx3liGq0c4KE+KRkyQsBlNzgk"
//$alp_licences:=$alp_licences+";004472-1486471600-1EaaCySBl4SYqzPaSkEylBCnfxD3pvIM"
//$alp_licences:=$alp_licences+";006381-1482306751-zvhlC5LZgP+U2ozQQRAIFiwFG9byLvQC"
//$alp_licences:=$alp_licences+";006380-1213871295-TyOFp9cCMXFm5Xq/JkBZsEBdlLIjg/yT"
//$alp_licences:=$alp_licences+";006396-471698999-NTwpIJMTT9PP88ucyyyhrPDslyr4kq3n"
//$alp_licences:=$alp_licences+";006397-1444610749-37lI5YW4fLgqJNjN/pfo27VAq1GELsMD"
//$alp_licences:=$alp_licences+";007566-419141815-io7qTvP244UL8iZuvgEFT6K5wHFAzohr"
//$alp_licences:=$alp_licences+";007567-1209820534-52eOTzJz6ZhILaJCZwADtsGwmvHXjQVv"
//$alp_licences:=$alp_licences+";007568-381656823-J7/Ck1DSv5vFtXXVqmKNLHozFDZg7D9t"
//$alp_licences:=$alp_licences+";007569-1387961919-R0zcgAy1QjTYmQGqY93QmYxUusXv04tm"
//$alp_licences:=$alp_licences+";008157-1220306230-9a9mN5e2/QPh76EnLLQwTRDhmpWY/uUy"
//$alp_licences:=$alp_licences+";008158-1253658104-7+9cF8mlcHKTsq7xCucnAVFoeuUwfvMp"
//$alp_licences:=$alp_licences+";008159-517716277-qLxkMjdSQgwfpOpG/MqVGFmfzjUu2ifk"
//$alp_licences:=$alp_licences+";008160-112831421-Jh0T3J2yDwoEErGOsOj56hl3YDk788kD"
//$alp_licences:=$alp_licences+";008163-1540632270-VUcXOiJRcAAFgmi5Bp5210Rlk0DD20GJ"
//$alp_licences:=$alp_licences+";008164-1312084330-eZ6QkW+KI50joPZnlbmay2xulexG3HtX"
//$alp_licences:=$alp_licences+";008173-OEM IF 65-MdK9yoNtO2Lfahu9hFma6DciL/MfZub2"
//$key:=utlPlugInRegistration ($alp_licences)

// per la versione compilata
//$result:=AL_Register ("008173-OEM IF 65-MdK9yoNtO2Lfahu9hFma6DciL/MfZub2")  //Unlimited single user (1/10/2019)
//$result:=AL_Register ("008962-OEM IF 65-fEdiTrzDharynPnNfOMPsFSifaQYvC56")  //Unlimited single user (1/10/2020)
$result:=AL_Register("009704-OEM IF 65-l2t5mjnOod/JD22OAdP/Ph8y9WNqzjBJ")  //Unlimited single user (1/10/2021)

$versione:="IF65 S.p.A. Promozioni"
HIDE TOOL BAR:C434
SET WINDOW TITLE:C213($versione)
MAXIMIZE WINDOW:C453

//tutti i negozi disponibili
ARRAY OBJECT:C1221(<>sedi; 0)
$sediJson:=utlElencoNegozi
JSON PARSE ARRAY:C1219($sediJson; <>sedi)

//descrizione negozi
C_OBJECT:C1216(<>sediDescrizione)
For ($i; 1; Size of array:C274(<>sedi))
	OB SET:C1220(<>sediDescrizione; <>sedi{$i}.codice; <>sedi{$i}.negozio_descrizione)
End for 

<>sediDisponibili:=New collection:C1472()
For ($i; 1; Size of array:C274(<>sedi))
	If (OB Get:C1224(<>sedi{$i}; "data_fine"; Is date:K8:7)=!00-00-00!) & (<>sedi{$i}.codice#"00@")
		$sede:=New object:C1471("codice"; <>sedi{$i}.codice; "descrizione"; <>sedi{$i}.codice+" - "+<>sedi{$i}.negozio_descrizione; "selezionata"; False:C215)
		<>sediDisponibili.push($sede)
	End if 
End for 

//elenco aderenti
ARRAY OBJECT:C1221(<>aderenti; 0)
$aderentiJson:=utlElencoAderenti
JSON PARSE ARRAY:C1219($aderentiJson; <>aderenti)

READ PICTURE FILE:C678("Menu bar 1 (6)"; <>mainPicture)



