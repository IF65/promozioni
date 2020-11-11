<?php
namespace Database\Tabelle;

class TAderentisedi {
    private $pdo = null;
    private  $schema ='';

    public static $tableName = 'aderentiSedi';

    public function __construct($pdo, $schema) {
        $this->pdo = $pdo;
        $this->schema = $schema;

        self::creaTabella();
    }

    public function creaTabella() {
        try {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "CREATE TABLE IF NOT EXISTS $table (
                          `idAderenti` varchar(36) NOT NULL DEFAULT '',
                          `codice` varchar(4) NOT NULL DEFAULT '',
                          `descrizione` varchar(100) NOT NULL DEFAULT '',
                          PRIMARY KEY (`idAderenti`,`codice`)
                        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
            $this->pdo->prepare($sql)->execute();

            return true;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function creaModifica(String $idAderenti, array $sede) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "insert into $table 
                        (`idAderenti`,`codice`,`descrizione`)
                values
                        (:idAderenti,:codice,:descrizione)
                on duplicate key update 
                        `descrizione` = :descrizione;";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([
            'idAderenti'=> $idAderenti,
            'codice'=> $sede['codice'],
            'descrizione'=> $sede['descrizione']
        ]);
    }

    public function elenco(array $request) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "select * from $table";
        if (key_exists('idAderenti', $request)) {
            $sql .= " where idAderenti = '".$request['idAderenti']."'";
        }
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

        return $result;
    }

    public function eliminaRighe(String $idAderenti, array $righeDaMantenere = []) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "delete from $table where `idAderenti` = '$idAderenti' and `codice`";
        if (count($righeDaMantenere)) {
            $sql .= " and `codice` not in ('".implode("','",$righeDaMantenere)."')";
        }
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
    }

    public function __destruct() {
        unset($this->pdo);
    }

}
?>
