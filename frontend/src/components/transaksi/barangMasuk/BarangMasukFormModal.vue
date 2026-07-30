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
                        Tambah Barang Masuk
                    </h5>

                    <button
                        class="btn-close"
                        data-bs-dismiss="modal"
                    ></button>

                </div>

                <div class="modal-body">

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
                                {{ barang.kode_barang }} - {{ barang.nama_barang }}
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
                        <label>Jumlah</label>

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

import { createBarangMasuk } from "@/services/transaksiService";
import { getItems } from "@/services/itemService";

const emit = defineEmits(["saved"]);

const modalRef = ref();

let modal = null;

const daftarBarang = ref([]);

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

}

const loadBarang = async () => {

    try {

        const res = await getItems();

        daftarBarang.value = res.data.data.data;

    } catch (err) { 

        console.log(err);

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

    try {

        await createBarangMasuk(form);

        emit("saved");

        modal.hide();

    } catch (err) {

        console.log(err.response?.data);

    }

};

onMounted(() => {

    modal = new bootstrap.Modal(modalRef.value);

});
</script>