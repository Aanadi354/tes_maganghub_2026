export const getLaporanStok = () =>
    api.get("/laporan/stok");

export const getLaporanTransaksi = (params) =>
    api.get("/laporan/transaksi", { params });