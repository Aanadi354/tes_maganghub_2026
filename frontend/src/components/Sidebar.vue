<template>
  <aside class="sidebar bg-dark text-white">

    <h5 class="mb-4">
      Menu
    </h5>

    <RouterLink
      class="menu-item"
      to="/dashboard"
    >
      Dashboard
    </RouterLink>

    <RouterLink
      class="menu-item"
      to="/items"
    >
      Master Barang
    </RouterLink>

    <RouterLink
      class="menu-item"
      to="/barang-masuk"
    >
      Barang Masuk
    </RouterLink>

    <RouterLink
      class="menu-item"
      to="/barang-keluar"
    >
      Barang Keluar
    </RouterLink>

    <RouterLink
      class="menu-item"
      to="/laporan"
    >
      Laporan
    </RouterLink>

  </aside>
</template>

<style scoped>
.sidebar{
    width:250px;
    min-height:100vh;
    padding:20px;
}

.menu-item{
    display:block;
    padding:12px;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin-bottom:8px;
}

.menu-item:hover{
    background:#0d6efd;
}

.router-link-active{
    background:#0d6efd;
}
</style>