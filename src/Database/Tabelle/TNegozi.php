<?php
    namespace Database\Tabelle;

	class TNegozi {
        private $pdo = null;
        private  $schema ='';

        public static $tableName = 'negozi';

        public function __construct($pdo, $schema) {
            $this->pdo = $pdo;
            $this->schema = $schema;

            self::creaTabella();
        }

        public function creaTabella() {
        	try {
                $table = "`$this->schema`.`".self::$tableName."`";
                $sql = "CREATE TABLE IF NOT EXISTS $table (
                        `codice` varchar(4) NOT NULL DEFAULT '',
                        `codice_interno` varchar(4) NOT NULL,
                        `societa` varchar(2) NOT NULL,
                        `societa_descrizione` varchar(100) NOT NULL DEFAULT '',
                        `negozio` varchar(2) NOT NULL,
                        `negozio_descrizione` varchar(100) NOT NULL DEFAULT '',
                        `tipo` tinyint(1) NOT NULL DEFAULT '3' COMMENT '1=sede, 2=magazzino, 3=vendita',
                        `ip` varchar(15) NOT NULL,
                        `ip_mtx` varchar(15) NOT NULL,
                        `utente` varchar(50) NOT NULL,
                        `password` varchar(50) NOT NULL,
                        `percorso` varchar(255) NOT NULL,
                        `data_inizio` date DEFAULT NULL,
                        `data_fine` date DEFAULT NULL,
                        `abilita` tinyint(1) NOT NULL DEFAULT '1',
                        `recupero_anagdafi` tinyint(1) NOT NULL DEFAULT '0',
                        `invio_dati_gre` tinyint(1) NOT NULL DEFAULT '0',
                        `invio_dati_copre` tinyint(1) NOT NULL DEFAULT '0',
                        `codice_ca` varchar(10) NOT NULL DEFAULT '',
                        `codice_mt` varchar(6) NOT NULL DEFAULT '',
                        `chalco` tinyint(1) NOT NULL DEFAULT '0',
                        `rootUser` varchar(50) NOT NULL DEFAULT '',
                        `rootPassword` varchar(50) NOT NULL DEFAULT '',
                        `catalina_codice_catena` varchar(3) DEFAULT NULL,
                        `catalina_codice_negozio` varchar(4) DEFAULT NULL,
                        `sottoreparti` tinyint(1) unsigned DEFAULT '1',
                        `marchio` varchar(100) NOT NULL DEFAULT '',
                        PRIMARY KEY (`codice`),
                        KEY `codice_interno` (`codice_interno`)
                      ) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
                $this->pdo->prepare($sql)->execute();
                
				return true;
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }

        public function elenco(array $request) {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "select * from $table where societa in ('01','02','04','05','31','36')";
            if (key_exists('societa', $request)) {
                $sql .= " and societa = '".$request['societa']."'";
            }
            if (key_exists('descrizione', $request)) {
                $sql .= " and descrizione like '%".$request['descrizione']."%'";
            }
            if (key_exists('sottoreparti', $request)) {
                $sql .= " and sottoreparti = ".$request['sottoreparti'];
            }
            $sql .= " order by codice;";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute();
            $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

            return $result;
        }

        public function elencoPerCodice(array $request) {
            $result = [];
            foreach($this->elenco($request) as $negozio) {
                $result[$negozio['codice']] = $negozio;
            }
            return $result;
        }

        public function __destruct() {
			unset($this->pdo);
        }

    }
?>
