<?php
    namespace Database;

    use \PDO;
    use Database\Tabelle\TArticoli;
    use Database\Tabelle\TArticox2;
    use Database\Tabelle\TBarartx2;
    use Database\Tabelle\TNegozi;
    use Database\Tabelle\TCategorx2;
    use Database\Tabelle\TPromozioni;
    use Database\Tabelle\TRicompense;
    use Database\Tabelle\TPromozionisedi;
    use Database\Tabelle\TCategorie;
    use Database\Tabelle\TProgressivi;
    use Database\Tabelle\TAderentisedi;
    use Database\Tabelle\TAderenti;
    use Database\Tabelle\TIncarichi;
    use Database\Tabelle\VArticoli;
    use Ramsey\Uuid\Uuid;
    use Picqer\Barcode\BarcodeGeneratorJPG;
    use Picqer\Barcode\Exceptions\BarcodeException;

    class Database {

        protected $pdo = null;
        private $db = [];
        private $negozi = [];
        
        public $t_articoli = null;
        public $t_articox2 = null;
        public $t_barartx2 = null;
        public $t_negozi = null;
        public $t_categorx2 = null;
        public $t_promozioni = null;
        public $t_ricompense = null;
        public $t_promozioniSedi = null;
        public $t_progressivi = null;
        public $t_aderenti = null;
        public $t_aderentiSedi = null;
        public $t_incarichi = null;
        public $v_articoli = null;

        private $sqlDetails = null;


        private $labelFile =
            [
                "0024" => "PROMO_0024_",
                "0034" => "PROMO_0034_",
                "0054" => "PROMO_0054_",
                "0055" => "PROMO_0055_",
                "0061" => "PROMO_0061_",
                "0070" => "PROMO_0070_",
                "0481" => "PROMO_0481_",
                "0482" => "PROMO_0482_",
                "0486" => "PROMO_0486_",
                "0487" => "PROMO_0487_",
                "0492" => "PROMO_0492_",
                "0493" => "PROMO_0493_",
                "0501" => "PROMO_0501_",
                "0503" => "PROMO_0503_",
                "0504" => "PROMO_0504_",
                "ACPT" => "PROMO_ACPT_",
                "EMBU" => "PROMO_EMBU_",
                "REBU" => "PROMO_REBU_",
                "REGN" => "PROMO_REGN_",
                "COUP" => "COUPON_",
            ];

        private $lavori =
            [
                10 => 'creazione file per esportazione',
                20 => 'creazione file per cancellazione',
                30 => 'invio file a negozio'
            ];

        public function __construct(array $sqlDetails, $loadDb = True) {
            $this->sqlDetails = $sqlDetails;
            $this->loadDb = $loadDb;
            $conStr = sprintf("mysql:host=%s", $sqlDetails['host']);
            try {
                $this->pdo = new PDO($conStr, $sqlDetails['user'], $sqlDetails['password'], [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
                $this->db = $sqlDetails['db'];

                self::createDatabase();

                $this->negozi = $this->t_negozi->elencoPerCodice([]);
                /*$this->lavori = [
                    10 => 'creazione file per esportazione',
                    20 => 'invio file a negozio'
                ];*/
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }

        public function ottieniNuovoBarcodeCatalina():string {
            $result = $this->v_articoli->ottieniNuovoBarcodeCatalina();
            return $result;
        }

        public function esplosioneBarcode(string $barcode):string {
            $result = $this->v_articoli->esplosioneBarcode($barcode);
            return $result;
        }

        public function creaNuovoCodice(int $tipo):string {
            $codiceIniziale = 0;
            if (key_exists($tipo, $this->sqlDetails['progressivi'])) {
                $codiceIniziale = $this->sqlDetails['progressivi'][$tipo]['codice'];
            }

            $codice = $this->t_progressivi->creaNuovoCodice($tipo, $codiceIniziale);
            return json_encode(['codice' => $codice]);
        }

        public function salvaCodiceEsistente(int $tipo, int $codice):string {
            $codice = $this->t_progressivi->salvaCodiceEsistente($tipo, $codice);
            return json_encode(['codice' => $codice]);
        }

        public function verificaEsistenzaCodice(int $tipo, int $codice):string {
            $codice = $this->t_progressivi->verificaEsistenzaCodice($tipo, $codice);
            return json_encode(['codice' => $codice]);
        }

        public function createDatabase() {
        	try {
            
                // creazione schemi
                // ----------------------------------------------------------
                foreach($this->db as $key => $value) {
                    $stmt = $this->pdo->prepare("create database if not exists $value;");
                    $stmt->execute();
                }

                // creazione tabelle
                // ----------------------------------------------------------
                $this->t_articoli = New TArticoli($this->pdo, $this->db['promozioni']);
                $this->t_articox2 = New TArticox2($this->pdo, $this->db['archivi']);
                $this->t_barartx2 = New TBarartx2($this->pdo, $this->db['archivi']);
                $this->t_negozi = New TNegozi($this->pdo, $this->db['archivi']);
                $this->t_categorx2 = New TCategorx2($this->pdo, $this->db['archivi']);
                $this->t_promozioni = New TPromozioni($this->pdo, $this->db['promozioni']);
                $this->t_ricompense = New TRicompense($this->pdo, $this->db['promozioni']);
                $this->t_promozioniSedi = New TPromozionisedi($this->pdo, $this->db['promozioni']);
                $this->t_progressivi = New TProgressivi($this->pdo, $this->db['promozioni']);
                $this->t_aderentiSedi = New TAderentisedi($this->pdo, $this->db['promozioni']);
                $this->t_aderenti = New TAderenti($this->pdo, $this->db['promozioni']);
                $this->t_incarichi = New TIncarichi($this->pdo, $this->db['promozioni'], 'incarichi');

                // creazione viste
                // ----------------------------------------------------------
                $this->v_articoli = New VArticoli($this->pdo);

                return true;
            } catch (PDOException $e) {
                die("DB ERROR: ". $e->getMessage());
            }
        }

        public function elencoCodiciCatalinaUsati(array $request) {
            $elenco = $this->t_promozioni->elencoCodiciCatalinaUsati($request);

            return $elenco;
        }

        public function elencoPromozioni(array $request) {
            $promozioni = $this->t_promozioni->elenco($request);

            foreach($promozioni as $key => $promozione) {
                $promozioni[$key]['immagineBarcode'] = $this->creaImmagineBarcode($promozione['barcode']);

                $ricompense = $this->t_ricompense->elenco(['idPromozioni' => $promozione['id']]);
                $promozioni[$key]['ricompense'] = $ricompense;

                $articoli = $this->t_articoli->elenco(['idPromozioni' => $promozione['id']]);
                $promozioni[$key]['articoli'] = $articoli;

                $sedi = $this->t_promozioniSedi->elenco(['idPromozioni' => $promozione['id']]);
                $promozioni[$key]['sedi'] = $sedi;
            }

            return $promozioni;
        }
        
        public function creaModificaPromozione(array $promozione) {
            $id = ($this->t_promozioni->creaModifica($promozione))*1;

            $chiaviDaMantenere = [];
            foreach($promozione['ricompense'] as $ricompensa) {
                $this->t_ricompense->creaModifica($ricompensa);
                $chiaviDaMantenere[] = $ricompensa['id'];
            }
            $this->t_ricompense->eliminaRighe($promozione['id'], $chiaviDaMantenere);

            $chiaviDaMantenere = [];
            foreach($promozione['articoli'] as $articolo) {
                $this->t_articoli->creaModifica($articolo);
                $chiaviDaMantenere[] = $articolo['id'];
            }
            $this->t_articoli->eliminaRighe($promozione['id'], $chiaviDaMantenere);

            $chiaviDaMantenere = [];
            foreach($promozione['sedi'] as $sede) {
                $this->t_promozioniSedi->creaModifica($sede);
                $chiaviDaMantenere[] = $sede['id'];
            }
            $this->t_promozioniSedi->eliminaRighe($promozione['id'], $chiaviDaMantenere);
        }

        public function elencoAderenti(array $request) {
            $aderenti = $this->t_aderenti->elenco($request);

            foreach($aderenti as $key => $aderente) {
                $aderentiSedi = $this->t_aderentiSedi->elenco(['idAderenti' => $aderente['id']]);
                $aderenti[$key]['sedi'] = $aderentiSedi;
            }

            return $aderenti;
        }

        public function creaModificaAderente(array $aderente) {
            $this->t_aderenti->creaModifica($aderente);

            $chiaviDaMantenere = [];
            foreach($aderente['sedi'] as $sede) {
                $this->t_aderentiSedi->creaModifica($aderente['id'], $sede);
                $chiaviDaMantenere[] = $sede['codice'];
            }
            $this->t_aderentiSedi->eliminaRighe($aderente['id'], $chiaviDaMantenere);
        }

        public function elencoNegozi(array $request) {
            $elenco = $this->t_negozi->elenco($request);

            return $elenco;
        }

        public function elencoIncarichi(array $request) {
            $elenco = $this->t_incarichi->ricerca($request);

            return $elenco;
        }

        public function creaIncarichi(array $request) {
            foreach ($request['promozioniDaInviare'] as $incarico) {
                $this->t_incarichi->creaRecord(
                    [
                        'id' => Uuid::uuid4()->toString(),
                        'idPadre' => '',
                        'codicePromozione' => $incarico['codicePromozione'],
                        'codiceLavoro' => $incarico['codiceLavoro'],
                        'codiceSede' => key_exists( 'codiceSede', $incarico ) ? $incarico['codiceSede'] : '',
                        'pianificazione' => key_exists( 'pianificazione', $incarico ) ? $incarico['tsPianificazione'] : null
                    ]
                );
            }
        }

        public function cancellaIncarichi(array $request): array {
            $idCancellati = [];
            foreach ($request as $id) {
                if ($this->t_incarichi->cancellaRecord($id)) {
                    $idCancellati[] = $id;
                }
            }
            return $idCancellati;
        }

        public function creaIncarichiScansionandoCartelleInvio() {
            $this->sqlDetails['exportDir'];

            foreach (scandir($this->sqlDetails['exportDir']) as $cartella) {
                if (preg_match('/^\d{4}$/', $cartella)) {
                    foreach (scandir($this->sqlDetails['exportDir'] . '/' . $cartella) as $file) {
                        if (preg_match( '/\_([^_]*)\.DAT$/', $file, $matches )) {
                            echo $matches[1] . "\n";
                        }
                    }
                }
            }
        }

        public function elencoCategorX2(array $request) {
            $elenco = $this->t_categorx2->elenco($request);

            return $elenco;
        }

        public function elencoArticoliX2(array $request) {
            $elenco = $this->t_articox2->elenco($request);

            return $elenco;
        }

        public function promozione2text(array $request):string {
            $promozioni = $this->elencoPromozioni($request);

            $result = [];
            if (count($promozioni) == 1) {
                $text = '';

                $tipoPromozione = $promozioni[0]['tipo'];
                $pmtForzato = ($promozioni[0]['pmt'] == "1");

                $cancellazione = false;
                if (key_exists('cancellazione', $request)) {
                    $cancellazione = $request['cancellazione'];
                }

                if (in_array($tipoPromozione, ['REGN','ACPT','EMBU','REBU','COUP']) or $pmtForzato) {
                    $text = $promozioni[0]['testo'];
                } else {
                    // calcolo il numero di righe del record miscellaneo
                    $numeroRigheMiscellaneo = 0;
                    if (array_key_exists( 'testo', $promozioni[0] )) {
                        foreach (explode( "\r", $promozioni[0]['testo'] ) as $riga) {
                            if (trim($riga) != '') {
                                $numeroRigheMiscellaneo++;
                            }
                        }
                    }

                    // costruisco la riga di cancellazione della promozione
                    $text .= '00D';
                    $text .= sprintf( '%09d', $promozioni[0]['codice'] );
                    $text .= $tipoPromozione;
                    $text .= sprintf( '%-40s', $promozioni[0]['descrizione'] );
                    $text .= sprintf( '%03d%27s', $promozioni[0]['ripetibilita'], '' );
                    $text .= sprintf( '%08s', str_replace( '-', '', $promozioni[0]['dataInizio'] ) );
                    $text .= sprintf( '%08s', str_replace( '-', '', $promozioni[0]['dataFine'] ) );
                    $text .= sprintf( '%06s', str_replace( ':', '', $promozioni[0]['oraInizio'] ) );
                    $text .= sprintf( '%06s', str_replace( ':', '', $promozioni[0]['oraFine'] ) );
                    $text .= sprintf( '%7s', $promozioni[0]['calendarioSettimanale'] );
                    $text .= sprintf( '%01d', $promozioni[0]['tipoCliente'] );
                    $text .= sprintf( '%05d', $promozioni[0]['categoria'] );
                    $text .= sprintf( '%02d', $numeroRigheMiscellaneo );//miscellaneo
                    $text .= sprintf( '%02d', count( $promozioni[0]['ricompense'] ) );//ricompense
                    $text .= sprintf( '%04d', count( $promozioni[0]['articoli'] ) );//articoli
                    $text .= "\r\n";

                    if (! $cancellazione) {
                        // costruisco la riga di testata della promozione
                        $text .= '00I';
                        $text .= sprintf( '%09d', $promozioni[0]['codice'] );
                        $text .= $tipoPromozione;
                        $text .= sprintf( '%-40s', $promozioni[0]['descrizione'] );
                        $text .= sprintf( '%03d%27s', $promozioni[0]['ripetibilita'], '' );
                        $text .= sprintf( '%08s', str_replace( '-', '', $promozioni[0]['dataInizio'] ) );
                        $text .= sprintf( '%08s', str_replace( '-', '', $promozioni[0]['dataFine'] ) );
                        $text .= sprintf( '%06s', str_replace( ':', '', $promozioni[0]['oraInizio'] ) );
                        $text .= sprintf( '%06s', str_replace( ':', '', $promozioni[0]['oraFine'] ) );
                        $text .= sprintf( '%7s', $promozioni[0]['calendarioSettimanale'] );
                        $text .= sprintf( '%01d', $promozioni[0]['tipoCliente'] );
                        $text .= sprintf( '%05d', $promozioni[0]['categoria'] );
                        $text .= sprintf( '%02d', $numeroRigheMiscellaneo );//miscellaneo
                        $text .= sprintf( '%02d', count( $promozioni[0]['ricompense'] ) );//ricompense
                        $text .= sprintf( '%04d', count( $promozioni[0]['articoli'] ) );//articoli
                        $text .= "\r\n";

                        // costruisco le righe ricompense
                        if (array_key_exists( 'ricompense', $promozioni[0] )) {
                            if ($tipoPromozione == '0070') {
                                usort( $promozioni[0]['ricompense'], function ($item1, $item2) {
                                    return $item1['ordinamentoInArea'] <=> $item2['ordinamentoInArea'];
                                } );
                            }

                            foreach ($promozioni[0]['ricompense'] as $recNum => $ricompensa) {
                                $text .= '01';
                                $text .= sprintf( '%09d', $promozioni[0]['codice'] );

                                $text .= sprintf( '%02d', $recNum + 1 );

                                switch ($tipoPromozione) {
                                    case "0034":
                                        $text .= sprintf( '%08d', round( $ricompensa['soglia'] * 100, 0 ) );
                                        $text .= sprintf( '%08d', $ricompensa['ammontare'] );
                                        $text .= '0001'; // reparto contabile
                                        $text .= sprintf( '%08s', $ricompensa['accumulatore']); // Promovar in accumulo
                                        $text .= sprintf( '%01d', 0 );
                                        $text .= sprintf( '%-40s', $ricompensa['descrizione'] );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= sprintf( '%08d', round( $ricompensa['limiteSconto'] * 100, 0 ) );//Passo
                                        $text .= sprintf( '%08d', $ricompensa['taglio'] );//Punti Passo
                                        $text .= sprintf( '%08s', $ricompensa['promovar']);//promovar totale
                                        $text .= sprintf( '%014s', '' );
                                        break;
                                    case "0054":
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%08d', round( $ricompensa['ammontare'] , 0 ) );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%01d', 0 );
                                        $text .= sprintf( '%-40s', $ricompensa['descrizione'] );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= sprintf( '%038s', '' );
                                        break;
                                    case "0055":
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%08d', round( $ricompensa['ammontare'] * 100, 0 ) );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%01d', 0 );
                                        $text .= sprintf( '%-40s', $ricompensa['descrizione'] );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= sprintf( '%038s', '' );
                                        break;
                                    case "0061":
                                        $text .= sprintf( '%08d', round( $ricompensa['soglia'], 0 ) );
                                        $text .= sprintf( '%08d', round( $ricompensa['ammontare'], 0 ) );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', round( $ricompensa['limiteSconto'] * 100, 0 ) );
                                        $text .= sprintf( '%01d', $ricompensa['taglio'] );
                                        $text .= sprintf( '%-40s', $ricompensa['descrizione'] );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= sprintf( '%038s', '' );
                                        break;
                                    case "0070":
                                        $text .= sprintf( '%08d', round( $ricompensa['tipoArea'], 0 ) );
                                        $text .= sprintf( '%08d', round( $ricompensa['ordinamentoInArea'], 0 ) );
                                        $text .= '0000'; // filler
                                        $text .= '00000000'; // filler
                                        $text .= '0'; // comunicazione carta (0=sempre)
                                        $text .= sprintf( '%-80s', $ricompensa['descrizione'] );
                                        $text .= sprintf( '%-13s', '' );
                                        break;
                                    case "0481":
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', round( 0 ));
                                        $text .= '0';
                                        $text .= sprintf( '%-40s', 'BUONO SCONTO' );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= sprintf( '%-038s', '0111' . sprintf( '%04d', $ricompensa['promovar'] ));
                                        break;
                                    case "0482":
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', round( 0 ));
                                        $text .= '0';
                                        $text .= sprintf( '%-40s', 'BUONO SCONTO' );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= sprintf( '%-038s', '0111' . sprintf( '%04d', $ricompensa['promovar'] ));
                                        break;
                                    case "0487":
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= '0000'; // reparto contabile
                                        $text .= '00000000';
                                        $text .= '0';
                                        $text .= sprintf( '%-40s', $ricompensa['descrizione']  );
                                        $text .= sprintf( '%-15s', '' );
                                        $text .= sprintf( '%-8s', '' );
                                        $text .= sprintf( '%-8s', '' );
                                        $text .= sprintf( '%-022s', 0 );
                                        break;
                                    case "0492":
                                        $text .= sprintf( '%08d', round( $ricompensa['taglio'] * 100, 0 ) );
                                        $text .= sprintf( '%08d', round( $ricompensa['ammontare'] , 0 ) ); //sconto bollone
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', round( $ricompensa['limiteSconto'] * 100, 0 ) );
                                        $text .= '0';
                                        $text .= sprintf( '%-40s', $ricompensa['descrizione'] );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= sprintf( '%-8s', '' );
                                        $text .= '00000000';
                                        $text .= sprintf( '%-022s', 0 );
                                        break;
                                    case "0493":
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%08d', round( $ricompensa['ammontare'] * 100, 0 ) );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%01d', 0 );
                                        $text .= sprintf( '%-40s', $ricompensa['descrizione'] );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= '0111' . sprintf( '%4d', $ricompensa['promovar'] );
                                        $text .= sprintf( '%030s', 0 );
                                        break;
                                    case "0501":
                                        $text .= sprintf( '%08d', round( $ricompensa['soglia'] * 100, 0 ) );
                                        $text .= sprintf( '%08d', round( $ricompensa['ammontare'] * 100, 0 ) );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%01d', $ricompensa['ripetibilita'] );
                                        $text .= sprintf( '%-40s', '' );
                                        $text .= sprintf( '%-15s', '' );
                                        $text .= sprintf( '%08d', $ricompensa['promovar'] );
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%22s', '' );
                                        break;
                                    case "0503":
                                        $descrizione = 'BUONO SCONTO';
                                        if ($ricompensa['descrizione'] != '') {
                                            $descrizione = $ricompensa['descrizione'];
                                        }
                                        $text .= sprintf( '%08d', round( $ricompensa['soglia'] * 100, 0 ) );
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= '0000'; // reparto contabile
                                        $text .= sprintf( '%08d', 0 );
                                        $text .= sprintf( '%01d', 1 );
                                        $text .= sprintf( '%-40s', $descrizione );
                                        $text .= sprintf( '%-15s', $ricompensa['recordM'] );
                                        $text .= '0111' . sprintf( '%04d', $ricompensa['promovar'] );
                                        $text .= sprintf( '%08d', round( $ricompensa['taglio'] * 100, 0 ) );
                                        $text .= sprintf( '%022d', 0 );
                                        break;
                                }
                                $text .= "\r\n";
                            }
                        }

                        // costruisco le righe articoli
                        if (array_key_exists( 'articoli', $promozioni[0] )) {
                            foreach ($promozioni[0]['articoli'] as $recNum => $articolo) {
                                $text .= '02';
                                $text .= sprintf( '%09d', $promozioni[0]['codice'] );
                                $text .= sprintf( '%04d', $recNum + 1 );

                                $codice = $articolo['barcode'];
                                if ($articolo['codiceReparto'] != '' ) {
                                    $codice = $articolo['codiceReparto'];
                                }

                                switch ($tipoPromozione) {
                                    case "0054":
                                        $text .= sprintf( '%13s',$codice );
                                        $text .= sprintf( '%08d', (key_exists( 'molteplicita', $articolo )) ? $articolo['molteplicita'] : 0 );
                                        $text .= sprintf( '%03d', $articolo['gruppo'] );
                                        $text .= sprintf( '%096d', 0 );
                                        break;
                                    case "0055":
                                        $text .= sprintf( '%13s',$codice );
                                        $text .= sprintf( '%08d', (key_exists( 'molteplicita', $articolo )) ? $articolo['molteplicita'] : 0 );
                                        $text .= sprintf( '%03d', $articolo['gruppo'] );
                                        $text .= sprintf( '%096d', 0 );
                                        break;
                                    case "0481":
                                        $text .= sprintf( '%013s',$codice );
                                        $text .= sprintf( '%08d', (key_exists( 'molteplicita', $ricompensa )) ? $ricompensa['molteplicita'] : 0 );
                                        $text .= '000'; // codice gruppo
                                        $text .= sprintf( '%096d', 0 );
                                        break;
                                    case "0492":
                                        $text .= sprintf( '%013s',$codice );
                                        $text .= '00000000'; //molteplicita'
                                        $text .= '000'; //codice  gruppo'
                                        $text .= sprintf( '%-096s', 0 );
                                        break;
                                    case "0493":
                                        $text .= sprintf( '%13s',$codice );
                                        $text .= sprintf( '%08d', 0);
                                        $text .= sprintf( '%03d', 0);
                                        $text .= sprintf( '%096d', 0 );
                                }
                                $text .= "\r\n";
                            }
                        }

                        // costruisco le righe misecellanee
                        if (array_key_exists( 'testo', $promozioni[0] )) {
                            foreach (explode( "\r", $promozioni[0]['testo'] ) as $recNum => $riga) {
                                $riga = trim( $riga );
                                if ($riga != '') {
                                    $text .= '03';
                                    $text .= sprintf( '%09d', $promozioni[0]['codice'] );
                                    $text .= sprintf( '%02d', $recNum + 1 );

                                    switch ($tipoPromozione) {
                                        case "0501":
                                            $text .= sprintf( '%-122s', $riga );
                                            break;
                                        case "0487":
                                            $text .= sprintf( '%-122s', $riga );
                                            break;
                                        case "0492":
                                            $text .= sprintf( '%-122s', $riga );
                                            break;
                                    }
                                    $text .= "\r\n";
                                }
                            }
                        }
                    }
                }
                $result = ['codice' => $promozioni[0]['codice'], 'tipo' => $tipoPromozione, 'testo' => $text, 'sedi' => $promozioni[0]['sedi']];
            }


            return json_encode($result, JSON_PRETTY_PRINT);
        }

        private function creaImmagineBarcode(string $barcode):string {
            if (strlen($barcode) > 0) {
                $generator = new BarcodeGeneratorJPG();

                $barcodeType = $generator::TYPE_CODE_128;
                if (strlen( $barcode ) <= 8) {
                    $barcodeType = $generator::TYPE_EAN_8;
                    $barcode = str_pad( $barcode, 8, "0", STR_PAD_LEFT );
                } else if (strlen( $barcode ) > 8 && strlen( $barcode ) <= 13) {
                    $barcodeType = $generator::TYPE_EAN_13;
                    $barcode = str_pad( $barcode, 8, "0", STR_PAD_LEFT );
                }

                try {
                    $immagine = $generator->getBarcode( $barcode, $barcodeType );

                    return base64_encode( $immagine );
                } catch (BarcodeException $e) {
                    return '';
                }
            } else {
                return '';
            }

        }

        public function ricercaArticoli(array $request) {
            $elenco = $this->v_articoli->ricerca($request);

            return $elenco;
        }

        public function elencoSediUsate(array $request) {
            $elenco = $this->t_promozioni->elencoSediUsate($request);

            return $elenco;
        }

        public function incaricoCreaFilePerInvio(array $incarico) {
            try {
                // creazione cartelle
                // Attenzione: la cartella base potrebbe non essere creabile per la configurazione di sicurezza di apache.
                // In questo caso basta crearla manualmente. Le altre cartelle non hanno problemi.
                if (!file_exists( $this->sqlDetails['exportDir'] )) {
                    mkdir( $this->sqlDetails['exportDir'] ); // default 0777
                }

                if (!file_exists( $this->sqlDetails['exportDir'] . $incarico['codiceSede'] )) {
                    mkdir( $this->sqlDetails['exportDir'] . $incarico['codiceSede'] ); // default 0777

                    if (!file_exists( $this->sqlDetails['exportDir'] . $incarico['codiceSede'] . '/gmrec' )) {
                        mkdir( $this->sqlDetails['exportDir'] . $incarico['codiceSede'] . '/gmrec' ); // default 0777
                    }
                }

                $nomeFile = "TIPO_0000_" . $incarico['tipoPromozione'];
                if (key_exists( $incarico['tipoPromozione'], $this->labelFile )) {
                    $nomeFile = $this->labelFile[$incarico['tipoPromozione']] . $incarico['codicePromozione'];
                }


                $dataObj = $this->promozione2text(['codice' => $incarico['codicePromozione']]);
                $data = json_decode($dataObj, true);

                $gmrec = 0;
                $filePath = $this->sqlDetails['exportDir'] . $incarico['codiceSede'] . '/';
                if (in_array( $incarico['tipoPromozione'], ['REGN', 'ACPT', 'EMBU', 'REBU', 'COUP'] ) or ($incarico['pmt'] == 1)) {
                    $gmrec = 1;
                    $filePath .= '/gmrec/';
                    $filePromo = $nomeFile . '.PMT';
                    $fileControllo = $nomeFile . '.CTL';

                } else {
                    $filePromo = $nomeFile . '.DAT';
                    $fileControllo = $nomeFile . '.CTL';

                }

                file_put_contents( $filePath . $filePromo, utf8_encode( $data['testo'] ) );
                file_put_contents( $filePath . $fileControllo, utf8_encode( '' ) );

                $this->t_incarichi->incaricoEseguito($incarico['id'], (new \DateTime())->format('Y-m-d H:i:s'));

                $this->t_incarichi->creaRecord([
                        'id' => Uuid::uuid4()->toString(),
                        'idPadre' => $incarico['id'],
                        'codicePromozione' => $incarico['codicePromozione'],
                        'codiceLavoro' => 20,
                        'codiceSede' => $incarico['codiceSede']
                    ]);

            } catch (PDOException $e) {
                die( $e->getMessage() );
            }
        }

        public function __destruct() {
            $this->pdo = null;
        }
    }
?>
