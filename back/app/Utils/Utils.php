<?php


namespace App\Utils;


class Utils
{


    /**
     * formatearImei
     * Formatea de 444740213307866 a 444740-21-330786-6
     *
     * @param  string $imei
     * @return string
     */
    static public function formatearImei($imei){
        return substr($imei, 0, 6) ."-". substr($imei, 6, 2). "-" . substr($imei, 8, 6). "-" .substr($imei, 14);
    }
}
