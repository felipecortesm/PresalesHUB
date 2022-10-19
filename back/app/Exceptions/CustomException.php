<?php


namespace App\Exceptions;


use Illuminate\Support\Facades\Log;
use Throwable;

class CustomException extends \Exception
{
    private $logChannel;

    /**
     * CustomException constructor.
     *
     * @param string $message
     * @param int $code
     * @param Throwable|null $previous
     * @param string $logChannel
     */
    public function __construct($message = "", $code = 0, $logChannel = 'expapp', Throwable $previous = null)
    {
        parent::__construct($message, $code, $previous);

        $this->logChannel = explode(',', $logChannel);
    }

    /**
     * Report the exception.
     *
     * @return void
     */
    public function report()
    {
    }

    /**
     * Render the exception into an HTTP response.
     *
     * @param  \Illuminate\Http\Request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function render($request)
    {
        $info = $request->getPathInfo();
        $error = $this->getError($this->getMessage(), $this->getCode());
        $message = $error['message'];
        $code = $error['code'];

        // Registrar el error en el archivo de log
        //
        Log::stack($this->logChannel)->error( "$message ($code) - [$info]");

        return response()->json(['error' => $message, 'errorCode' => $code]);
    }

    /**
     * @param $mensaje
     * @param $code
     *
     * @return array
     */
    private function getError($mensaje, $code)
    {
        $salida = ['message' => $mensaje, 'code' => $code == 0 ? 400 : $code];

        if (strpos($mensaje, ': 1451') !== false)
            $salida = ['message' => 'Error de integridad (1451)', 'code' => 400];

        return $salida;
    }
}
