<?php


namespace App\Http\Controllers\App;


use App\Exceptions\CustomException;
use App\Http\Controllers\Controller;
use App\Models\Repo\ReferenciaRepo;
use Illuminate\Http\Request;

class RefController extends Controller
{
    /**
     * Obtiene datos de referencia
     *
     * @param Request $request
     *
     * @return \Illuminate\Http\JsonResponse
     * @throws CustomException
     */
    public function getReferencia(Request $request)
    {
        try {
            $tabla = $request->input('tabla');
            $codigo = $request->input('codigo');
            $datos = [];

            if (!isset($tabla) && !isset($codigo)){
                $datos = ReferenciaRepo::getAll();
            } elseif (isset($tabla) && !isset($codigo)){
                $datos = ReferenciaRepo::getTable($tabla);
            } elseif (isset($tabla) && isset($codigo)){
                $datos = ReferenciaRepo::getValue($tabla, $codigo);
            }
            if (empty($datos)){
                throw new \Exception("Error referencia");
            }

            return response()->json($datos);
        } catch (\Exception $e) {
            throw new CustomException($e->getMessage(), 500);
        }
    }
}
