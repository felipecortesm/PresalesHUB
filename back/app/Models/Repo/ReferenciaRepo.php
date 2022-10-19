<?php


namespace App\Models\Repo;


use App\Models\Referencia;
use App\Models\Repo\GenericRepo;

class ReferenciaRepo extends GenericRepo
{
    /**
     * Obtiene todas las referencias
     *
     * @return Referencia[]|\Illuminate\Database\Eloquent\Collection
     */
    static final public function getAll()
    {
        return Referencia::all();
    }

    /**
     * Obtiene valores de referencia de una tabla determinada
     *
     * @param string $tabla
     *
     * @return array
     */
    final public static function getTable($tabla)
    {
        return Referencia::where('tabla', $tabla)
            ->orderBy('codigo')
            ->get();
    }

    /**
     * Obtiene valor de referencia segun tabla y codigo
     *
     * @param string $tabla
     * @param string $codigo
     *
     * @return mixed
     */
    final public static function getValue($tabla, $codigo)
    {
        return Referencia::where('tabla', $tabla)
            ->where('codigo', $codigo)
            ->first();
    }

}
