import Vue from 'vue'
import App from '@/App.vue'
import router from '@/config/router.config'
import store from '@/config/store.config'
import vuetify from '@/config/vuetify.config'
import i18n from "@/config/i18n.config";

Vue.config.productionTip = false

// Mensajes (toast)
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";

const options = {
  timeout: 3500,
  position: 'bottom-right',
  hideProgressBar: true
};
Vue.use(Toast, options);

// Constantes y funcion de acceso
import Acceso from "@/utils/Acceso";
Vue.use(Acceso);

// Utilidades
import Utils from "@/utils/Utils";
Vue.use(Utils);

import 'vue-search-select/dist/VueSearchSelect.css';

document.title = 'PresalesHUB';

new Vue({
  router,
  store,
  vuetify,
  i18n,
  render: h => h(App)
}).$mount('#app')
