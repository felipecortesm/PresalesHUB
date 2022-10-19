<?php


namespace App\Models\Repo;

use Illuminate\Support\Facades\DB;

class GenericRepo
{
    /**
     * Estados pedido
     */
    const EN_CURSO_SEDE = 'SED';
    const EN_CURSO_ZELERIS = 'ZEL';
    const PEND_APROBACION = 'PEN';
    const ENVIADO = 'ENV';
    const FINALIZADO = 'FIN';
    const CANCELADO = 'CAN';
    const RECHAZADO = 'REC';
    const BORRADO = 'BOR';

    /**
     * Devuelve consulta segun objeto y parámetros
     *
     * @param $object
     * @param null|mixed $params
     *
     * @return mixed
     */
    static function getSimpleQuery($object, $params = null)
    {
        $where = isset($params['where']) ? $params['where'] : null;
        $orderBy = isset($params['orderBy']) ? $params['orderBy'] : null;
        $eager = isset($params['eager']) ? $params['eager'] : [];

        $query = $object::select();

        // Monta clausula WHERE
        //
        if (!empty($where)){
            $query->whereRaw($where);
        }

        // Monta clausula ORDERBY
        //
        if (!empty($orderBy)){
            $query->orderByRaw($orderBy);
        }

        // Recupera los objetos relacionados
        //
        foreach ($eager as $key => $value)
        {
            $query->with(trim($key));

            if (!isset($value))
            {
                continue;
            }

            $query->whereHas(trim($key), function ($query) use ($value) {
                $query->whereRaw($value);
            });
        }

        return $query;
    }
}
