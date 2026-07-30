<template>
  <nav class="navbar navbar-expand-lg navbar-light custom-navbar">

    <div class="container-fluid">

      <!-- Judul Halaman -->
      <div>
        <h5 class="mb-0 fw-bold">
          Inventory Management System
        </h5>

        <small class="text-muted">
          Selamat datang kembali
        </small>
      </div>

      <!-- User -->
      <div class="ms-auto d-flex align-items-center">

        <div class="user-info me-3">

          <div class="avatar">
            {{ user?.name?.charAt(0).toUpperCase() }}
          </div>

          <div class="ms-2">
            <div class="fw-semibold">
              {{ user?.name }}
            </div>

            <small class="text-muted">
              Administrator
            </small>
          </div>

        </div>

        <button
          class="btn btn-light logout-btn"
          @click="logout"
        >
          <i class="bi bi-box-arrow-right"></i>
        </button>

      </div>

    </div>

  </nav>
</template>

<script setup>
import { useRouter } from "vue-router";
import { logout as logoutApi } from "@/services/authService";

const router = useRouter();

const user = JSON.parse(localStorage.getItem("user"));

const logout = async () => {
  try {
    await logoutApi();
  } catch (e) {}

  localStorage.removeItem("token");
  localStorage.removeItem("user");

  router.push("/login");
};
</script>

<style scoped>

.custom-navbar{
    background:#fff;
    height:72px;
    padding:0 24px;
    border-bottom:1px solid #e5e7eb;
    box-shadow:0 2px 10px rgba(0,0,0,.05);
}

.user-info{
    display:flex;
    align-items:center;
}

.avatar{
    width:42px;
    height:42px;
    border-radius:50%;
    background:#2563eb;
    color:#fff;

    display:flex;
    justify-content:center;
    align-items:center;

    font-weight:700;
    font-size:18px;
}

.logout-btn{
    width:42px;
    height:42px;
    border-radius:50%;
    border:1px solid #dee2e6;

    display:flex;
    justify-content:center;
    align-items:center;

    transition:.25s;
}

.logout-btn:hover{
    background:#dc3545;
    color:#fff;
    border-color:#dc3545;
}

.logout-btn i{
    font-size:18px;
}

</style>