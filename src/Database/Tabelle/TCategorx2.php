<?php
namespace Database\Tabelle;

class TCategorx2 {
    private $pdo = null;
    private  $schema ='';

    public static $tableName = 'categorx2';

    public function __construct($pdo, $schema) {
        $this->pdo = $pdo;
        $this->schema = $schema;

        self::creaTabella();
    }

    public function creaTabella() {
        try {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "CREATE TABLE IF NOT EXISTS $table (
                      `codice` int(11) unsigned NOT NULL,
                      `anno` smallint(5) unsigned NOT NULL,
                      `descrizione` varchar(100) NOT NULL DEFAULT '',
                      `dataInizioValidita` date NOT NULL,
                      `dataFineValidita` date DEFAULT NULL
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
            $this->pdo->prepare($sql)->execute();

            return true;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function elenco(array $request) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "select * from $table where dataFineValidita is null order by codice";
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
