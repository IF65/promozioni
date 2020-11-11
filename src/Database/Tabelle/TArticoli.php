<?php
    namespace Database\Tabelle;

	class TArticoli {
        private $pdo = null;
        private  $schema ='';

        public static $tableName = 'articoli';

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
                          `codiceArticolo` varchar(7) NOT NULL DEFAULT '',
                          `codiceReparto` varchar(4) NOT NULL DEFAULT '',
                          `barcode` varchar(13) NOT NULL DEFAULT '',
                          `descrizione` varchar(100) NOT NULL DEFAULT '',
                          `molteplicita` smallint(5) unsigned NOT NULL DEFAULT '0',
                          `gruppo` smallint(5) unsigned NOT NULL DEFAULT '1',
                          PRIMARY KEY (`id`)
                        ) ENGINE=InnoDB DEFAULT CHARSET=latin1";
                $this->pdo->prepare($sql)->execute();
                
				return true;
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }

        public function creaModifica(array $articolo) {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "insert into $table 
                        (`id`,`idPromozioni`,`codiceArticolo`,`codiceReparto`,`barcode`,`descrizione`,`molteplicita`,`gruppo`)
                    values
                        (:id,:idPromozioni,:codiceArticolo,:codiceReparto,:barcode,:descrizione,:molteplicita,:gruppo)
                    on duplicate key update 
                        idPromozioni = :idPromozioni,
                        codiceArticolo = :codiceArticolo,
                        codiceReparto = :codiceReparto,
                        barcode = :barcode,
                        descrizione = :descrizione,
                        molteplicita = :molteplicita,
                        gruppo = :gruppo;";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute([
                'id'=> $articolo['id'],
                'idPromozioni'=> $articolo['idPromozioni'],
                'codiceArticolo'=> $articolo['codiceArticolo'],
                'codiceReparto'=> $articolo['codiceReparto'],
                'barcode'=> $articolo['barcode'],
                'descrizione'=> $articolo['descrizione'],
                'molteplicita'=> $articolo['molteplicita'],
                'gruppo'=> $articolo['gruppo']
            ]);
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

        public function __destruct() {
			unset($this->pdo);
        }

    }
?>
