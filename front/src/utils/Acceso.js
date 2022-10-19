import store from "@/config/store.config";

let Acceso = {
    install(Vue) {
        Vue.prototype.$acceso = {
            /**
             * Peso administrador. 1
             */
            ADM: 1,
            /**
             * Peso preventa. 2
             */
            PRE: 2,
            /**
             * Peso preventa autorizado. 4
             */
            PAUT: 4,

            /**
             * Indica si un usuario tiene acceso permitido a una pantalla, componente, ...
             *
             * @param {int} valor
             */
            permitido: function (valor) {
                return (store.getters.user.perfil.peso & valor) > 0;
            },
        }
    },
}

export default Acceso;
