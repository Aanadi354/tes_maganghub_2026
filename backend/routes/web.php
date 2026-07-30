<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ItemController;
use App\Http\Controllers\Api\TransaksiController;
use App\Http\Controllers\Api\ReportController;

Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {

    Route::post('/logout', [AuthController::class, 'logout']);

    Route::get('/profile', [AuthController::class, 'profile']);

    Route::apiResource('items', ItemController::class);

    Route::post('/transaksi/masuk', [TransaksiController::class, 'barangMasuk']);

    Route::post('/transaksi/keluar', [TransaksiController::class, 'barangKeluar']);

    Route::get('/transaksi', [TransaksiController::class, 'index']);

    Route::get('/report', [ReportController::class, 'index']);

});