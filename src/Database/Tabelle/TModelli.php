<?php

namespace Database\Tabelle;

class TModelli
{
	private $pdo = null;
	private $schema = '';

	public static $tableName = 'modelli';

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
						`descrizione` varchar(100) NOT NULL DEFAULT '',
						`pmt` text NOT NULL,
						`numeroVariabili` tinyint(3) unsigned NOT NULL DEFAULT '0',
						`note` text NOT NULL
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
                        (`id`,`descrizione`,`pmt`,`numeroVariabili`,`note`)
                values
                        (:id,:descrizione,:pmt,:numeroVariabili,:note)
                on duplicate key update 
                        `descrizione` = :descrizione, `pmt` = :pmt, `numeroVariabili` = :numeroVariabili, `note` = :note;";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute([
			'id' => $request['id'],
			'descrizione' => $request['descrizione'],
			'pmt' => $request['pmt'],
			'numeroVariabili' => $request['numeroVariabili'],
			'note' => $request['note']
		]);
	}

	public function elimina($request)
	{
		$table = "`$this->schema`.`" . self::$tableName . "`";
		$sql = "delete from $table where `id` = :id";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute([
			'id' => $request['id']
		]);
	}

	public function __destruct()
	{
		unset($this->pdo);
	}

}

