<template>

  <Navbar/>

  <div class="d-flex">

    <Sidebar/>

    <div class="flex-grow-1 p-4 bg-light">

      <router-view/>

    </div>

  </div>

</template>

<script setup>
import Navbar from "@/components/Navbar.vue";
import Sidebar from "@/components/Sidebar.vue";
</script>