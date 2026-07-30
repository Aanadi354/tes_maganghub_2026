<template>
    <div class="container-fluid">

        <div class="d-flex justify-content-between align-items-center mb-4">

            <h2>Master Barang</h2>

            <button
                class="btn btn-primary"
                @click="openCreate"
            >
                + Tambah Barang
            </button>

        </div>

        <ItemTable
            :items="items"
            @edit="openEdit"
            @delete="openDelete"
        />

        <ItemFormModal
            ref="formModal"
            @saved="loadData"
        />

        <ItemDeleteModal
            ref="deleteModal"
            :item="selectedItem"
            @deleted="loadData"
        />

    </div>
</template>

<script setup>
import { ref,onMounted } from "vue";

import ItemTable from "@/components/items/ItemTable.vue";
import ItemFormModal from "@/components/items/ItemFormModal.vue";
import ItemDeleteModal from "@/components/items/ItemDeleteModal.vue";

import { getItems } from "@/services/itemService";

const items = ref([]);

const formModal = ref(null);
const deleteModal = ref(null);
const selectedItem = ref(null);

const loadData = async()=>{

    const response = await getItems();

    items.value = response.data.data.data;

}

const openCreate=()=>{

    formModal.value.open();

}

const openEdit=(item)=>{

    formModal.value.open(item);

}

// const showDeleteModal = ref(false);
// const openDelete = (item) => {

//     selectedItem.value = item;

//     showDeleteModal.value = true;

// }

// const closeDelete = () => {

//     showDeleteModal.value = false;

// }

// const handleDeleted = async () => {

//     await loadData();

//     closeDelete();

// }


const openDelete = (item) => {
    console.log("openDelete");

    selectedItem.value = item;

    console.log(deleteModal.value);

    deleteModal.value?.open();
}
onMounted(loadData);
</script>