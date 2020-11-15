<?php

$sqlDetails = [];

require(realpath(__DIR__ . '/..').'/vendor/autoload.php');
require(realpath(__DIR__ . '/..').'/src/Database/autoload.php');

use Database\Database;

$timeZone = new DateTimeZone('Europe/Rome');

$db = new Database($sqlDetails);


$incarichiDaEseguire = $db->t_incarichi->elencoIncarichiDaEseguire(10);

foreach($incarichiDaEseguire as $incarico) {
    $db->incaricoCreaFilePerInvio($incarico);
}
