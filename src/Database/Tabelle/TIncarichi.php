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
                        `lavoroCodice` smallint(5) unsigned NOT NULL,
                        `negozioCodice` varchar(4) NOT NULL DEFAULT '',
                        `stato` tinyint(3) unsigned NOT NULL DEFAULT '0',
                        `tsCreazione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `tsPianificazione` timestamp NULL DEFAULT NULL,
                        `tsEsecuzione` timestamp NULL DEFAULT NULL,
                      PRIMARY KEY (`id`),
                      KEY `esecuzione` (`lavoroCodice`,`negozioCodice`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"
        );
    }

    public function creaRecord(array $incarico): string {
        try {
            $sql = "insert into `" . $this->schema . "`.`" . $this->tableName . "` 
                            (`id`,`idPadre`,`codicePromozione`,`lavoroCodice`,`negozioCodice`,`negozioDescrizione`,`stato`,`tsPianificazione`,`tsEsecuzione`)
                    values
                            (:id,:idPadre,:codicePromozione,:lavoroCodice,:lavoroDescrizione,:negozioCodice,:negozioDescrizione,:stato,:tsPianificazione,:tsEsecuzione);";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute( [
                'id' => $incarico['id'],
                'idPadre' => $incarico['idPadre'],
                'codicePromozione' => $incarico['codicePromozione'],
                'lavoroCodice' => $incarico['lavoroCodice'],
                'lavoroDescrizione' => $incarico['lavoroDescrizione'],
                'negozioCodice' => $incarico['negozioCodice'],
                'negozioDescrizione' => $incarico['negozioDescrizione'],
                'stato' => key_exists( 'stato', $incarico ) ? $incarico['stato'] : 0,
                'tsPianificazione' => key_exists( 'tsPianificazione', $incarico ) ? $incarico['tsPianificazione'] : null,
                'tsEsecuzione' => key_exists( 'tsEsecuzione', $incarico ) ? $incarico['tsEsecuzione'] : null
            ] );
            $id = $this->pdo->lastInsertId();
            return $id;
        } catch (PDOException $e) {
            //die( $e->getMessage() );
            return '';
        }
    }

    public function modificaRecord(array $incarico) :bool {
        try {
            $sql = "update `$this->schema`.`$this->tableName` 
                set
                    `idPadre`=:idPadre,
                    `codicePromozione`=:codicePromozione,
                    `lavoroCodice`=:lavoroCodice,
                    `lavoroDescrizione`=:lavoroDescrizione,
                    `negozioCodice`=:negozioCodice,
                    `negozioDescrizione`=:negozioDescrizione,
                    `stato`=:stato,
                    `tsPianificazione`=:tsPianificazione,
                    `tsEsecuzione`=:tsEsecuzione
                where 
                    `id` = :id;";
            $stmt = $this->pdo->prepare( $sql );
            $stmt->execute( [
                'idPadre' => $incarico['idPadre'],
                'codicePromozione' => $incarico['codicePromozione'],
                'lavoroCodice' => $incarico['lavoroCodice'],
                'lavoroDescrizione' => $incarico['lavoroDescrizione'],
                'negozioCodice' => $incarico['negozioCodice'],
                'negozioDescrizione' => $incarico['negozioDescrizione'],
                'stato' => $incarico['stato'],
                'tsPianificazione' => $incarico['tsPianificazione'],
                'tsEsecuzione' => $incarico['tsEsecuzione']
            ] );
            return true;

        } catch (PDOException $e) {
            //die( $e->getMessage() );
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
            if (key_exists( 'lavoroCodice', $daCercare )) {
                $stmt .= "lavoroCodice = " . $daCercare['lavoroCodice'] . " and\n";
            }
            if (key_exists( 'negozioCodice', $daCercare )) {
                $stmt .= "negozioCodice = '" . $daCercare['negozioCodice'] . "' and\n";
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
            //die( $e->getMessage() );
            return '';
        }
    }

}
?>
