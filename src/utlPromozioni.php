<?php



function creaImmagineBarcode(string $barcode):string {
    $generator = new Picqer\Barcode\BarcodeGeneratorJPG();

    $immagine = $generator->getBarcode('081231723897', $generator::TYPE_EAN_13);

    $response = ['barcode' => $barcode, 'immagine' => base64_encode($immagine)];

    $responseString = json_encode($response);

    return $responseString;
}