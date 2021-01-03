<?php

$debug = False;

$fileName = realpath(__DIR__ . '/..').'/debug.php';
if (file_exists($fileName)) {
    $debug = true;
}
//Cioa

$indirizzi = [
    '0101' => '192.168.201.11',
    '0102' => '192.168.202.11',
    '0103' => '192.168.203.11',
    '0104' => '192.168.204.11',
    '0105' => '192.168.205.11',
    '0106' => '192.168.206.11',
    '0107' => '192.168.207.11',
    '0108' => '192.168.208.11',
    '0109' => '192.168.209.11',
    '0110' => '192.168.210.11',
    '0111' => '192.168.223.11',
    '0113' => '192.168.213.11',
    '0114' => '192.168.17.11',
    '0115' => '192.168.4.11',
    '0119' => '192.168.219.11',
    '0121' => '192.168.121.11',
    '0122' => '192.168.122.11',
    '0123' => '192.168.123.11',
    '0124' => '192.168.224.11',
    '0125' => '192.168.225.11',
    '0126' => '192.168.26.11',
    '0127' => '192.168.227.11',
    '0128' => '192.168.228.11',
    '0129' => '192.168.18.11',
    '0131' => '192.168.3.11',
    '0132' => '192.168.13.11',
    '0133' => '192.168.233.11',
    '0134' => '11.0.34.11',
    '0136' => '192.168.236.11',
    '0138' => '192.168.238.11',
    '0139' => '192.168.239.11',
    '0140' => '192.168.240.11',
    '0141' => '192.168.7.11',
    '0142' => '192.168.242.11',
    '0143' => '192.168.243.11',
    '0144' => '192.168.244.11',
    '0145' => '192.168.245.11',
    '0146' => '192.168.2.11',
    '0147' => '192.168.6.11',
    '0148' => '192.168.5.11',
    '0149' => '192.168.15.11',
    '0153' => '192.168.153.11',
    '0155' => '192.168.155.11',
    '0156' => '192.168.156.11',
    '0170' => '192.168.9.11',
    '0171' => '192.168.141.11',
    '0172' => '192.168.172.11',
    '0173' => '192.168.173.11',
    '0176' => '192.168.176.11',
    '0177' => '192.168.16.11',
    '0178' => '192.168.12.11',
    '0179' => '192.168.14.11',
    '0180' => '192.168.11.11',
    '0181' => '192.168.10.11',
    '0184' => '192.168.184.11',
    '0185' => '192.168.185.11',
    '0186' => '192.168.186.11',
    '0188' => '192.168.188.11',
    '0190' => '192.168.190.11',
    '0202' => '192.168.171.11',
    '0461' => '192.168.161.11',
    '0462' => '192.168.162.11',
    '0463' => '192.168.163.11',
    '0464' => '192.168.164.11',
    '0465' => '192.168.165.11',
    '0466' => '192.168.166.11',
    '0467' => '192.168.167.11',
    '0468' => '192.168.168.11',
    '0501' => '192.168.31.11',
    '3151' => '172.30.10.2',
    '3152' => '172.30.18.2',
    '3650' => '172.30.2.2',
    '3652' => '172.30.30.2',
    '3654' => '192.168.154.11',
    '3657' => '172.30.26.2',
    '3658' => '172.30.13.2',
    '3659' => '172.30.12.2',
    '3661' => '192.168.170.11',
    '3665' => '172.30.4.2',
    '3666' => '172.30.6.2',
    '3668' => '172.30.27.2',
    '3670' => '172.30.1.2',
    '3671' => '172.30.8.2',
    '3673' => '172.30.29.2',
    '3674' => '172.30.25.2',
    '3675' => '172.30.14.2',
    '3682' => '172.30.0.2',
    '3683' => '172.30.37.2',
    '3687' => '172.30.23.2',
    '3689' => '172.30.7.2',
    '3692' => '172.30.31.2',
    '3693' => '172.30.33.2',
    '3694' => '192.168.169.11'
];

if ($debug) {
    $posizioneDati = '/Users/if65/Desktop/promozioni_invio';
} else {
    $posizioneDati = '/promozioni_invio';
}

$negozi = scandir($posizioneDati, SCANDIR_SORT_ASCENDING);
foreach ($negozi as $negozio) {
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
                if (ftp_directory_exists($connId, '/server/arsmntapply')) {
                    $files = scandir( $posizioneDati . '/' . $negozio, SCANDIR_SORT_ASCENDING );
                    foreach ($files as $file) {
                        if (ftp_chdir( $connId, '/server/arsmntapply/data/incoming' )) {
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
                        if (ftp_chdir( $connId, '/server/arsmntapply/data/incoming' )) {
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

                } else {
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

function ftp_directory_exists($ftp, $dir) {
    // Get the current working directory
    $origin = ftp_pwd($ftp);

    // Attempt to change directory, suppress errors
    if (@ftp_chdir($ftp, $dir))
    {
        // If the directory exists, set back to origin
        ftp_chdir($ftp, $origin);
        return true;
    }

    // Directory does not exist
    return false;
}