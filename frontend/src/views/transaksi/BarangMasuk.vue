<script setup>
import { ref, onMounted } from "vue";

import BarangMasukTable from "@/components/transaksi/barangMasuk/BarangMasukTable.vue";
import BarangMasukFormModal from "@/components/transaksi/barangMasuk/BarangMasukFormModal.vue";

import { getBarangMasuk } from "@/services/transaksiService";

const items = ref([]);

const formModal = ref(null);

const loadData = async () => {
    try {
        const res = await getBarangMasuk();
        items.value = res.data.data.data;
    } catch (err) {
        console.error(err);
    }
};

const openCreate = () => {
    formModal.value.open();
};

onMounted(loadData);
</script>

<template>
    <div class="container-fluid">

        <div class="d-flex justify-content-between align-items-center mb-4">

            <h2>Barang Masuk</h2>

            <button
                class="btn btn-primary"
                @click="openCreate"
            >
                + Barang Masuk
            </button>

        </div>

        <BarangMasukTable
            :items="items"
        />

        <BarangMasukFormModal
            ref="formModal"
            @saved="loadData"
        />

    </div>
</template>