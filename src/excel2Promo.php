<?php
require '../vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Reader\Xlsx;
use PhpOffice\PhpSpreadsheet\Shared\Date;

$timeZone = new DateTimeZone('GMT');

// verifico che il file sia stato effettivamente caricato
if (!isset($_FILES['userfile']) || !is_uploaded_file($_FILES['userfile']['tmp_name'])) {
	echo 'Non hai inviato nessun file...';
	//echo json_encode($_FILES, true);
	exit;
}

if (move_uploaded_file($_FILES['userfile']['tmp_name'], "/phpUpload/" . $_FILES['userfile']['name'])) {

	$inputFileName = "/phpUpload/" . $_FILES['userfile']['name'];
	//$inputFileName = "/Users/if65/Desktop/CatalinaWave.xlsx";

	$reader = new Xlsx();
	$reader->setReadDataOnly(true);
	$reader->setLoadAllSheets();

	$promozioni = [];
	$rows = [];
	try {
		$spreadsheet = $reader->load($inputFileName);

		for ($sheetNumber = 0; $sheetNumber < $spreadsheet->getSheetCount(); $sheetNumber++) {
			$worksheet = $spreadsheet->getSheet($sheetNumber);
			foreach ($worksheet->getRowIterator() as $row) {
				$cellIterator = $row->getCellIterator();
				$cellIterator->setIterateOnlyExistingCells(FALSE); // This loops through all cells,
				$cells = [];
				foreach ($cellIterator as $cell) {
					$cells[] = $cell->getValue();
				}
				$rows[] = $cells;
			}
		}

		foreach ($rows as $recNum => $row) {
			if ($recNum > 0) {
				$promozione = [
					"bl" => $row[0],
					"descrizione" => trim($row[1]),
					"valore" => $row[2] * 1,
					"tipo" => $row[3],
					"valore_emesso" => $row[4] * 1,
					"soglia" => $row[5] * 1,
					"data_inizio" => Date::excelToDateTimeObject($row[6], $timeZone)->format('c'),
					"data_fine" => Date::excelToDateTimeObject($row[7], $timeZone)->format('c'),
				];
				$promozioni[] = $promozione;
			}
		}
	} catch (\PhpOffice\PhpSpreadsheet\Reader\Exception|\PhpOffice\PhpSpreadsheet\Exception $e) {
	}

	echo json_encode(array("recordCount" => count($promozioni), "values" => $promozioni));
} else {
	echo json_encode($_FILES, true);
}
