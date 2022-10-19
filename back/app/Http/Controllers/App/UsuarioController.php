<?php


namespace App\Http\Controllers\App;


use App\Exceptions\CustomException;
use App\Http\Controllers\Controller;
use App\Models\Repo\GenericRepo;
use App\Models\Repo\UsuarioRepo;
use App\Models\Usuario;
use App\Models\Repo\VwEmpleadosRepo;
use Illuminate\Http\Request;

class UsuarioController extends Controller
{
    /**
     * Obtiene información de un usuario
     *
     * @param Request $request
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws CustomException
     */
    final public static function getUsuario(Request $request)
    {
        try
        {
            $id = $request->get('id');
            $datos = UsuarioRepo::getById($id);

            if (empty($datos)){
                throw new \Exception("No hay datos");
            }

            return response()->json($datos);
        }catch (\Exception $e) {
            throw new CustomException($e->getMessage(), 500);
        }
    }

}
