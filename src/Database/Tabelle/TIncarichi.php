<?php
namespace Database\Tabelle;

class TIncarichi extends TTable {

    public const STATO_INDEFINITO = 0;
    public const STATO_ORDINE_DI_INVIO = 10;

    public function __construct($pdo, $schema, $tableName) {
        parent::__construct($pdo, $schema, $tableName);

        self::creaTabella(
            "CREATE TABLE if not exists `".$this->schema."`.`".$this->tableName."` (
                        `id` varchar(36) NOT NULL DEFAULT '',
                        `idPadre` varchar(36) NOT NULL DEFAULT '',
                        `codicePromozione` int(10) unsigned NOT NULL DEFAULT '0',
                        `codiceLavoro` smallint(5) unsigned NOT NULL,
                        `codiceSede` varchar(4) NOT NULL DEFAULT '',
                        `stato` tinyint(3) unsigned NOT NULL DEFAULT '0',
                        `nomeFile` varchar(100) DEFAULT NULL,
                        `tsCreazione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `tsPianificazione` timestamp NULL DEFAULT NULL,
                        `tsEsecuzione` timestamp NULL DEFAULT NULL,
                      PRIMARY KEY (`id`),
                      KEY `esecuzione` (`codiceLavoro`,`codiceSede`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
        );
    }

    public function creaRecord(array $incarico): string {
        try {
            $sql = "insert into `" . $this->schema . "`.`" . $this->tableName . "` 
                            (`id`,`idPadre`,`codicePromozione`,`codiceLavoro`,`codiceSede`,`stato`,`tsPianificazione`)
                    values
                            (:id,:idPadre,:codicePromozione,:codiceLavoro,:codiceSede,:stato,:tsPianificazione);";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute( [
                'id' => $incarico['id'],
                'idPadre' => $incarico['idPadre'],
                'codicePromozione' => $incarico['codicePromozione'],
                'codiceLavoro' => $incarico['codiceLavoro'],
                'codiceSede' => $incarico['codiceSede'],
                'stato' => key_exists( 'stato', $incarico ) ? $incarico['stato'] : 0,
                'tsPianificazione' => key_exists( 'pianificazione', $incarico ) ? $incarico['pianificazione'] : null
            ] );
            $id = $this->pdo->lastInsertId();
            return $id;
        } catch (PDOException $e) {
            return '';

        }
    }

    public function modificaRecord(array $incarico) :bool {
        try {
            $sql = "update `$this->schema`.`$this->tableName` 
                set
                    `idPadre`=:idPadre,
                    `codicePromozione`=:codicePromozione,
                    `codiceLavoro`=:codiceLavoro,
                    `codiceSede`=:codiceSede,
                    `stato`=:stato,
                    `nomeFile` =:nomeFile,
                    `tsPianificazione`=:tsPianificazione,
                    `tsEsecuzione`=:tsEsecuzione
                where 
                    `id` = :id;";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute( [
                'idPadre' => $incarico['idPadre'],
                'codicePromozione' => $incarico['codicePromozione'],
                'codiceLavoro' => $incarico['codiceLavoro'],
                'codiceSede' => $incarico['codiceSede'],
                'stato' => $incarico['stato'],
                'nomeFile' => $incarico['nomeFile'],
                'tsPianificazione' => $incarico['tsPianificazione'],
                'tsEsecuzione' => $incarico['tsEsecuzione']
            ] );
            return true;

        } catch (PDOException $e) {
            return false;

        }
    }

    public function cancellaRecord(string $id): bool {
        try {
            $sql = "delete from `$this->schema`.`$this->tableName` 
                where 
                    `id` = :id and `stato` in (STATO_INDEFINITO, STATO_INVIO_PROMOZIONE);";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute( [
                'id' => $id
            ]);
            return true;

        } catch (PDOException $e) {
            return false;

        }
    }

    public function incaricoEseguito(string $id, $tsEsecuzione) {
        try {
            $sql = "update `$this->schema`.`$this->tableName` 
                set
                   `tsEsecuzione`=:tsEsecuzione
                where 
                    `id` = :id;";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute( [
                'id' => $id,
                'tsEsecuzione' => $tsEsecuzione
            ] );
            return true;

        } catch (PDOException $e) {
            //die( $e->getMessage() );
            return false;
        }
    }
    
    public function ricerca(array $daCercare): string {
        try {

            $stmt = "select * from `" . $this->schema . "`.`" . $this->tableName . "` where\n";
            if (key_exists( 'id', $daCercare )) {
                $stmt .= "id = '" . $daCercare['id'] . "' and\n";
            }
            if (key_exists( 'idPadre', $daCercare )) {
                $stmt .= "idPadre = '" . $daCercare['idPadre'] . "' and\n";
            }
            if (key_exists( 'codicePromozione', $daCercare )) {
                $stmt .= "codicePromozione = '" . $daCercare['codicePromozione'] . "' and\n";
            }
            if (key_exists( 'codiceLavoro', $daCercare )) {
                $stmt .= "codiceLavoro = " . $daCercare['codiceLavoro'] . " and\n";
            }
            if (key_exists( 'codiceSede', $daCercare )) {
                $stmt .= "codiceSede = '" . $daCercare['codiceSede'] . "' and\n";
            }
            if (key_exists( 'data', $daCercare )) {
                $stmt .= "data = '" . $daCercare['data'] . "' and\n";
            }
            if (key_exists( 'ora', $daCercare )) {
                $stmt .= "ora = '" . $daCercare['ora'] . "' and\n";
            }
            if (key_exists( 'eseguito', $daCercare )) {
                $stmt .= "eseguito = " . $daCercare['eseguito'] . " and\n";
            }
            if (key_exists( 'annullato', $daCercare )) {
                $stmt .= "annullato = " . $daCercare['annullato'] . " and\n";
            }
            if (key_exists( 'gmrec', $daCercare )) {
                $stmt .= "gmrec = " . $daCercare['gmrec'] . " and\n";
            }
            $stmt .= "id <> '';";

            $handler = $this->pdo->prepare( $stmt );

            $result = [];
            if ($handler->execute()) {
                $result = $handler->fetchAll( \PDO::FETCH_ASSOC );
            }
            return json_encode( $result );

        } catch (PDOException $e) {
            return '';

        }
    }

    public function elencoIncarichiDaEseguire(int $codiceLavoro): array {
        try {
            $sql = "select i.`id`, i.`codicePromozione`, p.`tipo` tipoPromozione, p.`pmt`, i.`codiceSede` codiceSede
                    from promozioni.incarichi as i join promozioni.promozioni as p on i.`codicePromozione` = p.`codice`
                    where i.stato = 0 and (i.`tsPianificazione` is null or i.`tsPianificazione` < now()) and 
                          i.`tsEsecuzione` is null and i.`codiceLavoro` = :codiceLavoro";

            $result = [];
            $handler = $this->pdo->prepare( $sql );
            if ($handler->execute(['codiceLavoro' => $codiceLavoro])) {
                $result = $handler->fetchAll( \PDO::FETCH_ASSOC );
            }
            return $result;

        } catch (PDOException $e) {
            return [];

        }
    }

}
?>
