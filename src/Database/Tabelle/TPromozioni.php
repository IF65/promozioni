<?php
namespace Database\Tabelle;

class TPromozioni
{
	private $pdo = null;
	private $schema = '';

	public static $tableName = 'promozioni';

	public function __construct($pdo, $schema)
	{
		$this->pdo = $pdo;
		$this->schema = $schema;

		self::creaTabella();
	}

	public function creaTabella()
	{
		try {
			$table = "`$this->schema`.`" . self::$tableName . "`";
			$sql = "CREATE TABLE IF NOT EXISTS $table (
                            `id` varchar(36) NOT NULL DEFAULT '',
                            `codice` int(11) unsigned NOT NULL AUTO_INCREMENT,
                            `codiceCatalina` int(10) unsigned NOT NULL DEFAULT '0',
                            `tipo` varchar(4) NOT NULL DEFAULT '',
                            `sottoTipo` varchar(4) NOT NULL DEFAULT '',
                            `descrizione` varchar(100) NOT NULL DEFAULT '',
                            `ripetibilita` smallint(5) unsigned NOT NULL DEFAULT '1',
                            `dataInizio` date NOT NULL DEFAULT '2000-01-01',
                            `dataFine` date NOT NULL DEFAULT '2099-12-31',
                            `oraInizio` time NOT NULL DEFAULT '00:00:00',
                            `oraFine` time NOT NULL DEFAULT '23:59:00',
                            `calendarioSettimanale` varchar(7) NOT NULL DEFAULT '1111111',
                            `tipoCliente` tinyint(3) unsigned NOT NULL DEFAULT 0,
                            `categoria` tinyint(3) unsigned NOT NULL DEFAULT 0,
                            `sottoreparti`  tinyint(1) unsigned NOT NULL DEFAULT 0,
                            `bozza` tinyint(1) unsigned NOT NULL DEFAULT 1,
                            `stampato` tinyint(1) unsigned NOT NULL DEFAULT 0,
                            `pmt` tinyint(1) unsigned NOT NULL DEFAULT 0,
                            `barcode` varchar(13) NOT NULL,
                            `testo` text NOT NULL,
                            `tsCreazione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            `tsAggiornamento` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  							`idModelli` varchar(36) DEFAULT NULL,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `codice` (`codice`)
                        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
			$this->pdo->prepare($sql)->execute();

			return true;
		} catch (PDOException $e) {
			die($e->getMessage());
		}
	}

	public function creaModifica(array $promozione)
	{
		$table = "`$this->schema`.`" . self::$tableName . "`";
		$sql = "insert into $table 
                            (`id`,`codice`,`codiceCatalina`,`tipo`,`sottoTipo`,`descrizione`,`ripetibilita`,`dataInizio`,`dataFine`,`oraInizio`,`oraFine`,
                                `calendarioSettimanale`,`tipoCliente`,`categoria`,`sottoreparti`,`bozza`,`stampato`,`pmt`,`barcode`,`testo`,`idModelli`)
                    values
                            (:id,:codice,:codiceCatalina,:tipo,:sottoTipo,:descrizione,:ripetibilita,:dataInizio,:dataFine,:oraInizio,:oraFine,:calendarioSettimanale,
                                :tipoCliente,:categoria,:sottoreparti,:bozza,:stampato,:pmt,:barcode,:testo,:idModelli)
                    on duplicate key update 
                            `codice`=:codice,
                            `codiceCatalina`=:codiceCatalina,
                            `tipo`=:tipo,
                            `sottoTipo`=:sottoTipo,
                            `descrizione`=:descrizione,
                            `ripetibilita`=:ripetibilita,
                            `dataInizio`=:dataInizio,
                            `dataFine`=:dataFine,
                            `oraInizio`=:oraInizio,
                            `oraFine`=:oraFine,
                            `calendarioSettimanale`=:calendarioSettimanale,
                            `tipoCliente`=:tipoCliente,
                            `categoria`=:categoria,
                            `sottoreparti`=:sottoreparti,
                            `bozza`=:bozza,
                            `stampato`=:stampato,
                            `pmt`=:pmt,
                            `barcode`=:barcode,
                            `testo`=:testo,
                            `idModelli`=:idModelli;";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute([
			'id' => $promozione['id'],
			'codice' => $promozione['codice'],
			'codiceCatalina' => $promozione['codiceCatalina'],
			'tipo' => $promozione['tipo'],
			'sottoTipo' => $promozione['sottoTipo'],
			'descrizione' => $promozione['descrizione'],
			'ripetibilita' => $promozione['ripetibilita'],
			'dataInizio' => $promozione['dataInizio'],
			'dataFine' => $promozione['dataFine'],
			'oraInizio' => $promozione['oraInizio'],
			'oraFine' => $promozione['oraFine'],
			'calendarioSettimanale' => $promozione['calendarioSettimanale'],
			'tipoCliente' => $promozione['tipoCliente'],
			'categoria' => $promozione['categoria'],
			'sottoreparti' => $promozione['sottoreparti'],
			'bozza' => $promozione['bozza'],
			'stampato' => $promozione['stampato'],
			'pmt' => $promozione['pmt'],
			'barcode' => $promozione['barcode'],
			'testo' => $promozione['testo'],
			'idModelli' => $promozione['idModelli']
		]);
		$id = $this->pdo->lastInsertId();
		return $id;
	}

	public function elencoCodiciCatalinaUsati(array $request)
	{
		$result = [];

		$table = "`$this->schema`.`" . self::$tableName . "`";
		if (key_exists('dallaData', $request) && key_exists('codici', $request) && count($request['codici']) > 0) {
			$elencoCodici = implode(',', $request['codici']);
			$sql = "select codiceCatalina 
                        from $table 
                        where   codiceCatalina <> 0 and dataInizio >= '" . $request['dallaData'] . "' and\n
                                codiceCatalina in ($elencoCodici)";

			$stmt = $this->pdo->prepare($sql);
			$stmt->execute();
			$result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

			$resultArray = [];
			foreach ($result as $row) {
				$resultArray[] = $row['codiceCatalina'];
			}
			$result = $resultArray;
		}
		return $result;
	}

	public function elencoSediUsate(array $request)
	{
		$result = [];

		if (key_exists('codiciPromozione', $request) && count($request['codiciPromozione']) > 0) {
			$elencoCodiciPromozione = implode(',', $request['codiciPromozione']);
			$sql = "select p.`codice` codicePromozione, s.`codiceSede` 
                        from promozioni.promozioni as p join promozioni.promozioniSedi as s on p.`id` = s.`idPromozioni` 
                        where p.`codice` in ($elencoCodiciPromozione)
                        order by 1,2";

			$stmt = $this->pdo->prepare($sql);
			$stmt->execute();
			$queryResult = $stmt->fetchAll(\PDO::FETCH_ASSOC);

			$result = [];
			foreach ($queryResult as $row) {
				$codicePromozione = $row['codicePromozione'];
				$codiceSede = $row['codiceSede'];
				$result[$codicePromozione][] = $codiceSede;
			}
		}
		return $result;
	}

	public function cercaBarcodeDaCodiceCatalina(array $request)
	{
		$codes = $request['codici'];
		$lines = [];
		foreach ($codes as $code) {
			$lines[] = "descrizione like '" . $code . "%'";
		}
		$sql = "select descrizione, barcode from promozioni.promozioni where " . implode(" or ", $lines);
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();
		$result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

		return $result;
	}

	public function elenco(array $request)
	{
		$table = "`$this->schema`.`" . self::$tableName . "`";
		$sql = "select * from $table where\n";
		if (key_exists('id', $request)) {
			$sql .= "id = '" . $request['id'] . "' and\n";
		}
		if (key_exists('bozza', $request)) {
			if ($request['bozza'] == true) {
				$sql .= "bozza = 1 and\n";
			} else {
				$sql .= "bozza = 0 and\n";
			}
		}
		if (key_exists('codice', $request)) {
			$sql .= "codice = '" . $request['codice'] . "' and\n";
		}
		if (key_exists('barcode', $request)) {
			$sql .= "barcode like '" . $request['barcode'] . "%' and\n";
		}
		if (key_exists('descrizione', $request)) {
			$sql .= "descrizione like '%" . $request['descrizione'] . "%' and\n";
		}
		if (key_exists('tipo', $request)) {
			$sql .= "tipo = '" . $request['tipo'] . "' and\n";
		}
		if (key_exists('sottoTipo', $request)) {
			$sql .= "sottoTipo = '" . $request['sottoTipo'] . "' and\n";
		}
		if (key_exists('dataCorrente', $request)) {
			$sql .= "dataInizio <= '" . $request['dataCorrente'] . "' and dataFine >= '" . $request['dataCorrente'] . "' and \n";
		} elseif (key_exists('dallaData', $request) && key_exists('allaData', $request)) {
			if ($request['dallaData'] == $request['allaData']) {
				$sql .= "dataInizio <= '" . $request['dallaData'] . "' and dataFine >= '" . $request['dallaData'] . "' and \n";
			} else {
				if (key_exists('dallaData', $request)) {
					$sql .= "dataInizio <= '" . $request['allaData'] . "' and\n";
				}
				if (key_exists('allaData', $request)) {
					$sql .= "dataFine >= '" . $request['dallaData'] . "' and\n";
				}
			}
		}
		if (key_exists('elencoId', $request)) {
			$sql .= "id  in ('" . implode("','", $request['elencoId']) . "') and\n";
		}
		$sql .= "id <> '' order by dataInizio, codice, sottoreparti";

		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();
		$result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

		return $result;
	}

	public function __destruct()
	{
		unset($this->pdo);
	}

}

?>
