<?php
    namespace Database\Tabelle;

	class TRicompense {
        private $pdo = null;
        private  $schema ='';

        public static $tableName = 'ricompense';

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
                            `soglia` decimal(10,2) NOT NULL DEFAULT '0.00',
                            `ammontare` decimal(10,2) NOT NULL DEFAULT '0.00',
                            `limiteSconto` decimal(10,2) NOT NULL DEFAULT '0.00',
                            `taglio` decimal(10,2) NOT NULL DEFAULT '0.00',
                            `descrizione` varchar(100) NOT NULL DEFAULT '',
                            `recordM` varchar(100) NOT NULL DEFAULT '',
                            `accumulatore` varchar(100) NOT NULL DEFAULT '',
                            `promovar` varchar(100) NOT NULL DEFAULT '',
                            `tipoArea` smallint(5) unsigned NOT NULL DEFAULT '0',
                            `ordinamentoInArea` smallint(5) unsigned NOT NULL DEFAULT '0',
                            `progressivo` smallint(5) unsigned NOT NULL DEFAULT '0',
                          PRIMARY KEY (`id`)
                        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
                $this->pdo->prepare($sql)->execute();
                
				return true;
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }

        public function creaModifica(array $ricompensa) {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "insert into $table 
                        (`id`,`idPromozioni`,`soglia`,`ammontare`,`limiteSconto`,`taglio`,`descrizione`,`recordM`,`accumulatore`,`promovar`,`tipoArea`,`ordinamentoInArea`,`progressivo`)
                    values
                        (:id,:idPromozioni,:soglia,:ammontare,:limiteSconto,:taglio,:descrizione,:recordM,:accumulatore,:promovar,:tipoArea,:ordinamentoInArea,:progressivo)
                    on duplicate key update
                        idPromozioni = :idPromozioni,
                        soglia = :soglia,
                        ammontare = :ammontare,
                        limiteSconto = :limiteSconto,
                        taglio = :taglio,
                        descrizione = :descrizione,
                        recordM = :recordM,
                        accumulatore = :accumulatore,
                        promovar = :promovar,
                        tipoArea = :tipoArea,
                        ordinamentoInArea = :ordinamentoInArea,
                        progressivo = :progressivo";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute([
                'id'=> $ricompensa['id'],
                'idPromozioni'=> $ricompensa['idPromozioni'],
                'soglia'=> $ricompensa['soglia'],
                'ammontare'=> $ricompensa['ammontare'],
                'limiteSconto'=> $ricompensa['limiteSconto'],
                'taglio'=> $ricompensa['taglio'],
                'descrizione'=> $ricompensa['descrizione'],
                'recordM'=> $ricompensa['recordM'],
                'accumulatore'=> $ricompensa['accumulatore'],
                'promovar'=> $ricompensa['promovar'],
                'tipoArea'=> $ricompensa['tipoArea'],
                'ordinamentoInArea'=> $ricompensa['ordinamentoInArea'],
                'progressivo'=> $ricompensa['progressivo']
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
