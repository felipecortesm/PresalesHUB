<?php

use App\Http\Controllers\App\CalendarioController;
use App\Http\Controllers\App\EmpleadoController;
use App\Http\Controllers\App\RefController;
use App\Http\Controllers\App\SedeController;
use App\Http\Controllers\App\TerminalController;
use App\Http\Controllers\App\PedidoController;
use App\Http\Controllers\App\UsuarioController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\App\EstadoController;
use App\Http\Controllers\App\TerminalPedidoController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Rutas NO protegidas
//
Route::post('/login', [LoginController::class, 'login']);
Route::post('/register', [RegisterController::class, 'register'])->withoutMiddleware('web');

// Rutas protegidas
//
Route::group(['middleware' => ['auth:sanctum']], function() {
    //
    Route::get('/me', [LoginController::class, 'me']);
    Route::get('/logout', [LoginController::class, 'logout']);
    //
    Route::post('/get-ref', [RefController::class, 'getReferencia']);
    Route::post('/get-usuario', [UsuarioController::class, 'getUsuario']);


});

