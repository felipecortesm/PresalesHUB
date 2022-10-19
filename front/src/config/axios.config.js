import axios from "axios";
import store from "@/config/store.config";

// Configuracion de cabeceras http
// Revisar los siguientes valores en caso de problemas con CORS:
//   'Access-Control-Allow-Origin': '*',
//   'Access-Control-Allow-Headers': 'lo que sea',
// PenTest:
//   'Cache-Control': 'no-cache, no-store, must-revalidate',
//
const Api = axios.create({
    baseURL: process.env.VUE_APP_ROOT_API,
    timeout: 60000,
    withCredentials: true,
    headers: {
        common: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
        }
    }
});

// Interceptor para inyectar el token en cada llamada al api
// 'Authorization': store.getters.token
// Se actualiza desde el store que se habrá obtenido en el login
//
Api.interceptors.request.use((config) => {
    // Solo si se ha recuperado token
    if (store.getters.token){
        config.headers.common['Authorization'] = `Bearer `+store.getters.token;
        //console.log('token...',store.getters.token);
    }

    return config;
});

export default Api;
