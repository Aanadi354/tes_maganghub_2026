<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ItemRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Validation rules.
     */
    public function rules(): array
    {
        $itemId = $this->route('item');

        return [
            'kode_barang' => [
                'required',
                'string',
                'max:20',
                Rule::unique('items', 'kode_barang')->ignore($itemId),
            ],
            'nama_barang' => 'required|string|max:100',
            'satuan' => 'required|string|max:20',
            'stock_awal' => 'required|integer|min:0',
            'harga_satuan' => 'required|numeric|min:0',
        ];

    }

    /**
     * Custom validation messages.
     */
    public function messages(): array
    {
        return [
            'kode_barang.required' => 'Kode barang wajib diisi.',
            'kode_barang.unique' => 'Kode barang sudah digunakan.',
            'nama_barang.required' => 'Nama barang wajib diisi.',
            'satuan.required' => 'Satuan wajib diisi.',
            'stock_awal.required' => 'Stok awal wajib diisi.',
            'stock_awal.integer' => 'Stok awal harus berupa angka.',
            'stock_awal.min' => 'Stok awal tidak boleh kurang dari 0.',
            'harga_satuan.required' => 'Harga satuan wajib diisi.',
            'harga_satuan.numeric' => 'Harga satuan harus berupa angka.',
            'harga_satuan.min' => 'Harga satuan tidak boleh kurang dari 0.',
        ];
    }
}