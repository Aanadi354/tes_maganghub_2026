<template>

<table class="table table-bordered table-striped">

    <thead class="table-dark">

        <tr>

            <th>No</th>

            <th>Tanggal</th>

            <th>Kode Transaksi</th>

            <th>Kode Barang</th>

            <th>Nama Barang</th>

            <th>Jenis</th>

            <th>Jumlah</th>

            <th>Keterangan</th>

        </tr>

    </thead>

    <tbody>

        <tr
            v-for="(item,index) in items"
            :key="item.id"
        >

            <td>{{ index+1 }}</td>

            <td>{{ formatTanggal(item.tanggal_transaksi) }}</td>

            <td>{{ item.kode_transaksi }}</td>

            <td>{{ item.item?.kode_barang }}</td>

            <td>{{ item.item?.nama_barang }}</td>

            <td>

                <span
                    v-if="item.jenis_transaksi=='masuk'"
                    class="badge bg-success"
                >
                    Masuk
                </span>

                <span
                    v-else
                    class="badge bg-danger"
                >
                    Keluar
                </span>

            </td>

            <td>{{ item.jumlah }}</td>

            <td>{{ item.keterangan || '-' }}</td>

        </tr>

        <tr v-if="items.length==0">

            <td
                colspan="8"
                class="text-center"
            >
                Tidak ada data.

            </td>

        </tr>

    </tbody>

</table>

</template>

<script setup>

defineProps({

    items:{
        type:Array,
        default:()=>[]
    }

})

const formatTanggal=(tanggal)=>{

    return new Date(tanggal).toLocaleDateString("id-ID",{

        day:"2-digit",

        month:"2-digit",

        year:"numeric"

    })

}

</script>