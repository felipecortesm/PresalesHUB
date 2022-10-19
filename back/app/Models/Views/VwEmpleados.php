<?php

namespace App\Models\Views;

use Illuminate\Database\Eloquent\Model;

/**
 * @property string $name
 * @property string $email
 * @property int $id
 * @property string $fecha_crea
 * @property int $envio_domicilio
 * @property string $estado_pedido
 * @property string $fecha_cita
 * @property string $hora
 * @property string $estado_envio
 * @property string $fecha_envio
 * @property int $id_sede_entrega
 * @property string $nombre_sede
 * @property string $telefono
 * @property int $id_pedido
 * @property string $estado_codigo
 * @property string $tipo_entrega
 */
class VwEmpleados extends Model
{
    /**
     * @var string
     */
    protected $table = 'vw_empleado';

    /**
     * @var array
     */
    protected $fillable = ['name', 'email', 'id', 'fecha_crea', 'envio_domicilio', 'estado_pedido', 'fecha_cita', 'hora', 'estado_envio', 'fecha_envio', 'id_sede_entrega', 'nombre_sede', 'telefono', 'id_pedido', 'estado_codigo', 'tipo_entrega'];

}

