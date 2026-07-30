<template>
  <div class="container vh-100 d-flex justify-content-center align-items-center">
    <div class="card shadow" style="width: 400px;">
      <div class="card-body">

        <h3 class="text-center mb-4">
          Inventory System
        </h3>

        <div
          v-if="errorMessage"
          class="alert alert-danger"
        >
          {{ errorMessage }}
        </div>

        <form @submit.prevent="handleLogin">

          <div class="mb-3">
            <label class="form-label">
              Email
            </label>

            <input
              type="email"
              class="form-control"
              v-model="form.email"
              placeholder="Masukkan email"
              required
            >
          </div>

          <div class="mb-3">
            <label class="form-label">
              Password
            </label>

            <div class="input-group">
              <input
                :type="showPassword ? 'text' : 'password'"
                class="form-control"
                v-model="form.password"
                placeholder="Masukkan password"
                required
              >

              <button
                class="btn btn-outline-secondary"
                type="button"
                @click="togglePassword"
              >
                <i
                  class="bi"
                  :class="showPassword ? 'bi-eye-slash' : 'bi-eye'"
                ></i>
              </button>
            </div>
          </div>

          <button
            class="btn btn-primary w-100"
            type="submit"
            :disabled="loading"
          >
            {{ loading ? "Loading..." : "Login" }}
          </button>

        </form>

      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import { useRouter } from "vue-router";
import { login } from "@/services/authService";

const router = useRouter();

const form = reactive({
  email: "",
  password: "",
});

const showPassword = ref(false);
const errorMessage = ref("");
const loading = ref(false);

const togglePassword = () => {
  showPassword.value = !showPassword.value;
};

const handleLogin = async () => {
  errorMessage.value = "";
  loading.value = true;

  try {
    const response = await login(form);

    // Simpan token jika backend mengirim token
    if (response.data.token) {
      localStorage.setItem("token", response.data.token);
    }

    // Simpan data user jika ada
    if (response.data.user) {
      localStorage.setItem(
        "user",
        JSON.stringify(response.data.user)
      );
    }

    // Redirect ke dashboard
    router.push("/dashboard");

  } catch (error) {
    errorMessage.value =
      error.response?.data?.message || "Email atau password salah.";
  } finally {
    loading.value = false;
  }
};
</script>