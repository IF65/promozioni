<?php
namespace Database\Tabelle;

class TArticox2 {
    private $pdo = null;
    private  $schema ='';

    public static $tableName = 'articox2';

    public function __construct($pdo, $schema) {
        $this->pdo = $pdo;
        $this->schema = $schema;

        self::creaTabella();
    }

    public function creaTabella() {
        try {
            $table = "`$this->schema`.`".self::$tableName."`";
            $sql = "CREATE TABLE IF NOT EXISTS $table (
                        `REC-ARTICOX2` varchar(728) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `FILLER1` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `KIAVE-ART2` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `CODSOC-ART2` decimal(2,0) DEFAULT NULL,
                        `COD-ART2` varchar(7) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
                        `NEW-FAM-ART2` decimal(3,0) DEFAULT NULL,
                        `FILLER2` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `COZE-ART2` decimal(1,0) DEFAULT NULL,
                        `FAM-ART2` decimal(2,0) DEFAULT NULL,
                        `CODICE-ART2` decimal(3,0) DEFAULT NULL,
                        `CIN-ART2` decimal(1,0) DEFAULT NULL,
                        `DES-ART2` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `CONF-ART2` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `CAP-ART2` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PEZZAT-ART2` decimal(6,3) DEFAULT NULL,
                        `UM-ART2` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `QTA-ART2` decimal(7,2) DEFAULT NULL,
                        `PZ-ART2` decimal(4,0) DEFAULT NULL,
                        `PRBA-ART2` decimal(7,0) DEFAULT NULL,
                        `SC1-ART2` decimal(4,2) DEFAULT NULL,
                        `SC2-ART2` decimal(4,2) DEFAULT NULL,
                        `SC3-ART2` decimal(4,2) DEFAULT NULL,
                        `SC4-ART2` decimal(4,2) DEFAULT NULL,
                        `SCMERC-ART2` decimal(3,0) DEFAULT NULL,
                        `SCEXT-ART2` decimal(4,2) DEFAULT NULL,
                        `SCINLI-ART2` decimal(5,0) DEFAULT NULL,
                        `SCVAL-ART2` decimal(4,2) DEFAULT NULL,
                        `CCSS-ART2` decimal(4,0) DEFAULT NULL,
                        `ENCC-ART2` decimal(1,0) DEFAULT NULL,
                        `COSTI-ART2` decimal(4,0) DEFAULT NULL,
                        `IVA-ART2` decimal(4,2) DEFAULT NULL,
                        `PRCOFIN-ART2` decimal(7,0) DEFAULT NULL,
                        `PRVECASH-ART2` decimal(7,0) DEFAULT NULL,
                        `PRVEIF-ART2` decimal(7,0) DEFAULT NULL,
                        `VUOTI-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `GIAC-ART2` decimal(8,2) DEFAULT NULL,
                        `CODFOR-ART2` decimal(6,0) DEFAULT NULL,
                        `DAT-ART2-UORD` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `GG-ART2-UORD` decimal(2,0) DEFAULT NULL,
                        `MM-ART2-UORD` decimal(2,0) DEFAULT NULL,
                        `AA-ART2-UORD` decimal(4,0) DEFAULT NULL,
                        `NUMORD-ART2` decimal(6,0) DEFAULT NULL,
                        `SCMIN-ART2` decimal(4,0) DEFAULT NULL,
                        `ROTA-ART2` decimal(5,0) DEFAULT NULL,
                        `MEDSEM-ART2` decimal(6,0) DEFAULT NULL,
                        `USCSETT-ART2` decimal(4,0) DEFAULT NULL,
                        `SETT1-ART2` decimal(4,0) DEFAULT NULL,
                        `SETT2-ART2` decimal(4,0) DEFAULT NULL,
                        `SETT3-ART2` decimal(4,0) DEFAULT NULL,
                        `SETT4-ART2` decimal(4,0) DEFAULT NULL,
                        `PRCOMED-ART2` decimal(7,0) DEFAULT NULL,
                        `RICCASH-ART2` decimal(4,2) DEFAULT NULL,
                        `COSTOCES-ART2` decimal(7,3) DEFAULT NULL,
                        `ACQNETAZI-ART2-E` decimal(7,2) DEFAULT NULL,
                        `TOTFATT-ART2` decimal(7,0) DEFAULT NULL,
                        `SCFA-ART2` decimal(4,2) DEFAULT NULL,
                        `LIBERO-ART2` decimal(2,0) DEFAULT NULL,
                        `COFIAZI-ART2-E` decimal(7,2) DEFAULT NULL,
                        `OSF-ART2` decimal(1,0) DEFAULT NULL,
                        `OSN-ART2` decimal(1,0) DEFAULT NULL,
                        `AN-ART2` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PNCASH-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PNDETT-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `SCPER-ART2` decimal(4,2) DEFAULT NULL,
                        `SOMMAQTAARR-ART2` decimal(10,2) DEFAULT NULL,
                        `QTACONSIF-ART2` decimal(10,2) DEFAULT NULL,
                        `FATTIF-ART2` decimal(7,0) DEFAULT NULL,
                        `SEGNVPEZ-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `ISFOR-ART2` varchar(14) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `SEGNEG-ART2` decimal(1,0) DEFAULT NULL,
                        `DATELIM-ART2` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `GGELIM-ART2` decimal(2,0) DEFAULT NULL,
                        `MMELIM-ART2` decimal(2,0) DEFAULT NULL,
                        `AAELIM-ART2` decimal(4,0) DEFAULT NULL,
                        `BLOCCOVARIAZ-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `REPA-ART2` decimal(2,0) DEFAULT NULL,
                        `MARCHIO-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `FILLER3` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `CODMAG-ART2` decimal(2,0) DEFAULT NULL,
                        `GRIGLIA-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PROVENIENZA-ART2` varchar(28) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PROVEN-ART2` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `VARIETA-ART2` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `CAT-PROD-ART2` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `CALIBRO-ART2` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `SEGN-CALPRO-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PZ-RICH-LATT-ART2` decimal(3,0) DEFAULT NULL,
                        `TIPPIA-ART2` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `FILLER4` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `TOT-PZ-RESI-ART2` decimal(10,2) DEFAULT NULL,
                        `PRZ-ACQ-NETTO-ART2` decimal(7,0) DEFAULT NULL,
                        `SHELF-LIFE-ART2` decimal(4,0) DEFAULT NULL,
                        `SCAD62-ART2` decimal(3,0) DEFAULT NULL,
                        `FILLER5` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PEZ-VEN-CASH-ART2` decimal(3,0) DEFAULT NULL,
                        `SEGNO-IVAMU-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `CODCIN-PADRE-ART2` decimal(7,0) DEFAULT NULL,
                        `PVDETT-CONS-ART2` decimal(7,0) DEFAULT NULL,
                        `VUOTO-DETT-ART2` decimal(7,0) DEFAULT NULL,
                        `PRBA-ART2-E` decimal(7,2) DEFAULT NULL,
                        `SCINLI-ART2-E` decimal(4,2) DEFAULT NULL,
                        `CCSS-ART2-E` decimal(4,2) DEFAULT NULL,
                        `COSTI-ART2-E` decimal(4,2) DEFAULT NULL,
                        `PRCOFIN-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PRVECASH-ART2-E` decimal(7,2) DEFAULT NULL,
                        `SN-CASH-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PRVEIF-ART2-E` decimal(7,2) DEFAULT NULL,
                        `SN-DETT-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PRCOMED-ART2-E` decimal(7,2) DEFAULT NULL,
                        `ULTPCOFI-ART2-E` decimal(7,2) DEFAULT NULL,
                        `LIFO-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PRMERCAT-ART2-E` decimal(7,2) DEFAULT NULL,
                        `TOTFATT-ART2-E` decimal(10,2) DEFAULT NULL,
                        `TOTFAT-IF-ART2-E` decimal(10,2) DEFAULT NULL,
                        `CODFOR-UORD-ART2` decimal(6,0) DEFAULT NULL,
                        `FILLER6` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVCASHA-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-CASHA-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVCASHB-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-CASHB-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVCASHC-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-CASHC-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVDETTD-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-DETTD-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVDETTE-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-DETTE-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVDETTF-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-DETTF-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVDETTB-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-DETTB-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVDETTC-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PN-DETTC-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `COD-IVA-ART2` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `FILLER7` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `GIORNISCAD-ART2` decimal(4,0) DEFAULT NULL,
                        `PVDETTCONS-ART2-E` decimal(7,2) DEFAULT NULL,
                        `VALORE-VUO-ART2-E` decimal(7,2) DEFAULT NULL,
                        `PRZ-ACQ-NETTO-ART2-E` decimal(7,2) DEFAULT NULL,
                        `SEGNOINGR-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `SEGNOTRACC-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PERCORSO-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `SOTTOPERC-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `MARCHIOPERC-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `SEGNOPERCORSO-ART2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `PVDETTOS-ART2-E` decimal(7,2) DEFAULT NULL,
                        `SEGNOSIF-ART2-E` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `TOTPZUSCOS-ART2` decimal(10,2) DEFAULT NULL,
                        `TOTUSPVCOS-ART2-E` decimal(9,2) DEFAULT NULL,
                        `TOTUSPVIOS-ART2-E` decimal(9,2) DEFAULT NULL,
                        `NVOLTEOS-ART2` decimal(2,0) DEFAULT NULL,
                        `DATA-SCA-OS` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `AAOS-ART2` decimal(4,0) DEFAULT NULL,
                        `MMOS-ART2` decimal(2,0) DEFAULT NULL,
                        `GGOS-ART2` decimal(2,0) DEFAULT NULL,
                        `TAGLIA-ART2` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `COLORE-ART2` decimal(3,0) DEFAULT NULL,
                        `MODELLO-ART2` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `DATA-INS` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `AAINS-ART2` decimal(4,0) DEFAULT NULL,
                        `MMINS-ART2` decimal(2,0) DEFAULT NULL,
                        `TOT-CART-OM-ART2` decimal(7,2) DEFAULT NULL,
                        `ART-PRINC-ART2` decimal(7,0) DEFAULT NULL,
                        `DATASCAD-ART2` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `AASCAD-ART2` decimal(4,0) DEFAULT NULL,
                        `MMSCAD-ART2` decimal(2,0) DEFAULT NULL,
                        `GGSCAD-ART2` decimal(2,0) DEFAULT NULL,
                        `NEWPRBA-ART2-E` decimal(9,4) DEFAULT NULL,
                        `NEWALTRCO-ART2-E` decimal(5,3) DEFAULT NULL,
                        `COSTIEXTR-ART2` decimal(6,2) DEFAULT NULL,
                        `COSTIEXTR-ART2-E` decimal(6,4) DEFAULT NULL,
                        `NEWCCSS-ART2-E` decimal(4,3) DEFAULT NULL,
                        `PERCORSOFUTURO-ART2` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `DATAAGGIA-ART2` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
                        `AAAGGIA-ART2` decimal(4,0) DEFAULT NULL,
                        `MMAGGIA-ART2` decimal(2,0) DEFAULT NULL,
                        `GGAGGIA-ART2` decimal(2,0) DEFAULT NULL,
                        PRIMARY KEY (`COD-ART2`)
                        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;";
            $this->pdo->prepare($sql)->execute();

            return true;
        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function elenco(array $request) {
        $table = "`$this->schema`.`".self::$tableName."`";
        $sql = "select a.`COD-ART2` codice, a.`DES-ART2` descrizione, a.`CODCIN-PADRE-ART2` codicePadre from $table as a ";
        if (key_exists('codice', $request)) {
            $sql .= "where a.`COD-ART2` = '".$request['codice']."'";
        }
        $sql .= " order by a.`COD-ART2`;";
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
