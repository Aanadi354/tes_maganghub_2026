<template>

<table class="table table-bordered">

<thead class="table-dark">

<tr>

<th>No</th>

<th>Kode</th>

<th>Nama</th>

<th>Satuan</th>

<th>Harga</th>

<th>Stock</th>

<th>Aksi</th>

</tr>

</thead>

<tbody>

<tr
v-for="(item,index) in items"
:key="item.id"
>

<td>{{ index+1 }}</td>

<td>{{ item.kode_barang }}</td>

<td>{{ item.nama_barang }}</td>

<td>{{ item.satuan }}</td>

<td>{{ formatRupiah(item.harga_satuan) }}</td>

<td>{{ item.stock_awal }}</td>

<td>

<button
class="btn btn-warning btn-sm me-2"
@click="$emit('edit',item)"
>

Edit

</button>

<button
    class="btn btn-danger btn-sm"
    @click="() => {
        console.log('Klik Delete', item);
        $emit('delete', item);
    }"
>
    Delete
</button>

</td>

</tr>

</tbody>

</table>

</template>

<script setup>

defineProps({

items:Array

})

defineEmits([

"edit",

"delete"

])

const formatRupiah=(angka)=>{

return new Intl.NumberFormat("id-ID",{

style:"currency",

currency:"IDR"

}).format(angka)

}

</script>