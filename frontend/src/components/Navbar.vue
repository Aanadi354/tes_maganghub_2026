<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container-fluid">

      <span class="navbar-brand fw-bold">
        Inventory Management System
      </span>

      <div class="ms-auto d-flex align-items-center">

        <span class="text-white me-3">
          {{ user?.name }}
        </span>

        <button
          class="btn btn-outline-light btn-sm"
          @click="logout"
        >
          Logout
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