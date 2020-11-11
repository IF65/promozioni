<?php
namespace Database\Tabelle;

use Ramsey\Uuid\Uuid;
use Ramsey\Uuid\Exception\UnsatisfiedDependencyException;

use phpDocumentor\Reflection\Types\Integer;class TProgressivi {
    private $pdo = null;
    private  $schema ='';

    public static $tableName = 'progressivi';

    public function __construct($pdo, $schema) {
        $this->pdo = $pdo;
        $this->schema = $schema;

        self::creaTabella();
    }

    public function creaTabella() {
        try {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "CREATE TABLE IF NOT EXISTS $table (
                        `id` varchar(36) DEFAULT NULL,
                        `codice` int(10) unsigned NOT NULL DEFAULT '0',
                        `tipo` smallint(5) unsigned NOT NULL DEFAULT '0',
                        `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`codice`,`tipo`),
                        KEY `id` (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
            $this->pdo->prepare($sql)->execute();

            return true;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function creaNuovoCodice(int $tipo, int $codiceIniziale = 0): Int {
        try {
            /*
             * Creo un uuid perché dopo aver creato il codice devo cercarlo. Non posso prendere semplicemente
             * il codice più alto perché c'è il rischio che un'altro ne abbia creato uno nuovo tra l'esecuzione delle
             * 2 query;
             */
            $id = Uuid::uuid4();

            $table = "`$this->schema`.`" . self::$tableName . "`";
            $sql = "insert into $table
                   select '$id', ifnull(max(p.`codice`) + 1,$codiceIniziale), $tipo, CURRENT_TIMESTAMP() from promozioni.progressivi as p where p.`tipo` = $tipo;";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute();

            $sql = "select p.`codice` codice from $table as p where p.`id` = '$id';";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute();
            $row = $stmt->fetch(\PDO::FETCH_ASSOC);
            return $row['codice'];

        } catch (PDOException $e) {
            return -1; // in caso di errore
        }
    }

    public function salvaCodiceEsistente(int $tipo, int $codice): int {
        try {
            $id = Uuid::uuid4();

            $table = "`$this->schema`.`" . self::$tableName . "`";
            $sql = "insert ignore into $table (`id`, `codice`, `tipo`) values ('$id',$codice, $tipo)";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute();

            $sql = "select ifnull(sum(p.`codice`),0) codice from $table as p where p.`id` = '$id';";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute();
            $row = $stmt->fetch(\PDO::FETCH_ASSOC);
            return $row['codice'] * 1;

        } catch (PDOException $e) {
            return -1; // in caso di errore
        }
    }

    public function verificaEsistenzaCodice(int $tipo, int $codice): int {
        try {

            $table = "`$this->schema`.`" . self::$tableName . "`";
            $sql = "select ifnull(sum(p.`codice`),0) codice from $table as p where p.`codice` = '$codice' and p.`tipo`=$tipo;";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute();
            $row = $stmt->fetch(\PDO::FETCH_ASSOC);
            return $row['codice'] * 1;

        } catch (PDOException $e) {
            return -1; // in caso di errore
        }
    }

    public function __destruct() {
        unset($this->pdo);
    }

}
?>
