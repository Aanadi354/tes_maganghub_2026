<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Item;
use App\Http\Requests\ItemRequest;

class ItemController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $search = $request->search;

        $items = Item::when($search, function ($query) use ($search) {
                $query->where('kode_barang', 'like', "%{$search}%")
                    ->orWhere('nama_barang', 'like', "%{$search}%");
            })
            ->latest()
            ->paginate(10);

        return response()->json([
            'success' => true,
            'message' => 'Data barang berhasil diambil.',
            'data' => $items,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ItemRequest $request)
    {
        $item = Item::create($request->validated());

        return response()->json([
            'success' => true,
            'message' => 'Barang berhasil ditambahkan.',
            'data' => $item,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Item $item)
    {
        return response()->json([
            'success' => true,
            'message' => 'Detail barang berhasil diambil.',
            'data' => $item,
        ]);
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(ItemRequest $request, Item $item)
    {
        $item->update($request->safe()->only([
            'kode_barang',
            'nama_barang',
            'satuan',
            'stock_awal',
            'harga_satuan',
        ]));

        return response()->json([
            'success' => true,
            'message' => 'Barang berhasil diperbarui.',
            'data' => $item->fresh(),
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Item $item)
    {
        $item->delete();

        return response()->json([
            'success' => true,
            'message' => 'Barang berhasil dihapus.'
        ]);
    }
}
