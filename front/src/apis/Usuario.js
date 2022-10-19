import Api from "../config/axios.config";

export default {
    /**
     * Obtener datos de usuario
     *
     * @param idUsuario
     * @returns resp.data
     * @throws err
     */
    async getUsuario(idUsuario) {
        let resp = await Api.post('/api/get-usuario', {id: idUsuario});

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
