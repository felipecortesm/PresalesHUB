<?php


namespace App\Models\Repo;


use App\Models\Perfil;

class PerfilRepo extends GenericRepo
{
    /**
     * Obtiene perfil por su id
     *
     * @param int $id
     *
     * @return Perfil
     */
    static public function getById($id)
    {
        return Perfil::find($id);
    }
}
