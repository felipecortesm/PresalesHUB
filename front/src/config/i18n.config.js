import Vue from "vue";
import VueI18n from "vue-i18n";
import es from "@/locales/es.json";

Vue.use(VueI18n);

export default new VueI18n({
    locale: 'es',
    messages: { es },
});
