<?php
namespace Database\Tabelle;

class VArticoli {
    private $pdo = null;

    public function __construct($pdo)
    {
        $this->pdo = $pdo;
    }

    public function ricerca(array $daCercare): string
    {
        try {

            $stmt = "select 
                        a.`COD-ART2` codice,b.`BAR13-BAR2` barcode,lpad(a.`CODCIN-PADRE-ART2`,7,'0') codicePadre,
                        d.`IDREPARTO` reparto,d.`DESCRIZIONE_REPARTO` descrizioneReparto,d.`IDSOTTOREPARTO` sottoreparto,
                        d.`DESCRIZIONE_SOTTOREPARTO` descrizioneSottoreparto,a.`DES-ART2` descrizioneArticolo, 
                        d.`COMPRATORE` compratoreCodice, d.`NOME_COMPRATORE` compratoreNome, d.`DATA_INSERIMENTO` dataInserimento,
                        d.`REPARTO_CASSE` repartoCasse
                    from `archivi`.`barartx2` as b join `archivi`.`articox2` as a on b.`CODCIN-BAR2`=a.`COD-ART2` join
                         `dimensioni`.`articolo` as d on a.`COD-ART2`=d.`CODICE_ARTICOLO` 
                    where a.`COD-ART2`<>''\n";

            if (key_exists( 'codice', $daCercare )) {
                if (preg_match( '/\%/', $daCercare['codice'] )) {
                    $stmt .= "and a.`COD-ART2` like '" . $daCercare['codice'] . "'\n";
                } else {
                    $stmt .= "and a.`COD-ART2`='" . $daCercare['codice'] . "'\n";
                }
            }

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

    public function esplosioneBarcode(string $barcode): string
    {
        try {
            $stmt = "   select b.`BAR13-BAR2` barcode, b.`CODCIN-BAR2` codice, a.`DES-ART2` descrizione 
                        from archivi.barartx2 as b join archivi.articox2 as a on b.`CODCIN-BAR2`=a.`COD-ART2` 
                        where `CODCIN-BAR2` = (select a.`COD-ART2` from archivi.barartx2 as b join archivi.articox2 as a on b.`CODCIN-BAR2`= a.`COD-ART2` 
                        where b.`BAR13-BAR2` = '$barcode')";

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

    public function ottieniNuovoBarcodeCatalina(): string
    {
        try {

            $stmt = "   select b.`BAR13-BAR2` barcode
                        from archivi.barartx2 as b join archivi.articox2 as a on b.`CODCIN-BAR2`=a.`COD-ART2` 
                        where a.`DES-ART2` like '%CATALINA%' and b.`BAR13-BAR2` like '299%'  and b.`BAR13-BAR2` not in 
                            (
                                select distinct p.`barcode` 
                                from promozioni.promozioni as p 
                                where (p.`tipo`='ACPT' or p.`tipo`='0054') and p.`dataFine` > '2021-06-01' 
                                order by 1
                            ) order by 1 
                        limit 1";

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
