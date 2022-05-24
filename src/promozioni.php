<?php
@ini_set('memory_limit', '8192M');

$debug = false;

$fileName = realpath(__DIR__ . '/..') . '/debug.php';
if (file_exists($fileName)) {
	$debug = true;
}

$sqlDetails = [];

require(realpath(__DIR__ . '/..') . '/vendor/autoload.php');
require(realpath(__DIR__ . '/..') . '/src/Database/autoload.php');

include(realpath(__DIR__ . '/utlPromozioni.php'));

use Database\Database;

$timeZone = new \DateTimeZone('Europe/Rome');

$debug = False;
if ($debug) {
	//$input = file_get_contents('/Users/if65/Desktop/request.json');
	//$input ="{\"function\":\"elencoPromozioni\",\"id\":\"533D3807EA804160845901BDAB901729\"}";
	//$input ="{\"function\":\"elencoSediUsate\",\"codiciPromozione\":[\"5001223\",\"5001224\",\"5001225\"]}";
	//$input ="{\"function\":\"creaIncarichi\",\"promozioniDaInviare\":[{\"codicePromozione\":5000063,\"lavoroCodice\":10,\"data\":\"2020-11-11\",\"ora\":\"15:59\"}]}";
	//$input ="{\"function\":\"elencoNegozi\"}";
	//$input ="{\"function\":\"statoCaricamentoQuadrature\",\"sede\":\"0104\",\"dataInizio\":\"2021-07-16\",\"dataFine\":\"2021-07-16\"}";

	$input = file_get_contents('/Users/if65/Desktop/test.json');
	$request = json_decode($input, true);
} else {
	$input = file_get_contents('php://input');
	$request = json_decode($input, true);
}

if (!isset($request)) {
	die;
}

$db = new Database($sqlDetails);

if ($request['function'] == 'salva') {
	$result = $db->creaModificaPromozione($request['promozione']);
	echo $result;

} else if ($request['function'] == 'salvaAderente') {
	$result = $db->creaModificaAderente($request['aderente']);
	echo $result;

} else if ($request['function'] == 'elencoAderenti') {
	$elenco = $db->elencoAderenti($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'elencoIncarichi') {
	$elenco = $db->elencoIncarichi($request);
	echo $elenco;

} else if ($request['function'] == 'creaIncarichi') {
	$elenco = $db->creaIncarichi($request);

} else if ($request['function'] == 'cancellaIncarichi') {
	$elenco = $db->cancellaIncarichi($request);

} else if ($request['function'] == 'elencoCodiciCatalinaUsati') {
	$elenco = $db->elencoCodiciCatalinaUsati($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'elencoPromozioni') {
	$elenco = $db->elencoPromozioni($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'elencoNegozi') {
	$elenco = $db->elencoNegozi($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'elencoCategorie') {
	$elenco = $db->elencoCategorX2($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'cercaBarcodeDaCodiceArticolo') {
	$elenco = $db->elencoBarartX2($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'cercaBarcodeDaCodiceCatalina') {
	$elenco = $db->cercaBarcodeDaCodiceCatalina($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'cercaArticolo') {
	$elenco = $db->elencoArticoliX2($request);
	echo json_encode($elenco);

} else if ($request['function'] == 'promozione2text') {
	echo $db->promozione2text($request);

} else if ($request['function'] == 'creaNuovoCodice') {
	echo $db->creaNuovoCodice($request['tipo']);

} else if ($request['function'] == 'salvaCodiceEsistente') {
	echo $db->salvaCodiceEsistente($request['tipo'], $request['codice']);

} else if ($request['function'] == 'verificaEsistenzaCodice') {
	echo $db->verificaEsistenzaCodice($request['tipo'], $request['codice']);

} else if ($request['function'] == 'creaImmaginiBarcode') {
	echo creaImmagineBarcode($request['barcode']);

} else if ($request['function'] == 'ricercaArticoli') {
	echo $db->ricercaArticoli($request);

} else if ($request['function'] == 'ottieniNuovoBarcodeCatalina') {
	echo $db->ottieniNuovoBarcodeCatalina();

} else if ($request['function'] == 'esplosioneBarcode') {
	echo $db->esplosioneBarcode($request['barcode']);

} else if ($request['function'] == 'elencoSediUsate') {
	echo json_encode($db->elencoSediUsate($request));

} else if ($request['function'] == 'statoCaricamentoQuadrature') {
	echo json_encode($db->statoCaricamentoQuadrature($request));

} else if ($request['function'] == 'dettaglioQuadratura') {
	echo json_encode($db->dettaglioQuadratura($request));

}
?>

