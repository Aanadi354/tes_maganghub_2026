<template>
    <div
        class="modal fade"
        tabindex="-1"
        ref="modalRef"
    >

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header">

                    <h5 class="modal-title">
                        Tambah Barang Keluar
                    </h5>

                    <button
                        class="btn-close"
                        data-bs-dismiss="modal"
                    ></button>

                </div>

                <div class="modal-body">

                    <div v-if="errorMessage" class="alert alert-danger">
                        {{ errorMessage }}
                    </div>

                    <div class="mb-3">

                        <label>Barang</label>

                        <select
                            class="form-select"
                            v-model="form.item_id"
                        >

                            <option value="">
                                -- Pilih Barang --
                            </option>

                            <option
                                v-for="barang in daftarBarang"
                                :key="barang.id"
                                :value="barang.id"
                            >
                                {{ barang.kode_barang }} - {{ barang.nama_barang }} (Stok: {{ barang.stock_awal ?? 0 }})
                            </option>

                        </select>

                    </div>

                    <div class="mb-3">

                        <label>Tanggal</label>

                        <input
                            type="date"
                            class="form-control"
                            v-model="form.tanggal_transaksi"
                        >

                    </div>

                    <div class="mb-3">
                        <label>Jumlah Barang Keluar</label>

                        <input
                            type="number"
                            class="form-control"
                            v-model.number="form.jumlah"
                        >
                    </div>
                    
                    <div class="mb-3">
                        <label>Keterangan</label>

                        <textarea
                            class="form-control"
                            rows="3"
                            v-model="form.keterangan"
                        ></textarea>

                    </div>

                </div>

                <div class="modal-footer">

                    <button
                        class="btn btn-secondary"
                        data-bs-dismiss="modal"
                    >
                        Batal
                    </button>

                    <button
                        class="btn btn-primary"
                        @click="save"
                    >
                        Simpan
                    </button>

                </div>

            </div>

        </div>

    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from "vue";
import * as bootstrap from "bootstrap";

import { createBarangKeluar } from "@/services/transaksiService";
import { getItems } from "@/services/itemService";

const emit = defineEmits(["saved"]);

const modalRef = ref();
let modal = null;

const daftarBarang = ref([]);
const errorMessage = ref("");

const form = reactive({
    item_id: "",
    tanggal_transaksi: "",
    jumlah: null,
    keterangan: "",
});

const resetForm = () => {
    form.item_id = "";
    form.tanggal_transaksi = "";
    form.jumlah = null;
    form.keterangan = "";
    errorMessage.value = "";
};

const loadBarang = async () => {
    try {
        const res = await getItems();
        daftarBarang.value = res.data?.data?.data ?? res.data?.data ?? [];
    } catch (err) {
        console.log(err);
        daftarBarang.value = [];
    }
};

const open = async () => {
    resetForm();
    await loadBarang();
    modal.show();
};

defineExpose({
    open
});

const save = async () => {
    errorMessage.value = "";

    if (!form.item_id) {
        errorMessage.value = "Silakan pilih barang terlebih dahulu.";
        return;
    }

    if (!form.jumlah || Number(form.jumlah) <= 0) {
        errorMessage.value = "Jumlah barang keluar harus lebih dari 0.";
        return;
    }
    if (!form.tanggal_transaksi) {
        errorMessage.value = "Tanggal transaksi wajib dipilih.";
        return;
    }
    if (!form.tanggal_transaksi) {
        errorMessage.value = "Tanggal transaksi wajib dipilih.";
        return;
    }

    const selectedBarang = daftarBarang.value.find((item) => item.id === Number(form.item_id));

    if (!selectedBarang) {
        errorMessage.value = "Barang tidak ditemukan.";
        return;
    }

    const stokSaatIni = Number(selectedBarang.stock_awal ?? 0);

    if (Number(form.jumlah) > stokSaatIni) {
        errorMessage.value = `Stok ${selectedBarang.nama_barang} tidak mencukupi. Stok tersedia: ${stokSaatIni}`;
        return;
    }

    try {
        await createBarangKeluar(form);

        emit("saved");
        modal.hide();
    } catch (err) {
        console.log(err.response?.data);
        errorMessage.value = "Gagal menyimpan transaksi barang keluar.";
    }
};

onMounted(() => {
    modal = new bootstrap.Modal(modalRef.value);
});
</script>