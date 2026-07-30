<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\TransaksiRequest;
use App\Models\Item;
use App\Models\Transaksi;
use Illuminate\Support\Facades\DB;

class TransaksiController extends Controller
{
    public function barangMasuk(TransaksiRequest $request)
    {
        $data = $request->validated();

        $item = Item::findOrFail($data['item_id']);

        DB::transaction(function () use ($item, $data) {

            $item->increment('stock_awal', $data['jumlah']);

            Transaksi::create([
                'kode_transaksi'     => 'TRX-' . now()->format('YmdHis'),
                'item_id'            => $data['item_id'],
                'tanggal_transaksi'  => $data['tanggal_transaksi'],
                'jenis_transaksi'    => 'masuk',
                'jumlah'             => $data['jumlah'],
                'keterangan'         => $data['keterangan'] ?? null,
            ]);
        });


        return response()->json([
            'success' => true,
            'message' => 'Barang masuk berhasil disimpan.',
        ], 201);
    }

    public function barangKeluar(TransaksiRequest $request)
    {
        $data = $request->validated();

        $item = Item::findOrFail($data['item_id']);

        if ($item->stock_awal < $data['jumlah']) {

            return response()->json([
                'success' => false,
                'message' => 'Stok barang tidak mencukupi.'
            ],422);

        }

        DB::transaction(function () use ($item,$data){

            $item->decrement('stock_awal',$data['jumlah']);

            Transaksi::create([

                'kode_transaksi'=>'TRX-'.now()->format('YmdHis'),

                'item_id'=>$data['item_id'],

                'tanggal_transaksi'=>$data['tanggal_transaksi'],

                'jenis_transaksi'=>'keluar',

                'jumlah'=>$data['jumlah'],

                'keterangan'=>$data['keterangan'] ?? null

            ]);

        });

        return response()->json([

            'success'=>true,

            'message'=>'Barang keluar berhasil disimpan.'

        ],201);

    }

    public function laporan(Request $request)
    {
        $query = Transaksi::with('item');

        // Filter tanggal
        if (
            $request->filled('tanggal_awal') &&
            $request->filled('tanggal_akhir')
        ) {
            $query->whereBetween('tanggal_transaksi', [
                $request->tanggal_awal,
                $request->tanggal_akhir
            ]);
        }

        // Filter nama/kode barang (opsional)
        if ($request->filled('keyword')) {
            $query->whereHas('item', function ($q) use ($request) {
                $q->where('nama_barang', 'like', '%' . $request->keyword . '%')
                ->orWhere('kode_barang', 'like', '%' . $request->keyword . '%');
            });
        }

        $laporan = $query
            ->orderBy('tanggal_transaksi', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $laporan
        ]);
    }

    public function index(Request $request)
    {
        $query = Transaksi::with('item');

        if ($request->filled('jenis_transaksi')) {
            $query->where('jenis_transaksi', $request->jenis_transaksi);
        }

        if ($request->filled('tanggal')) {
            $query->whereDate('tanggal_transaksi', $request->tanggal);
        }

        $transaksi = $query->latest()->paginate(10);

        return response()->json([
            'success' => true,
            'message' => 'Data transaksi berhasil diambil.',
            'data' => $transaksi,
        ]);
    }
}


