<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Transaksi extends Model
{
    protected $fillable = [
        'kode_transaksi',
        'item_id',
        'tanggal_transaksi',
        'jenis_transaksi',
        'jumlah',
        'keterangan',
    ];

    public function item()
    {
        return $this->belongsTo(Item::class);
    }
}
