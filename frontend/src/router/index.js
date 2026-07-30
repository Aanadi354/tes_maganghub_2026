import { createRouter, createWebHistory } from "vue-router";

import Login from "@/views/auth/Login.vue";

import DashboardLayout from "@/layouts/DashboardLayout.vue";

import Dashboard from "@/views/dashboard/Dashboard.vue";
import ItemView from "@/views/items/ItemView.vue";

import BarangMasuk from "@/views/transaksi/BarangMasuk.vue";
import BarangKeluar from "@/views/transaksi/BarangKeluar.vue";
import Laporan from "@/views/transaksi/Laporan.vue";

const routes = [
  {
    path: "/",
    redirect: "/dashboard",
  },

  {
    path: "/login",
    component: Login,
    meta: {
      guest: true,
    },
  },

  {
    path: "/",
    component: DashboardLayout,
    meta: {
      requiresAuth: true,
    },

    children: [
      {
        path: "dashboard",
        component: Dashboard,
      },

      {
        path: "items",
        component: ItemView,
      },

      {
        path: "barang-masuk",
        component: BarangMasuk,
      },

      {
        path: "barang-keluar",
        component: BarangKeluar,
      },

      {
        path: "laporan",
        component: Laporan,
      },
    ],
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to) => {
  const token = localStorage.getItem("token");

  if (to.meta.requiresAuth && !token) {
    return "/login";
  }

  if (to.meta.guest && token) {
    return "/dashboard";
  }

  return true;
});

export default router;