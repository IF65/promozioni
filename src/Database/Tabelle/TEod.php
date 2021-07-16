<?php
namespace Database\Tabelle;

class TEod {
	private $pdo = null;
	private  $schema ='';

	public static $tableName = 'eod';

	public function __construct($pdo, $schema) {
		$this->pdo = $pdo;
		$this->schema = $schema;

		self::creaTabella();
	}

	public function creaTabella() {
		try {
			$table = "`$this->schema`.`".self::$tableName."`";
			$sql = "CREATE TABLE IF NOT EXISTS $table (
					  `store` varchar(4) NOT NULL DEFAULT '',
					  `ddate` date NOT NULL,
					  `storeDescription` varchar(100) DEFAULT NULL,
					  `itemCount` int(11) NOT NULL DEFAULT 0,
					  `totalAmount` decimal(11,2) NOT NULL DEFAULT 0.00,
					  `lastSequenceNumber` int(11) NOT NULL DEFAULT 0,
					  `status` tinyint(4) NOT NULL DEFAULT 0,
					  `eod` tinyint(4) NOT NULL DEFAULT 0,
					  `ip` varchar(15) NOT NULL DEFAULT '',
					  `created_at` timestamp NULL DEFAULT NULL,
					  `modified_at` timestamp NULL DEFAULT NULL,
					  PRIMARY KEY (`store`,`ddate`),
					  KEY `eod` (`eod`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";
			$this->pdo->prepare($sql)->execute();

			return true;
		} catch (PDOException $e) {
			die($e->getMessage());
		}
	}

	public function elenco(array $request) {
		$table = "`$this->schema`.`".self::$tableName."`";
		$sql = "select * from $table where ddate = current_date()";

		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();
		$result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

		return $result;
	}

	public function __destruct() {
		unset($this->pdo);
	}

}
?>
