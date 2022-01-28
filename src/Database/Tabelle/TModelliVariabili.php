<?php

namespace Database\Tabelle;

class TModelliVariabili
{
	private $pdo = null;
	private $schema = '';

	public static $tableName = 'modelliVariabili';

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
						`defaultValue` varchar(100) NOT NULL DEFAULT '',
						`tipo` tinyint(3) unsigned NOT NULL DEFAULT '0',
						`lunghezza` tinyint(3) unsigned NOT NULL DEFAULT '0'
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
                        (`idModelli`,`etichetta`,`defaultValue`,`tipo`,`lunghezza`)
                values
                        (:idModelli,:etichetta,:defaultValue,:tipo,:lunghezza)
                on duplicate key update 
                        `defaultValue` = :defaultValue, `tipo` = :tipo, `lunghezza` = :lunghezza;";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute([
			'idModelli' => $request['idModelli'],
			'etichetta' => $request['etichetta'],
			'defaultValue' => $request['defaultValue'],
			'tipo' => $request['tipo'],
			'lunghezza' => $request['lunghezza']
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

