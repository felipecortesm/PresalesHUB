<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * @property int $id
 * @property string $descripcion
 * @property int $peso
 * @property string $homeBanner
 * @property Usuario[] $usuarios
 */
class Perfil extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'perfiles';

    /**
     * @var array
     */
    protected $fillable = ['descripcion', 'peso', 'home_banner'];

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;

    /**
     * Devuelve los usuarios de un perfil
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function usuarios()
    {
        return $this->hasMany('App\Models\Usuario', 'id_perfil');
    }
}
