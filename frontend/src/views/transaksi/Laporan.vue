<template>
    <div class="container-fluid">

        <h2 class="mb-4">
            Laporan Transaksi Barang
        </h2>

        <div class="card shadow-sm mb-4">

            <div class="card-body">

                <div class="row">

                    <div class="col-md-3">

                        <label class="form-label">
                            Tanggal Awal
                        </label>

                        <input
                            type="date"
                            class="form-control"
                            v-model="filter.tanggal_awal"
                        >

                    </div>

                    <div class="col-md-3">

                        <label class="form-label">
                            Tanggal Akhir
                        </label>

                        <input
                            type="date"
                            class="form-control"
                            v-model="filter.tanggal_akhir"
                        >

                    </div>

                    <div class="col-md-4">

                        <label class="form-label">
                            Cari Barang
                        </label>

                        <input
                            type="text"
                            class="form-control"
                            placeholder="Kode / Nama Barang"
                            v-model="filter.keyword"
                        >

                    </div>

                    <div class="col-md-3 d-flex align-items-end">
                        <button
                            class="btn btn-primary me-2"
                            @click="loadData"
                        >
                            Filter
                        </button>

                        <button
                            class="btn btn-secondary me-2"
                            @click="resetFilter"
                        >
                            Reset
                        </button>

                        <button
                            class="btn btn-danger"
                            @click="exportPDF"
                        >
                            Export PDF
                        </button>

                    </div>
                </div>

            </div>

        </div>

        <LaporanTable
            :items="items"
        />

    </div>
</template>

<script setup>

import { ref, onMounted } from "vue";
import LaporanTable from "@/components/transaksi/laporan/LaporanTable.vue";
import { getLaporan } from "@/services/transaksiService";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";

const items = ref([]);

const filter = ref({

    tanggal_awal: "",

    tanggal_akhir: "",

    keyword: ""

});

const loadData = async () => {

    try {

        const res = await getLaporan(filter.value);

        items.value = res.data.data;

    } catch (err) {

        console.log(err);

    }

};

const resetFilter = () => {

    filter.value = {

        tanggal_awal: "",

        tanggal_akhir: "",

        keyword: ""

    };

    loadData();

};
const exportPDF = () => {

    const doc = new jsPDF("landscape");

    doc.setFontSize(16);

    doc.text("Laporan Transaksi Barang", 14, 15);

    autoTable(doc, {

        startY: 25,

        head: [[
            "No",
            "Tanggal",
            "Kode Transaksi",
            "Kode Barang",
            "Nama Barang",
            "Jenis",
            "Jumlah",
            "Keterangan"
        ]],

        body: items.value.map((item, index) => [

            index + 1,

            formatTanggal(item.tanggal_transaksi),

            item.kode_transaksi,

            item.item?.kode_barang,

            item.item?.nama_barang,

            item.jenis_transaksi,

            item.jumlah,

            item.keterangan ?? "-"

        ])

    });

    doc.save("laporan-transaksi.pdf");

};
const formatTanggal = (tanggal) => {

    return new Date(tanggal).toLocaleDateString("id-ID", {

        day: "2-digit",

        month: "2-digit",

        year: "numeric"

    });

};

onMounted(() => {

    loadData();

});

</script>