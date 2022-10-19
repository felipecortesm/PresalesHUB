<?php

namespace App\Http\Controllers\Auth;

use App\Exceptions\CustomException;
use App\Http\Controllers\Controller;
use App\Models\Usuario;
use App\Providers\RouteServiceProvider;
use DateTime;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

use App\Models\Repo\UsuarioRepo;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    const LOG_STACK = 'expsec';
    const PASS = 'password';
    const PASS_PARAM = 'password';

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Numero maximo de intentos para login
     *
     * @var int
     */
    protected $maxAttempts;

    /**
     * Numero de minutos que queda bloqueado un usuario despues de sobrepasar intentos de login incorrectos
     *
     * @var int
     */
    protected $decayMinutes;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->maxAttempts = env('LOGIN_MAX_ATTEMPTS', 3);
        $this->decayMinutes = env('LOGIN_DECAY_MINUTES', 5);
    }

    /**
     * Get the login username to be used by the controller.
     *
     * @return string
     */
    public function username()
    {
        return 'email';
    }

    /**
     * Handle a login request to the application.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Http\Response|\Illuminate\Http\JsonResponse
     * @throws CustomException
     * @throws \Illuminate\Validation\ValidationException
     */
    public function login(Request $request)
    {
        $username = $request->get($this->username());
        $newPass = $request->get('confirmPassword');

        $this->validateLogin($request);

        // If the class is using the ThrottlesLogins trait, we can automatically throttle
        // the login attempts for this application. We'll key this by the username and
        // the IP address of the client making these requests into this application.
        if (method_exists($this, 'hasTooManyLoginAttempts') && $this->hasTooManyLoginAttempts($request)) {

            //$this->fireLockoutEvent($request);
            //return $this->sendLockoutResponse($request);

            if ($this->bloquearUsuario($username)) {
                Log::stack([self::LOG_STACK])->error($username);
                throw new CustomException(__('auth.blocked'), 401, 'expsec');
            }
        }

        if ($this->attemptLogin($request)) {

            // Usuario bloqueado?
            //
            if (!empty($request->user()->locked_at)) {
                Log::stack([self::LOG_STACK])->error($username);
                throw new CustomException(__('auth.blocked'), 401, 'expsec');
            }

            if ($request->hasSession()) {
                $request->session()->put('auth.password_confirmed_at', time());
            }

            

            // Si es la primera vez que accede la clave es 'password'
            // Devolver error para gestionar nueva clave
            //
            if ($request->get(self::PASS_PARAM) === self::PASS && !isset($newPass)) {
                Log::stack([self::LOG_STACK])->error($username);
                throw new CustomException(__('auth.setPassword'), 999, 'expsec');
            }

            unset($request[self::PASS_PARAM]);
            unset($request['newPassword']);
            unset($request['confirmPassword']);


            // JAF->Obtener otros datos del usuario (Perfil, Sede)
            // Al ser la recuperacion del registro de usuario 'lazy' no se recuperan los datos relacionados
            // hasta que se solicitan.
            // Como la gestion del login la hace Laravel directamente no se donde se recupera el usuario para
            // poder modificar la llamada a 'eager'
            //
            // De esta forma aparece un campo nuevo 'perfil' en el objeto usuario con los datos del perfil
            $request->user()->perfil;


            // Establecer nueva contraseña en la bd
            //
            if (isset($newPass)) {
                try {
                    UsuarioRepo::setPassword($request->user()->id, $newPass);

                    Log::stack([self::LOG_STACK])->info($username);
                    Log::stack([self::LOG_STACK])->info(__('auth.password_changed'));

                }catch (\Exception $e) {
                    Log::stack([self::LOG_STACK])->error($username);
                    throw new CustomException(__($e->getMessage()), 500, 'expsec');
                }
            }

            Log::stack([self::LOG_STACK])->info($username);
            Log::stack([self::LOG_STACK])->info(__('auth.access_ok'));

            return response()->json($request->user());

        }
        
        
        // If the login attempt was unsuccessful we will increment the number of attempts
        // to login and redirect the user back to the login form. Of course, when this
        // user surpasses their maximum number of attempts they will get locked out.
        //
        $this->incrementLoginAttempts($request);

        Log::stack([self::LOG_STACK])->error($username);
        throw new CustomException(__('auth.failed'), 401, 'expsec');
    }


    /**
     * @param Request $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout(Request $request)
    {
        $email = $request->user()->email;

        Auth::guard('web')->logout();
        Auth::guard('web')->getSession()->invalidate();

        Log::stack([self::LOG_STACK])->info($email);
        Log::stack([self::LOG_STACK])->info(__('auth.logout_ok'));

        return response()->json(null);
    }

    /**
     * Devolver el usuario autenticado
     *
     * @param Request $request
     *
     * @return mixed
     * @throws CustomException
     */
    public function me(Request $request)
    {
        try {
            // JAF->Obtener otros datos del usuario (Perfil, Sede)
            // Al ser la recuperacion del registro de usuario 'lazy' no se recuperan los datos relacionados
            // hasta que se solicitan.
            // Como la gestion del login la hace Laravel directamente no se donde se recupera el usuario para
            // poder modificar la llamada de 'lazy' a 'eager'
            //
            // De esta forma aparece un campo 'perfil' en el objeto usuario con los datos del perfil
            $request->user()->perfil;


            return response()->json($request->user());
        } catch (\Exception $e) {
            throw new CustomException($e->getMessage(), 500, 'expsec');
        }
    }

    /**
     * @param $userId
     *
     * @return bool
     */
    private function bloquearUsuario($userId)
    {
        try {
            $user = Usuario::where($this->username(), '=', $userId)->firstOrFail();
            $user->locked_at = new \DateTime();
            $user->save();
            return true;
        } catch (\Exception $e) {
            // Ante cualquier error bloquea el usuario
            return true;
        }
    }

    /**
     * @param Request $request
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     * @throws CustomException
     */
    public function callback(Request $request)
    {
        $SAMLResponse = $request->request->get('SAMLResponse');

        Log::stack([self::LOG_STACK])->debug('SAMLResponse...', Array($SAMLResponse));

        if (empty($SAMLResponse))
        {
            throw new CustomException("SAMLResponse error");
        }

        // Recuperacion datos respuesta adfs
        //
        // En local el caracter '+' llega como espacio en blanco y descojona la codificacion, se vuelve a poner '+'
        // Habrá que ver como llega en produccion y dejar el parche o quitarlo
        //
        $SAMLResponse = base64_decode(str_replace(" ", "+", $SAMLResponse), true);

        preg_match_all("/[\._a-zA-Z0-9-]+@[\._a-zA-Z0-9-]+/i", $SAMLResponse, $matches);

        if (empty($matches[0])){
            Log::stack([self::LOG_STACK])->error('SAMLResponse id...', Array($matches[0]));
            throw new CustomException('Error adfs');
        }

        // Comprobar que el usuario existe en nuestra bd
        //
        $usu = Usuario::where($this->username(), '=', $matches[0][0])->first();

        if (empty($usu))
        {
            $info = $matches[0][0];

            if (!is_array($info))
            {
                $info = Array($matches[0][0]);
            }

            Log::stack([self::LOG_STACK])->error('Usuario no existe en app...', $info);
            throw new CustomException('No autorizado');
        }

        Log::stack([self::LOG_STACK])->debug('SAMLResponse id...', Array($matches[0]));

        unset($request['SAMLResponse']);

        // Encode email y redirigir...
        //
        $id = base64_encode($matches[0][0]);
        return redirect("https://www.renuevatuterminal.com/adfs/$id");
    }

}
