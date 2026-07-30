<template>
  <div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h2 class="fw-bold mb-1">Dashboard</h2>
        <p class="text-muted mb-0">Ringkasan aktivitas inventaris Anda hari ini.</p>
      </div>
    </div>

    <div class="row g-4 mb-4">
      <div class="col-md-3">
        <div class="card shadow-sm border-0 rounded-4 bg-primary text-white h-100">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-start">
              <div>
                <p class="mb-1 opacity-75">Total Barang</p>
                <h3 class="fw-bold">{{ totalItems }}</h3>
              </div>
              <i class="bi bi-box-seam fs-3"></i>
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-3">
        <div class="card shadow-sm border-0 rounded-4 bg-success text-white h-100">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-start">
              <div>
                <p class="mb-1 opacity-75">Total Transaksi Barang Masuk</p>
                <h3 class="fw-bold">{{ totalMasuk }} Transaksi</h3>
              </div>
              <i class="bi bi-arrow-down-circle fs-3"></i>
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-3">
        <div class="card shadow-sm border-0 rounded-4 bg-danger text-white h-100">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-start">
              <div>
                <p class="mb-1 opacity-75">Total Transaksi Barang Keluar</p>
                <h3 class="fw-bold">{{ totalKeluar }} Transaksi</h3>
              </div>
              <i class="bi bi-arrow-up-circle fs-3"></i>
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-3">
        <div class="card shadow-sm border-0 rounded-4 bg-warning text-dark h-100">
          <div class="card-body">
            <div class="d-flex justify-content-between align-items-start">
              <div>
                <p class="mb-1 opacity-75">Nilai Stok</p>
                <h3 class="fw-bold">{{ formatRupiah(totalNilaiStok) }}</h3>
              </div>
              <i class="bi bi-cash-coin fs-3"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="row g-4">
      <div class="col-lg-8">
        <div class="card shadow-sm border-0 rounded-4 h-100">
          <div class="card-body">
            <h5 class="fw-bold mb-3">Aktivitas Terbaru</h5>

            <div v-if="recentActivities.length" class="d-flex flex-column gap-3">
              <div
                v-for="activity in recentActivities"
                :key="activity.id"
                class="d-flex align-items-center justify-content-between p-3 rounded-3"
                style="background: #f8fafc;"
              >
                <div>
                  <div class="fw-semibold">{{ activity.namaBarang }}</div>
                  <div class="text-muted small">
                    {{ activity.jenis }} • {{ formatTanggal(activity.tanggal) }}
                  </div>
                </div>

                <span
                  :class="activity.jenis === 'Masuk' ? 'badge bg-success' : 'badge bg-danger'"
                >
                  {{ activity.jenis }}
                </span>
              </div>
            </div>

            <div v-else class="text-muted text-center py-4">
              Belum ada aktivitas.
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-4">
        <div class="card shadow-sm border-0 rounded-4 h-100">
          <div class="card-body">
            <h5 class="fw-bold mb-3">Informasi Singkat</h5>

            <ul class="list-group list-group-flush">
              <li class="list-group-item px-0">
                <strong>Stok Menipis</strong>
                <div class="text-muted small">Pantau barang dengan stok rendah.</div>
              </li>
              <li class="list-group-item px-0">
                <strong>Transaksi Hari Ini</strong>
                <div class="text-muted small">Cek masuk dan keluar barang terbaru.</div>
              </li>
              <li class="list-group-item px-0">
                <strong>Laporkan Keuangan</strong>
                <div class="text-muted small">Lihat nilai stok dari barang yang tersedia.</div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { getItems } from "@/services/itemService";
import { getBarangMasuk, getBarangKeluar } from "@/services/transaksiService";

const totalItems = ref(0);
const totalMasuk = ref(0);
const totalKeluar = ref(0);
const totalNilaiStok = ref(0);
const recentActivities = ref([]);

const formatRupiah = (angka) => {
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
  }).format(angka || 0);
};

const formatTanggal = (tanggal) => {
  if (!tanggal) return "-";
  return new Date(tanggal).toLocaleDateString("id-ID", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

const normalizeArray = (value) => {
  if (Array.isArray(value)) return value;
  if (value && Array.isArray(value.data)) return value.data;
  if (value && value.data && Array.isArray(value.data.data)) return value.data.data;
  return [];
};

const loadDashboardData = async () => {
  try {
    const [itemsRes, masukRes, keluarRes] = await Promise.all([
      getItems(),
      getBarangMasuk(),
      getBarangKeluar(),
    ]);

    const items = normalizeArray(itemsRes.data);
    const masukData = normalizeArray(masukRes.data);
    const keluarData = normalizeArray(keluarRes.data);

    totalItems.value = items.length;
    totalMasuk.value = masukData.length;
    totalKeluar.value = keluarData.length;

    totalNilaiStok.value = items.reduce((sum, item) => {
      return sum + Number(item.stock_awal || 0) * Number(item.harga_satuan || 0);
    }, 0);

    const combined = [
      ...masukData.map((item) => ({ ...item, jenis: "Masuk" })),
      ...keluarData.map((item) => ({ ...item, jenis: "Keluar" })),
    ]
      .sort((a, b) => new Date(b.tanggal_transaksi || 0) - new Date(a.tanggal_transaksi || 0))
      .slice(0, 5);

    recentActivities.value = combined.map((item) => ({
      id: item.id,
      namaBarang: item.item?.nama_barang || "Barang tidak diketahui",
      jenis: item.jenis,
      tanggal: item.tanggal_transaksi,
    }));
  } catch (err) {
    console.error(err);
  }
};

onMounted(() => {
  loadDashboardData();
});
</script>