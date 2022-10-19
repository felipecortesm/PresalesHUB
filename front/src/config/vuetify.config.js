import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)

// Translation provided by Vuetify (javascript)
import es from 'vuetify/lib/locale/es'
import en from 'vuetify/lib/locale/en'

const opts = {
    lang: {
        locales: { es, en },
        current: 'es',
    },
    theme: {
        themes: {
            lightOrig: {
                primary: '#00358e',
                secondary: '#424242',
                accent: '#82B1FF',
                error: '#ff5252',
                info: '#2196F3',
                success: '#4CAF50',
                warning: '#FB8C00',
            },
            light: {
                primary: '#00358e',
                secondary: '#424242',
                accent: '#2a9d8f',
                error: '#f44336',
                warning: '#FB8C00',
                info: '#00bcd4',
                success: '#2a9d8f',
                bannertop: "#b1afc5"
                
            },
        },
    },
};

export default new Vuetify(opts)
