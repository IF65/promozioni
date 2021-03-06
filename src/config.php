<?php

$debug = False;

$fileName = realpath(__DIR__ . '/..').'/debug.php';
if (file_exists($fileName)) {
	$debug = true;
}

// Attiva la visualizzazione degli errori in fase di debug
if ($debug) {
	error_reporting(E_ALL);
	ini_set('display_errors', '1');
}

if ($debug) {
	$sqlDetails = [
		'promozioni' => [
			"user" => "root",
			"password" => "mela",
			"host" => "10.11.14.78",
			"port" => "",
			"db" => ['archivi' =>'archivi','promozioni'=>'promozioni'],
			"dsn" => "",
			"pdoAttr" => array(),
			"exportDir" => "/Users/if65/Desktop/promozioni_invio/",
			"progressivi" => [['tipo' => 0, 'descrizione' => 'promozioni', 'codice' => 5000000]]
		],
		'quadrature' => [
			"user" => "root",
			"password" => "mela",
			"host" => "10.11.14.128",
			"port" => "",
			"db" => ['archivi' =>'archivi','mtx'=>'mtx'],
			"dsn" => "",
			"pdoAttr" => array()
		]
	];
} else {
	$sqlDetails = [
		'promozioni' => [
				"user" => "root",
				"password" => "mela",
				"host" => "10.11.14.78",
				"port" => "",
				"db" => ['archivi' =>'archivi','promozioni'=>'promozioni'],
				"dsn" => "",
				"pdoAttr" => array(),
				"exportDir" => "/promozioni_invio/",
				"progressivi" => [['tipo' => 0, 'descrizione' => 'promozioni', 'codice' => 5000000]]
			],
		'quadrature' => [
			"user" => "root",
			"password" => "mela",
			"host" => "10.11.14.128",
			"port" => "",
			"db" => ['archivi' =>'archivi','mtx'=>'mtx'],
			"dsn" => "",
			"pdoAttr" => array()
		]
	];

	$sqlQDetails = array(

	);
}

?>
