Case of 
	: (Form event code:C388=On Load:K2:1)
		
		pfPromozioni ("inizializzaRicerca")
		pfPromozioni ("inizializzaArray")
		
		LISTBOX SET ROWS HEIGHT:C835(Self:C308->;20)
		OBJECT SET FONT:C164(Self:C308->;"Arial")
		OBJECT SET FONT SIZE:C165(Self:C308->;11)
		
		
		ARRAY TEXT:C222($displayTipo;0)
		ARRAY TEXT:C222($displayTipoCodice;0)
		For ($i;1;Size of array:C274(<>promoTipo))
			APPEND TO ARRAY:C911($displayTipo;<>promoTipo{$i})
			APPEND TO ARRAY:C911($displayTipoCodice;<>promoTipoCodice{$i})
		End for 
		$columnsCount:=LISTBOX Get number of columns:C831(Self:C308->)
		If ($columnsCount>0)
			LISTBOX DELETE COLUMN:C830(Self:C308->;1;$columnsCount)
		End if 
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;1;"id";arPR_id;"hdrPR_id";hdrPR_id;"ftrPR_id";ftrPR_id)
		LISTBOX SET COLUMN WIDTH:C833(arPR_id;10)
		OBJECT SET TITLE:C194(hdrPR_id;"id")
		OBJECT SET VISIBLE:C603(arPR_id;False:C215)
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;2;"bozza";arPR_bozza;"hdrPR_bozza";hdrPR_bozza;"ftrPR_bozza";ftrPR_bozza)
		LISTBOX SET COLUMN WIDTH:C833(arPR_bozza;25)
		OBJECT SET TITLE:C194(hdrPR_bozza;"B")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;3;"stampato";arPR_stampato;"hdrPR_stampato";hdrPR_stampato;"ftrPR_stampato";ftrPR_stampato)
		LISTBOX SET COLUMN WIDTH:C833(arPR_stampato;25)
		OBJECT SET TITLE:C194(hdrPR_stampato;"S")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;4;"codice";arPR_codice;"hdrPR_codice";hdrPR_codice;"ftrPR_codice";ftrPR_codice)
		LISTBOX SET COLUMN WIDTH:C833(arPR_codice;70)
		OBJECT SET TITLE:C194(hdrPR_codice;"Codice")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;5;"codiceCatalina";arPR_codiceCatalina;"hdrPR_codiceCatalina";hdrPR_codiceCatalina;"ftrPR_codiceCatalina";ftrPR_codiceCatalina)
		LISTBOX SET COLUMN WIDTH:C833(arPR_codiceCatalina;60)
		OBJECT SET TITLE:C194(hdrPR_codiceCatalina;"Catalina")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;6;"tipo";arPR_tipo;"hdrPR_tipo";hdrPR_tipo;"ftrPR_tipo";ftrPR_tipo)
		LISTBOX SET COLUMN WIDTH:C833(arPR_tipo;160)
		OBJECT SET TITLE:C194(hdrPR_tipo;"Tipo")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;7;"sottoreparti";arPR_sottoreparti;"hdrPR_sottoreparti";hdrPR_sottoreparti;"ftrPR_sottoreparti";ftrPR_sottoreparti)
		LISTBOX SET COLUMN WIDTH:C833(arPR_sottoreparti;0)
		OBJECT SET TITLE:C194(hdrPR_sottoreparti;"S")
		OBJECT SET VISIBLE:C603(arPR_sottoreparti;False:C215)
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;8;"descrizione";arPR_descrizione;"hdrPR_descrizione";hdrPR_descrizione;"ftrPR_descrizione";ftrPR_descrizione)
		LISTBOX SET COLUMN WIDTH:C833(arPR_descrizione;70)
		OBJECT SET TITLE:C194(hdrPR_descrizione;"Descrizione")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;9;"ripetibilita";arPR_ripetibilita;"hdrPR_ripetibilita";hdrPR_ripetibilita;"ftrPR_ripetibilita";ftrPR_ripetibilita)
		LISTBOX SET COLUMN WIDTH:C833(arPR_ripetibilita;0)
		OBJECT SET TITLE:C194(hdrPR_ripetibilita;"Rip.")
		OBJECT SET VISIBLE:C603(hdrPR_ripetibilita;False:C215)
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;10;"soglia";arPR_soglia;"hdrPR_soglia";hdrPR_soglia;"ftrPR_soglia";ftrPR_soglia)
		LISTBOX SET COLUMN WIDTH:C833(arPR_soglia;50)
		OBJECT SET TITLE:C194(hdrPR_soglia;"Soglia")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;11;"importo";arPR_importo;"hdrPR_importo";hdrPR_importo;"ftrPR_importo";ftrPR_importo)
		LISTBOX SET COLUMN WIDTH:C833(arPR_importo;50)
		OBJECT SET TITLE:C194(hdrPR_importo;"Importo")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;12;"tipoCliente";arPR_tipoCliente;"hdrPR_tipoCliente";hdrPR_tipoCliente;"ftrPR_tipoCliente";ftrPR_tipoCliente)
		LISTBOX SET COLUMN WIDTH:C833(arPR_tipoCliente;30)
		OBJECT SET TITLE:C194(hdrPR_tipoCliente;"Cl.")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;13;"categoria";arPR_categoria;"hdrPR_categoria";hdrPR_categoria;"ftrPR_categoria";ftrPR_categoria)
		LISTBOX SET COLUMN WIDTH:C833(arPR_categoria;30)
		OBJECT SET TITLE:C194(hdrPR_categoria;"Cat.")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;14;"barcode";arPR_barcode;"hdrPR_barcode";hdrPR_barcode;"ftrPR_barcode";ftrPR_barcode)
		LISTBOX SET COLUMN WIDTH:C833(arPR_barcode;90)
		OBJECT SET TITLE:C194(hdrPR_barcode;"Barcode")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;15;"dataInizio";arPR_dataInizio;"hdrPR_dataInizio";hdrPR_dataInizio;"ftrPR_dataInizio";ftrPR_dataInizio)
		LISTBOX SET COLUMN WIDTH:C833(arPR_dataInizio;65)
		OBJECT SET TITLE:C194(hdrPR_dataInizio;"Data In.")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;16;"dataFine";arPR_dataFine;"hdrPR_dataFine";hdrPR_dataFine;"ftrPR_dataFine";ftrPR_dataFine)
		LISTBOX SET COLUMN WIDTH:C833(arPR_dataFine;65)
		OBJECT SET TITLE:C194(hdrPR_dataFine;"Data Fine")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;17;"oraInizio";arPR_oraInizio;"hdrPR_oraInizio";hdrPR_oraInizio;"ftrPR_oraInizio";ftrPR_oraInizio)
		LISTBOX SET COLUMN WIDTH:C833(arPR_oraInizio;65)
		OBJECT SET TITLE:C194(hdrPR_oraInizio;"Ora In.")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;18;"oraFine";arPR_oraFine;"hdrPR_oraFine";hdrPR_oraFine;"ftrPR_oraFine";ftrPR_oraFine)
		LISTBOX SET COLUMN WIDTH:C833(arPR_oraFine;65)
		OBJECT SET TITLE:C194(hdrPR_oraFine;"Ora Fine")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;19;"calendarioSettimanale";arPR_calendarioSettimanale;"hdrPR_calendarioSettimanale";hdrPR_calendarioSettimanale;"ftrPR_calendarioSettimanale";ftrPR_calendarioSettimanale)
		LISTBOX SET COLUMN WIDTH:C833(arPR_calendarioSettimanale;120)
		OBJECT SET TITLE:C194(hdrPR_calendarioSettimanale;"Calendario")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;20;"Do";arPR_Do;"hdrPR_Do";hdrPR_Do;"ftrPR_Do";ftrPR_Do)
		LISTBOX SET COLUMN WIDTH:C833(arPR_Do;25)
		OBJECT SET TITLE:C194(hdrPR_Do;"Do")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;21;"Lu";arPR_Lu;"hdrPR_Lu";hdrPR_Lu;"ftrPR_Lu";ftrPR_Lu)
		LISTBOX SET COLUMN WIDTH:C833(arPR_Lu;25)
		OBJECT SET TITLE:C194(hdrPR_Lu;"Lu")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;22;"Ma";arPR_Ma;"hdrPR_Ma";hdrPR_Ma;"ftrPR_Ma";ftrPR_Ma)
		LISTBOX SET COLUMN WIDTH:C833(arPR_Ma;25)
		OBJECT SET TITLE:C194(hdrPR_Ma;"Ma")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;23;"Me";arPR_Me;"hdrPR_Me";hdrPR_Me;"ftrPR_Me";ftrPR_Me)
		LISTBOX SET COLUMN WIDTH:C833(arPR_Me;25)
		OBJECT SET TITLE:C194(hdrPR_Me;"Me")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;24;"Gi";arPR_Gi;"hdrPR_Gi";hdrPR_Gi;"ftrPR_Gi";ftrPR_Gi)
		LISTBOX SET COLUMN WIDTH:C833(arPR_Gi;25)
		OBJECT SET TITLE:C194(hdrPR_Gi;"Gi")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;25;"Ve";arPR_Ve;"hdrPR_Ve";hdrPR_Ve;"ftrPR_Ve";ftrPR_Ve)
		LISTBOX SET COLUMN WIDTH:C833(arPR_Ve;25)
		OBJECT SET TITLE:C194(hdrPR_Ve;"Ve")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;26;"Sa";arPR_Sa;"hdrPR_Sa";hdrPR_Sa;"ftrPR_Sa";ftrPR_Sa)
		LISTBOX SET COLUMN WIDTH:C833(arPR_Sa;25)
		OBJECT SET TITLE:C194(hdrPR_Sa;"Sa")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;27;"testo";arPR_testo;"hdrPR_testo";hdrPR_testo;"ftrPR_testo";ftrPR_testo)
		LISTBOX SET COLUMN WIDTH:C833(arPR_testo;0)
		OBJECT SET TITLE:C194(hdrPR_testo;"")
		OBJECT SET VISIBLE:C603(arPR_testo;False:C215)
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;28;"numeroSedi";arPR_numeroSedi;"hdrPR_numeroSedi";hdrPR_numeroSedi;"ftrPR_numeroSedi";ftrPR_numeroSedi)
		LISTBOX SET COLUMN WIDTH:C833(arPR_numeroSedi;40)
		OBJECT SET TITLE:C194(hdrPR_numeroSedi;"Sedi")
		
		LISTBOX INSERT COLUMN:C829(Self:C308->;29;"immagineBarcode";arPR_immagineBarcode;"hdrPR_immagineBarcode";hdrPR_immagineBarcode;"ftrPR_immagineBarcode";ftrPR_immagineBarcode)
		LISTBOX SET COLUMN WIDTH:C833(arPR_immagineBarcode;0)
		OBJECT SET TITLE:C194(hdrPR_immagineBarcode;"Immagine")
		OBJECT SET VISIBLE:C603(hdrPR_immagineBarcode;False:C215)
		
End case 
