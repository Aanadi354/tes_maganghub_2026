<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Item extends Model
{
    protected $fillable = [
        'kode_barang',
        'nama_barang',
        'satuan',
        'stock_awal',
        'harga_satuan',
    ];

    public function transaksi(): HasMany
    {
        return $this->hasMany(Transaksi::class);
    }
}