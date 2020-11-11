<?php
namespace Database\Tabelle;

class TAderenti {
    private $pdo = null;
    private  $schema ='';

    public static $tableName = 'aderenti';

    public function __construct($pdo, $schema) {
        $this->pdo = $pdo;
        $this->schema = $schema;

        self::creaTabella();
    }

    public function creaTabella() {
        try {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "CREATE TABLE IF NOT EXISTS $table (
                          `id` varchar(36) NOT NULL DEFAULT '',
                          `descrizione` varchar(100) NOT NULL DEFAULT '',
                          PRIMARY KEY (`id`)
                        ) ENGINE=InnoDB DEFAULT CHARSET=latin1";
            $this->pdo->prepare($sql)->execute();

            return true;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function creaModifica(array $gruppi) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "insert into $table 
                        (`id`,`descrizione`)
                values
                        (:id,:descrizione)
                on duplicate key update 
                        `descrizione` = :descrizione;";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([
            'id'=> $gruppi['id'],
            'descrizione'=> $gruppi['descrizione']
        ]);
    }

    public function elenco(array $request) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "select * from $table";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $result;
    }

    public function eliminaRighe(string $idPromozione, array $righeDaMantenere = []) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "delete from $table where `idPromozioni` = '$idPromozione'";
        if (count($righeDaMantenere)) {
            $sql .= " and `id` not in ('".implode("','",$righeDaMantenere)."')";
        }
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
    }

    public function __destruct() {
        unset($this->pdo);
    }

}
?>
