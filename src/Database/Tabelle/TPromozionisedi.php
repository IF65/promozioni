<?php
namespace Database\Tabelle;

class TPromozionisedi {
    private $pdo = null;
    private  $schema ='';

    public static $tableName = 'promozioniSedi';

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
                          `idPromozioni` varchar(36) NOT NULL DEFAULT '',
                          `codiceSede` varchar(4) NOT NULL DEFAULT '',
                          PRIMARY KEY (`id`)
                        ) ENGINE=InnoDB DEFAULT CHARSET=latin1";
            $this->pdo->prepare($sql)->execute();

            return true;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function creaModifica(array $sede) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "insert into $table 
                        (`id`,`idPromozioni`,`codiceSede`)
                values
                        (:id,:idPromozioni,:codiceSede)
                on duplicate key update 
                        `idPromozioni` = :idPromozioni,
                        `codiceSede` = :codiceSede;";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([
            'id'=> $sede['id'],
            'idPromozioni'=> $sede['idPromozioni'],
            'codiceSede'=> $sede['codiceSede']
        ]);
    }

    public function elenco(array $request) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "select * from $table";
        if (key_exists('idPromozioni', $request)) {
            $sql .= " where idPromozioni = '".$request['idPromozioni']."'";
        }
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
