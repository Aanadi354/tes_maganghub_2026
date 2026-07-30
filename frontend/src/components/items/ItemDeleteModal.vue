<template>

<div
    class="modal fade"
    id="deleteModal"
    tabindex="-1"
    ref="modalRef"
>

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content">

            <div class="modal-header">

                <h5 class="modal-title">
                    Hapus Barang
                </h5>

                <button
                    class="btn-close"
                    data-bs-dismiss="modal"
                ></button>

            </div>

            <div class="modal-body">

                Apakah yakin ingin menghapus

                <strong>{{ item?.nama_barang }}</strong> ?

            </div>

            <div class="modal-footer">

                <button
                    class="btn btn-secondary"
                    data-bs-dismiss="modal"
                >
                    Batal
                </button>

                <button
                    class="btn btn-danger"
                    @click="remove"
                >
                    Hapus
                </button>

            </div>

        </div>

    </div>

</div>

</template>

<script setup>
import { ref,onMounted } from "vue";
import * as bootstrap from "bootstrap";

import { deleteItem } from "@/services/itemService";

const props = defineProps({

    item:Object

});

const emit = defineEmits([

    "deleted"

]);

const modalRef = ref();

let modal;

const open = () => {

    modal.show();

}

defineExpose({

    open

});

const remove = async () => {

    try {

        console.log("DELETE CLICKED");

        await deleteItem(props.item.id);

        modal.hide();

        emit("deleted");

        console.log("EMIT DELETED");

    } catch (err) {

        console.log(err.response?.data || err);

    }

}

onMounted(()=>{

    modal = new bootstrap.Modal(modalRef.value);

})
</script>