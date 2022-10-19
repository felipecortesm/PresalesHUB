<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * @property int $id
 * @property string $tabla
 * @property string $codigo
 * @property string $valor
 * @property string $descripcion
 */
class Referencia extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'referencia';

    /**
     * @var array
     */
    protected $fillable = ['tabla', 'codigo', 'valor', 'descripcion'];

    /**
     * Indicates if the model should be timestamped.
     * 
     * @var bool
     */
    public $timestamps = false;
}
