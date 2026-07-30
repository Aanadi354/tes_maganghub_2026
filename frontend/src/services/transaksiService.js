import api from "./api";

// ==============================
// BARANG MASUK
// ==============================

// mengambil data barang masuk
export const getBarangMasuk = () =>
    api.get("/transaksi", {
        params: {
            jenis_transaksi: "masuk",
        },
    });

// tambah barang masuk
export const createBarangMasuk = (data) =>
    api.post("/transaksi/masuk", data);

// edit barang masuk
export const updateBarangMasuk = (id, data) =>
    api.put(`/transaksi/masuk/${id}`, data);

// hapus barang masuk
export const deleteBarangMasuk = (id) =>
    api.delete(`/transaksi/masuk/${id}`);


// ==============================
// BARANG KELUAR
// ==============================

export const getBarangKeluar = () =>
    api.get("/transaksi", {
        params: {
            jenis_transaksi: "keluar",
        },
    });

export const createBarangKeluar = (data) =>
    api.post("/transaksi/keluar", data);


// ==============================
// RIWAYAT
// ==============================

export const getRiwayat = () =>
    api.get("/transaksi");

export const getLaporan = (params = {}) =>
    api.get("/laporan", { params });
