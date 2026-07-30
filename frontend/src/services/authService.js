import api from "./api";

export const login = (data) => api.post("/login", data);

export const profile = () => api.get("/profile");

export const logout = () => api.post("/logout");