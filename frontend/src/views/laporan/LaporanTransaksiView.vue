<template>
  <div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h3 class="fw-bold mb-1">Laporan Transaksi</h3>
        <p class="text-muted mb-0">Riwayat transaksi barang masuk dan keluar.</p>
      </div>
    </div>

    <div class="card shadow-sm mb-4">
      <div class="card-body">
        <div class="row g-3 align-items-end">
          <div class="col-md-2">
            <label class="form-label">Jenis</label>
            <select v-model="filter.jenis_transaksi" class="form-select">
              <option value="">Semua</option>
              <option value="masuk">Masuk</option>
              <option value="keluar">Keluar</option>
            </select>
          </div>

          <div class="col-md-2">
            <label class="form-label">Tanggal Awal</label>
            <input v-model="filter.tanggal_awal" type="date" class="form-control" />
          </div>

          <div class="col-md-2">
            <label class="form-label">Tanggal Akhir</label>
            <input v-model="filter.tanggal_akhir" type="date" class="form-control" />
          </div>

          <div class="col-md-3">
            <label class="form-label">Cari Barang</label>
            <input
              v-model="filter.keyword"
              type="text"
              class="form-control"
              placeholder="Kode / Nama Barang"
            />
          </div>

          <div class="col-md-3 d-flex gap-2">
            <button class="btn btn-primary w-100" @click="loadData">Filter</button>
            <button class="btn btn-secondary w-100" @click="resetFilter">Reset</button>
          </div>
        </div>
      </div>
    </div>

    <div class="d-flex justify-content-end mb-3 gap-2">
      <button class="btn btn-danger" @click="downloadPDF" title="Unduh PDF">
        <i class="bi bi-file-earmark-pdf-fill"> PDF</i>
      </button>

      <button class="btn btn-success" @click="downloadExcel" title="Unduh Excel">
        <i class="bi bi-file-earmark-excel-fill"> Excel</i>
      </button>
    </div>

    <div class="card shadow-sm">
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-bordered table-striped mb-0">
            <thead class="table-dark">
              <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Kode Transaksi</th>
                <th>Kode Barang</th>
                <th>Nama Barang</th>
                <th>Jenis</th>
                <th>Jumlah</th>
                <th>Keterangan</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="(item, index) in filteredItems" :key="item.id ?? index">
                <td>{{ index + 1 }}</td>
                <td>{{ formatTanggal(item.tanggal_transaksi) }}</td>
                <td>{{ item.kode_transaksi }}</td>
                <td>{{ item.item?.kode_barang }}</td>
                <td>{{ item.item?.nama_barang }}</td>
                <td>
                  <span v-if="item.jenis_transaksi === 'masuk'" class="badge bg-success">
                    Masuk
                  </span>
                  <span v-else class="badge bg-danger">Keluar</span>
                </td>
                <td>{{ item.jumlah }}</td>
                <td>{{ item.keterangan || "-" }}</td>
              </tr>

              <tr v-if="filteredItems.length === 0">
                <td colspan="8" class="text-center">Tidak ada data.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { getLaporan } from "@/services/transaksiService";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";

const items = ref([]);

const filter = ref({
  jenis_transaksi: "",
  tanggal_awal: "",
  tanggal_akhir: "",
  keyword: "",
});

const buildParams = () => {
  const params = {};

  if (filter.value.jenis_transaksi) {
    params.jenis_transaksi = filter.value.jenis_transaksi;
  }

  if (filter.value.tanggal_awal) {
    params.tanggal_awal = filter.value.tanggal_awal;
  }

  if (filter.value.tanggal_akhir) {
    params.tanggal_akhir = filter.value.tanggal_akhir;
  }

  if (filter.value.keyword) {
    params.keyword = filter.value.keyword;
  }

  return params;
};

const loadData = async () => {
  try {
    const res = await getLaporan(buildParams());
    items.value = Array.isArray(res.data?.data) ? res.data.data : [];
  } catch (err) {
    console.error(err);
    items.value = [];
  }
};

const resetFilter = () => {
  filter.value = {
    jenis_transaksi: "",
    tanggal_awal: "",
    tanggal_akhir: "",
    keyword: "",
  };

  loadData();
};

const filteredItems = computed(() => {
  const keyword = (filter.value.keyword || "").toLowerCase();

  return items.value.filter((item) => {
    const matchesType =
      !filter.value.jenis_transaksi || item.jenis_transaksi === filter.value.jenis_transaksi;

    const matchesKeyword =
      !keyword ||
      [item.item?.kode_barang, item.item?.nama_barang, item.kode_transaksi]
        .join(" ")
        .toLowerCase()
        .includes(keyword);

    const itemDate = item.tanggal_transaksi ? new Date(item.tanggal_transaksi) : null;
    const startDate = filter.value.tanggal_awal ? new Date(`${filter.value.tanggal_awal}T00:00:00`) : null;
    const endDate = filter.value.tanggal_akhir ? new Date(`${filter.value.tanggal_akhir}T23:59:59`) : null;

    let matchesDate = true;

    if (startDate && itemDate && itemDate < startDate) {
      matchesDate = false;
    }

    if (endDate && itemDate && itemDate > endDate) {
      matchesDate = false;
    }

    return matchesType && matchesKeyword && matchesDate;
  });
});

const formatTanggal = (tanggal) => {
  if (!tanggal) return "-";
  return new Date(tanggal).toLocaleDateString("id-ID", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

const downloadPDF = () => {
  const doc = new jsPDF("landscape");
  doc.setFontSize(16);
  doc.text("Laporan Transaksi", 14, 15);

  autoTable(doc, {
    startY: 25,
    head: [
      [
        "No",
        "Tanggal",
        "Kode Transaksi",
        "Kode Barang",
        "Nama Barang",
        "Jenis",
        "Jumlah",
        "Keterangan",
      ],
    ],
    body: filteredItems.value.map((item, index) => [
      index + 1,
      formatTanggal(item.tanggal_transaksi),
      item.kode_transaksi,
      item.item?.kode_barang,
      item.item?.nama_barang,
      item.jenis_transaksi === "masuk" ? "Masuk" : "Keluar",
      item.jumlah,
      item.keterangan ?? "-",
    ]),
  });

  doc.save("laporan-transaksi.pdf");
};

const downloadExcel = () => {
  const headers = [
    "No",
    "Tanggal",
    "Kode Transaksi",
    "Kode Barang",
    "Nama Barang",
    "Jenis",
    "Jumlah",
    "Keterangan",
  ];

  const rows = filteredItems.value.map((item, index) => [
    index + 1,
    formatTanggal(item.tanggal_transaksi),
    item.kode_transaksi,
    item.item?.kode_barang,
    item.item?.nama_barang,
    item.jenis_transaksi === "masuk" ? "Masuk" : "Keluar",
    item.jumlah,
    item.keterangan ?? "-",
  ]);

  const csvContent = [
    headers.join(","),
    ...rows.map((row) => row.join(",")),
  ].join("\n");

  const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
  const link = document.createElement("a");
  link.href = URL.createObjectURL(blob);
  link.setAttribute("download", "laporan-transaksi.csv");
  link.click();
};

onMounted(() => {
  loadData();
});
</script>