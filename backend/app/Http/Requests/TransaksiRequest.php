<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TransaksiRequest extends FormRequest
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
        return [
            'item_id' => 'required|exists:items,id',
            'tanggal_transaksi' => 'required|date',
            // 'jenis_transaksi' => 'required|in:masuk,keluar',
            'jumlah' => 'required|integer|min:1',
            'keterangan' => 'nullable|string|max:255',
        ];
    }

    /**
     * Custom validation messages.
     */
    public function messages(): array
    {
        return [
            'item_id.required' => 'Barang wajib dipilih.',
            'item_id.exists' => 'Barang tidak ditemukan.',
            'tanggal_transaksi.required' => 'Tanggal transaksi wajib diisi.',
            'tanggal_transaksi.date' => 'Format tanggal tidak valid.',
            // 'jenis_transaksi.required' => 'Jenis transaksi wajib dipilih.',
            // 'jenis_transaksi.in' => 'Jenis transaksi harus masuk atau keluar.',
            'jumlah.required' => 'Jumlah wajib diisi.',
            'jumlah.integer' => 'Jumlah harus berupa angka.',
            'jumlah.min' => 'Jumlah minimal 1.',
            'keterangan.max' => 'Keterangan maksimal 255 karakter.',
        ];
    }
}