<?php

namespace Database\Tabelle;

class TVariabili
{
	private $pdo = null;
	private $schema = '';

	public static $tableName = 'variabili';

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
                          `idModelli` varchar(36) NOT NULL DEFAULT '',
						  `etichetta` varchar(100) NOT NULL DEFAULT '',
						  `valore` varchar(100) NOT NULL DEFAULT '',
						  `tipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
						  PRIMARY KEY (`idModelli`,`etichetta`)
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
			$this->pdo->prepare($sql)->execute();

			return true;
		} catch (PDOException $e) {
			die($e->getMessage());
		}
	}

	public function creaModifica(array $request)
	{
		$table = "`$this->schema`.`" . self::$tableName . "`";
		$sql = "insert into $table 
                        (`idModelli`,`etichetta`,`valore`,`tipo`)
                values
                        (:idModelli,:etichetta,:valore,:tipo)
                on duplicate key update 
                        `valore` = :valore, `tipo` = :tipo;";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute([
			'idModelli' => $request['idModelli'],
			'etichetta' => $request['etichetta'],
			'valore' => $request['valore'],
			'tipo' => $request['tipo']
		]);
	}

	public function elimina($request)
	{
		$table = "`$this->schema`.`" . self::$tableName . "`";
		$sql = "delete from $table where `idModelli` = :idModelli and `etichetta` = :etichetta";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute([
			'idModelli' => $request['idModelli'],
			'etichetta' => $request['etichetta']
		]);
	}

	public function __destruct()
	{
		unset($this->pdo);
	}

}

