import Api from "../config/axios.config";

export default {

    /**
     * Obtener todos los valores de la tabla informada
     *
     * @param {string} tabla
     * @returns resp.data
     * @throws err
     */
    async getTable(tabla) {
        let resp = await Api.post('/api/get-ref', {tabla: tabla});

        // Controlar el error...
        //
        if (resp.data.error) {
            let err = new Error(resp.data.error);
            err.code = resp.data.errorCode;
            throw err;
        }

        return resp.data;
    },

    /**
     * Obtener el valor del elemento de la tabla informada
     *
     * @param {string} tabla
     * @param {string} codigo
     * @returns resp.data
     * @throws err
     */
    async getValue(tabla, codigo) {
        let resp = await Api.post('/api/get-ref', {tabla: tabla, codigo: codigo});

        // Controlar el error...
        //
        if (resp.data.error) {
            let err = new Error(resp.data.error);
            err.code = resp.data.errorCode;
            throw err;
        }

        return resp.data;
    },

};
