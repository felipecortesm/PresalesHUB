<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="10">
                <v-btn @click="clickToast">Mostrar Toast</v-btn>
            </v-col>
        </v-row>
        <v-row justify="center" class="menu-row">
            <menu-component icono="logo.png"
                            subtitulo="Solo Administrador"
                            titulo="Titulo"
                            :ruta="{name: 'home'}"
                            :peso="$acceso.ADM" 
                            />
                            
            <menu-component icono="logo.png"
                            subtitulo="Administrador o Autorizado"
                            titulo="Titulo"
                            :ruta="{name: 'home'}"
                            :peso="$acceso.ADM+$acceso.PAUT" />                
                            
            <menu-component icono="logo.png"
                            subtitulo="Preventa"
                            titulo="Titulo"
                            :ruta="{name: 'home'}"
                            :peso="$acceso.PRE" />

            <menu-component icono="logo.png"
                            subtitulo="Preventa Autorizado"
                            titulo="Titulo"
                            :ruta="{name: 'home'}"
                            :peso="$acceso.PAUT" />

        </v-row>

        <cookie-message-component v-if="!$store.getters.cookie"></cookie-message-component>
    </v-container>
</template>

<script>
    // @ is an alias to /src
    import MenuComponent from "@/components/home/MenuComponent";
    import CookieMessageComponent from "@/components/app/CookieMessageComponent";

    export default {
        name: 'HomeView',
        components: {
            CookieMessageComponent,
            MenuComponent,
        },
        data() {
            return {
                textoBanner: null,
            };
        },
        mounted() {
            if (this.$store.getters.user.perfil){
                 this.textoBanner = this.$store.getters.user.perfil.home_banner;
            }
        },
        methods: {
            clickToast(){
                this.$toast.success('Bienvenido');
            }
        }
    }
</script>

<style scoped>
    .menu-row {
        margin-left: 6%;
        margin-right: 6%;
        padding-top: 45px;
    }
</style>
