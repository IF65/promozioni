<?php
require '../vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Reader\Xlsx;
use PhpOffice\PhpSpreadsheet\Shared\Date;

$timeZone = new DateTimeZone('Europe/Rome');

// verifico che il file sia stato effettivamente caricato
/*if (!isset($_FILES['userfile']) || !is_uploaded_file($_FILES['userfile']['tmp_name'])) {
	echo 'Non hai inviato nessun file...';
	//echo json_encode($_FILES, true);
	exit;
}*/

/*if (move_uploaded_file( $_FILES['userfile']['tmp_name'], "/phpUpload/".$_FILES['userfile']['name'])) {

	$inputFileName = "/phpUpload/" . $_FILES['userfile']['name'];*/

if (true) {
	$inputFileName = "/Users/if65/Desktop/CatalinaWave.xlsx";

	/** Create a new Xls Reader  **/
	$reader = new Xlsx();
	//    $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
	//    $reader = new \PhpOffice\PhpSpreadsheet\Reader\Xml();
	//    $reader = new \PhpOffice\PhpSpreadsheet\Reader\Ods();
	//    $reader = new \PhpOffice\PhpSpreadsheet\Reader\Slk();
	//    $reader = new \PhpOffice\PhpSpreadsheet\Reader\Gnumeric();
	//    $reader = new \PhpOffice\PhpSpreadsheet\Reader\Csv();
	/** Load $inputFileName to a Spreadsheet Object  **/
	$reader->setReadDataOnly(true);
	$reader->setLoadAllSheets();

	$ordini = [];

	$spreadsheet = $reader->load($inputFileName);
	for ($sheetNumber = 0; $sheetNumber < $spreadsheet->getSheetCount(); $sheetNumber++) {
		$worksheet = $spreadsheet->getSheet($sheetNumber);
		$rows = [];
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

	echo json_encode(array("recordCount" => count($rows), "values" => $rows));
} else {
	echo json_encode($_FILES, true);
}
