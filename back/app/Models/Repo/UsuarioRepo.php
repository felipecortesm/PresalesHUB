<?php


namespace App\Models\Repo;


use App\Models\Usuario;
use Illuminate\Support\Facades\Hash;

class UsuarioRepo extends GenericRepo
{
    /**
     * Obtiene usuario por su id
     *
     * @param  int $id
     *
     * @return Usuario
     */
    final public static function getById($id)
    {
        return Usuario::findOrFail($id);
    }

        /**
     * Obtiene sede según los parámetros
     *
     * @param mixed $params
     *
     * @return mixed
     */
    final public static function getUsu($params)
    {
        $query = self::getSimpleQuery(Sede::class, $params);
        return $query->get();
    }


    /**
     * Asignar nueva contraseña a un usuario por su id
     *
     * @param  int $id
     * @param  string $password
     *
     * @return void
     */
    final public static function setPassword($id, $password)
    {
        $usuario = Usuario::findOrFail($id);
        $usuario->password = Hash::make($password);
        $usuario->save();
    }
}
