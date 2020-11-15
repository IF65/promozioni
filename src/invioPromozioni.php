<?php

$sqlDetails = [];

require(realpath(__DIR__ . '/..').'/vendor/autoload.php');
require(realpath(__DIR__ . '/..').'/src/Database/autoload.php');

use Database\Database;

$timeZone = new \DateTimeZone('Europe/Rome');

$db = new Database($sqlDetails);

$elencoNegozi = $db->t_negozi->elenco([]);

$posizioneDati = $sqlDetails['exportDir'];



foreach ($elencoNegozi as $negozio) {
    if (preg_match( '/^\d{4}$/', $negozio )) {
        if (array_key_exists( $negozio, $indirizzi )) {
            $connesso = false;

            $connId = ftp_connect( $indirizzi[$negozio] );
            if ($connId) {
                if (@ftp_login( $connId, 'italfrutta', 'scrivi' )) {
                    echo "Connected: $negozio\n";
                    $connesso = true;
                } else {
                    if (@ftp_login( $connId, 'manager', 'manager' )) {
                        echo "Connected Manager: $negozio\n";
                        $connesso = true;
                    } else {
                        echo "Do Not Connected: $negozio\n";
                    }
                }
            } else {
                echo "Connection Unavailable: $negozio\n";
            }

            if ($connesso) {

                $files = scandir( $posizioneDati . '/' . $negozio, SCANDIR_SORT_ASCENDING );
                foreach ($files as $file) {
                    if (ftp_chdir( $connId, '/WEB/MTXWM/PROMOINTERFACE/INPUTFILE' )) {
                        if (preg_match( '/^(.*)\.CTL$/', $file, $fileName )) {
                            $localCtlFile = $posizioneDati . '/' . $negozio . '/' . $fileName[1] . '.CTL';
                            $localFile = $posizioneDati . '/' . $negozio . '/' . $fileName[1] . '.DAT';
                            $remoteFile = $fileName[1] . '.DAT';

                            if (ftp_put( $connId, $remoteFile, $localFile, FTP_BINARY )) {
                                unlink( $localCtlFile );
                                unlink( $localFile );
                            } else {
                                echo $localFile . ': File Non Inviato.';
                            }
                        }
                    }
                }

                $files = scandir( $posizioneDati . '/' . $negozio . '/gmrec', SCANDIR_SORT_ASCENDING );
                foreach ($files as $file) {
                    if (ftp_chdir( $connId, '/server/dp' )) {
                        if (preg_match( '/^((PROMO|COUPON).*)\.CTL$/', $file, $fileName )) {
                            $localCtlFile = $posizioneDati . '/' . $negozio . '/gmrec/' . $fileName[1] . '.CTL';
                            $localFile = $posizioneDati . '/' . $negozio . '/gmrec/' . $fileName[1] . '.PMT';
                            $remoteFile = $fileName[1] . '.PMT';

                            if (ftp_put( $connId, $remoteFile, $localFile, FTP_BINARY )) {
                                unlink( $localCtlFile );
                                unlink( $localFile );
                            } else {
                                echo $localFile . ': File Non Inviato.';
                            }
                        }
                    }
                }

                $files = scandir( $posizioneDati . '/' . $negozio . '/gmrec', SCANDIR_SORT_ASCENDING );
                foreach ($files as $file) {
                    if (ftp_chdir( $connId, '/web/mtxwm/gm/hoc' )) {
                        if (preg_match( '/^(GMREC.*)\.CTL$/', $file, $fileName )) {
                            $localCtlFile = $posizioneDati . '/' . $negozio . '/gmrec/' . $fileName[1] . '.CTL';
                            $localFile = $posizioneDati . '/' . $negozio . '/gmrec/' . $fileName[1] . '.DAT';
                            $remoteFile = $fileName[1] . '.DAT';

                            if (ftp_put( $connId, $remoteFile, $localFile, FTP_BINARY )) {
                                unlink( $localCtlFile );
                                unlink( $localFile );
                            } else {
                                echo $localFile . ': File Non Inviato.';
                            }
                        }
                    }
                }
            }

            ftp_close( $connId );
        }
    }
}