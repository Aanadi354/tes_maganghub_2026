<template>
  <div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h3 class="fw-bold mb-1">Laporan Stok</h3>
        <p class="text-muted mb-0">Informasi stok barang yang tersedia.</p>
      </div>
    </div>

    <div class="card shadow-sm mb-4">
      <div class="card-body">
        <div class="row g-3 align-items-end">
          <div class="col-md-5">
            <label class="form-label">Cari Barang</label>
            <input
              v-model="keyword"
              type="text"
              class="form-control"
              placeholder="Kode / Nama Barang"
            />
          </div>

          <div class="col-md-2">
            <button class="btn btn-primary w-100" @click="loadData">
              Filter
            </button>
          </div>

          <div class="col-md-2">
            <button class="btn btn-secondary w-100" @click="resetFilter">
              Reset
            </button>
          </div>

          <div class="col-md-1">
            <button
                class="btn btn-danger btn-icon w-100"
                @click="downloadPDF"
                title="Unduh PDF"
            >
                <i class="bi bi-file-earmark-pdf-fill"> PDF</i>
            </button>
            </div>

            <div class="col-md-1">
            <button
                class="btn btn-success btn-icon w-100"
                @click="downloadExcel"
                title="Unduh Excel"
            >
                <i class="bi bi-file-earmark-excel-fill"> Excel</i>
            </button>
            </div>
        </div>
      </div>
    </div>

    <div class="card shadow-sm">
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-bordered table-striped mb-0">
            <thead class="table-dark">
              <tr>
                <th>No</th>
                <th>Kode Barang</th>
                <th>Nama Barang</th>
                <th>Satuan</th>
                <th>Harga</th>
                <th>Stok Akhir</th>
                <th>Nilai</th>
              </tr>
            </thead>

            <tbody>
              <tr v-for="(item, index) in filteredItems" :key="item.id ?? index">
                <td>{{ index + 1 }}</td>
                <td>{{ item.kode_barang }}</td>
                <td>{{ item.nama_barang }}</td>
                <td>{{ item.satuan }}</td>
                <td>{{ formatRupiah(item.harga_satuan) }}</td>
                <td>{{ item.stock_awal ?? 0 }}</td>
                <td>{{ formatRupiah((item.stock_awal ?? 0) * (item.harga_satuan ?? 0)) }}</td>
              </tr>

              <tr v-if="filteredItems.length === 0">
                <td colspan="7" class="text-center">Tidak ada data.</td>
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
import { getItems } from "@/services/itemService";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";

const items = ref([]);
const keyword = ref("");

const loadData = async () => {
  try {
    const res = await getItems();
    items.value = res.data?.data?.data ?? res.data?.data ?? [];
  } catch (err) {
    console.error(err);
    items.value = [];
  }
};

const filteredItems = computed(() => {
  const key = keyword.value.toLowerCase();

  if (!key) return items.value;

  return items.value.filter((item) => {
    const text = `${item.kode_barang ?? ""} ${item.nama_barang ?? ""}`.toLowerCase();
    return text.includes(key);
  });
});

const resetFilter = () => {
  keyword.value = "";
  loadData();
};

const formatRupiah = (angka) => {
  return new Intl.NumberFormat("id-ID", {
    style: "currency",
    currency: "IDR",
  }).format(angka || 0);
};

const downloadPDF = () => {
  const doc = new jsPDF("landscape");
  doc.setFontSize(16);
  doc.text("Laporan Stok", 14, 15);

  autoTable(doc, {
    startY: 25,
    head: [["No", "Kode Barang", "Nama Barang", "Satuan", "Harga", "Stok Akhir", "Nilai"]],
    body: filteredItems.value.map((item, index) => [
      index + 1,
      item.kode_barang,
      item.nama_barang,
      item.satuan,
      formatRupiah(item.harga_satuan),
      item.stock_awal ?? 0,
      formatRupiah((item.stock_awal ?? 0) * (item.harga_satuan ?? 0)),
    ]),
  });

  doc.save("laporan-stok.pdf");
};

const downloadExcel = () => {
  const headers = ["No", "Kode Barang", "Nama Barang", "Satuan", "Harga", "Stok Akhir", "Nilai"];
  const rows = filteredItems.value.map((item, index) => [
    index + 1,
    item.kode_barang,
    item.nama_barang,
    item.satuan,
    item.harga_satuan ?? 0,
    item.stock_awal ?? 0,
    (item.stock_awal ?? 0) * (item.harga_satuan ?? 0),
  ]);

  const csvContent = [
    headers.join(","),
    ...rows.map((row) => row.join(",")),
  ].join("\n");

  const blob = new Blob([csvContent], { type: "text/csv;charset=utf-8;" });
  const link = document.createElement("a");
  link.href = URL.createObjectURL(blob);
  link.setAttribute("download", "laporan-stok.csv");
  link.click();
};

onMounted(() => {
  loadData();
});
</script>