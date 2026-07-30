<template>

<div
class="modal fade"
id="itemModal"
tabindex="-1"
ref="modalRef"
>

<div class="modal-dialog">

<div class="modal-content">

<div class="modal-header">

<h5 class="modal-title">

{{ isEdit ? "Edit Barang" : "Tambah Barang" }}

</h5>

<button
class="btn-close"
data-bs-dismiss="modal"
></button>

</div>

<div class="modal-body">

<div class="mb-3">

<label>Kode Barang</label>

<input
v-model="form.kode_barang"
class="form-control"
/>

</div>

<div class="mb-3">

<label>Nama Barang</label>

<input
v-model="form.nama_barang"
class="form-control"
/>

</div>

<div class="mb-3">

<label>Satuan</label>

<input
v-model="form.satuan"
class="form-control"
/>

</div>

<div class="mb-3">

<label>Harga</label>

<input
type="number"
v-model.number="form.harga_satuan"
class="form-control"
/>

</div>

<div class="mb-3">

<label>Stock</label>

<input
type="number"
v-model.number="form.stock_awal"
class="form-control"
/>

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

import {
createItem,
updateItem
} from "@/services/itemService";

const emit = defineEmits(["saved"]);

const modalRef = ref(null);

let modal = null;

const isEdit = ref(false);

const form = reactive({

id:null,
kode_barang:"",
nama_barang:"",
satuan:"",
harga_satuan:null,
stock_awal:null,

});

const resetForm=()=>{

form.id=null;
form.kode_barang="";
form.nama_barang="";
form.satuan="";
form.harga_satuan=null;
form.stock_awal=null;

}

const open=(item=null)=>{

resetForm();

if(item){

isEdit.value=true;

Object.assign(form,item);

}else{

isEdit.value=false;

}

modal.show();

}

defineExpose({

open

});

const save=async()=>{

try{

if(isEdit.value){

await updateItem(form.id,form);

}else{

await createItem(form);

}

emit("saved");

modal.hide();

}catch(err){

console.log(err.response?.data);

}

}

onMounted(()=>{

modal=new bootstrap.Modal(modalRef.value);

})

</script>