<template>

<table class="table table-bordered">

    <thead class="table-dark">

        <tr>
            <th>No</th>
            <th>Tanggal</th>
            <th>Kode Barang</th>
            <th>Nama Barang</th>
            <th>Jumlah</th>
            <th>Keterangan</th>
        </tr>

    </thead>

    <tbody>

        <tr
            v-for="(item,index) in items"
            :key="item.id"
        >

            <td>{{ index + 1 }}</td>

            <td>{{ formatTanggal(item.tanggal_transaksi) }}</td>

            <td>{{ item.item?.kode_barang }}</td>

            <td>{{ item.item?.nama_barang }}</td>

            <td>{{ item.jumlah }}</td>

            <td>{{ item.keterangan || "-" }}</td>

        </tr>

        <tr v-if="items.length === 0">
            <td colspan="6" class="text-center">
                Belum ada data barang masuk.
            </td>
        </tr>

    </tbody>

</table>

</template>

<script setup>

defineProps({
    items: {
        type: Array,
        default: () => []
    }
})

const formatTanggal = (tanggal) => {
    return new Date(tanggal).toLocaleDateString("id-ID", {
        day: "2-digit",
        month: "2-digit",
        year: "numeric"
    });
}

</script>