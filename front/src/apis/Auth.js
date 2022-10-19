import Api from "../config/axios.config";
import Csrf from "@/apis/Csrf";
import store from "@/config/store.config";

export default {

    /**
     * Registrar usuario
     *
     * @param form
     */
    async register(form) {
        await Csrf.getXsrfToken();
        return await Api.post("/api/register", form);
    },

    /**
     * Acceso
     *
     * @param form
     * @returns resp
     * @throws err
     */
    async login(form) {
        await Csrf.getXsrfToken();
        let resp = await Api.post("/api/login", form);

        // control de errores informados por el server
        //
        if (resp.data.error) {
            store.commit('SET_USER', null);
            store.commit('SET_TOKEN', null);

            Csrf.deleteCookie();

            let err = new Error(resp.data.error);
            err.code = resp.data.errorCode;
            throw err;
        }

        // Almacenar usuario en el store
        //
        store.commit('SET_USER', resp.data);
        store.commit('SET_TOKEN', null);

        return resp;
    },

    /**
     * Cerrar sesion
     */
    async logout() {
        await Api.get("/api/logout");

        // Limpiar store
        //
        store.commit('SET_USER', null);
        store.commit('SET_TOKEN', null);

        Csrf.deleteCookie();
    },

    /**
     * Recuperar usuario logado
     * @returns resp | null
     */
    async me() {
        try {
            let resp = await Api.get("/api/me");
            store.commit('SET_USER', resp.data);
            return resp;
        }
        catch (e) {
            store.commit('SET_USER', null);
            return null;
        }
    },

};
