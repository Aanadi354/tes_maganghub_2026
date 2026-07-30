<script setup>
import { ref, onMounted } from "vue";

import BarangKeluarTable from "@/components/transaksi/barangKeluar/BarangKeluarTable.vue";
import BarangKeluarFormModal from "@/components/transaksi/barangKeluar/BarangKeluarFormModal.vue";

import { getBarangKeluar } from "@/services/transaksiService";

const items = ref([]);

const formModal = ref(null);

const loadData = async () => {

    const res = await getBarangKeluar();

    items.value = res.data.data.data;

}

const openCreate = () => {
    formModal.value.open();
};

onMounted(loadData);
</script>

<template>
    <div class="container-fluid">

        <div class="d-flex justify-content-between align-items-center mb-4">

            <h2>Barang Keluar</h2>

            <button
                class="btn btn-primary"
                @click="openCreate"
            >
                + Barang Keluar
            </button>

        </div>

        <BarangKeluarTable
            :items="items"
        />

        <BarangKeluarFormModal
            ref="formModal"
            @saved="loadData"
        />

    </div>
</template>