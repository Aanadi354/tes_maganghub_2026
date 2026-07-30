<script setup>
import { ref } from "vue";

const laporanOpen = ref(false);
</script>
<template>
  <aside class="sidebar">

    <!-- Logo -->
    <div class="sidebar-header">
      <div class="logo">
        <i class="bi bi-box-seam"></i>
      </div>

      <div>
        <h5 class="mb-0">Inventory</h5>
        <small>Management System</small>
      </div>
    </div>

    <!-- Menu -->
    <nav class="mt-4">

      <RouterLink
        to="/dashboard"
        class="menu-item"
      >
        <i class="bi bi-grid-1x2-fill"></i>
        <span>Dashboard</span>
      </RouterLink>

      <RouterLink
        to="/items"
        class="menu-item"
      >
        <i class="bi bi-box-seam"></i>
        <span>Master Barang</span>
      </RouterLink>

      <RouterLink
        to="/barang-masuk"
        class="menu-item"
      >
        <i class="bi bi-arrow-down-circle"></i>
        <span>Barang Masuk</span>
      </RouterLink>

      <RouterLink
        to="/barang-keluar"
        class="menu-item"
      >
        <i class="bi bi-arrow-up-circle"></i>
        <span>Barang Keluar</span>
      </RouterLink>

      <!-- Laporan -->
      <div
        class="menu-item menu-parent"
        @click="laporanOpen = !laporanOpen"
      >
        <div class="menu-left">
          <i class="bi bi-file-earmark-bar-graph"></i>
          <span>Laporan</span>
        </div>

        <i
          class="bi"
          :class="laporanOpen ? 'bi-chevron-up' : 'bi-chevron-down'"
        ></i>
      </div>

      <div
        v-show="laporanOpen"
        class="submenu"
      >
        <RouterLink
          to="/laporan/stok"
          class="submenu-item"
        >
          <i class="bi bi-boxes"></i>
          <span>Laporan Stok</span>
        </RouterLink>

        <RouterLink
          to="/laporan/transaksi"
          class="submenu-item"
        >
          <i class="bi bi-receipt"></i>
          <span>Laporan Transaksi</span>
        </RouterLink>
      </div>

    </nav>

  </aside>
</template>

<style scoped>

.sidebar{
    width:260px;
    min-height:100vh;
    background:#1f2937;
    color:white;
    padding:24px 18px;
    border-right:1px solid rgba(255,255,255,.08);
}

/* Header */

.sidebar-header{
    display:flex;
    align-items:center;
    gap:14px;
    padding-bottom:22px;
    border-bottom:1px solid rgba(255,255,255,.08);
}

.logo{
    width:48px;
    height:48px;
    border-radius:12px;
    background:#2563eb;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:22px;
}

.sidebar-header h5{
    font-weight:700;
    color:white;
}

.sidebar-header small{
    color:#9ca3af;
}

/* Menu */

.menu-item{
    display:flex;
    align-items:center;
    gap:14px;

    color:#d1d5db;
    text-decoration:none;

    padding:13px 15px;
    margin-bottom:8px;

    border-radius:12px;

    transition:.25s;
}
.menu-parent{
    justify-content:space-between;
    cursor:pointer;
}

.menu-left{
    display:flex;
    align-items:center;
    gap:14px;
}

.submenu{
    margin-left:20px;
    padding-left:12px;
    border-left:1px solid rgba(255,255,255,.12);
    margin-bottom:8px;
}

.submenu-item{
    display:flex;
    align-items:center;
    gap:12px;
    padding:10px 12px;
    margin:4px 0;
    color:#d1d5db;
    text-decoration:none;
    border-radius:10px;
    transition:.25s;
}

.submenu-item:hover{
    background:#374151;
    color:#fff;
    transform:translateX(4px);
}

.submenu .router-link-active{
    background:#2563eb;
    color:#fff;
    font-weight:600;
    box-shadow:0 8px 18px rgba(37,99,235,.30);
}
.menu-item i{
    font-size:18px;
    width:22px;
    text-align:center;
}

.menu-item:hover{
    background:#374151;
    color:#fff;
    transform:translateX(4px);
}

/* Active */

.router-link-active{
    background:#2563eb;
    color:#fff;
    font-weight:600;
    box-shadow:0 8px 18px rgba(37,99,235,.30);
}

</style>