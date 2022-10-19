<template>
    <v-app id="app">
        <v-app-bar app color="bannertop" flat v-if="$store.getters.auth" elevation="1">
            <header-component></header-component>
        </v-app-bar>

        <v-main>
            <v-container fluid>
                <router-view></router-view>
            </v-container>
        </v-main>

        <v-footer v-if="this.$store.getters.user">
            <footer-component></footer-component>
        </v-footer>
    </v-app>
</template>

<script>
    import HeaderComponent from "@/components/app/HeaderComponent";
    import FooterComponent from "@/components/app/FooterComponent";
    import Csrf from "@/apis/Csrf";

    export default {
        components: {FooterComponent, HeaderComponent},
        created() {
            // Comprobar si ha aceptado la politica de cookies
            this.$store.commit("SET_COOKIE", Boolean(Csrf.getCookie("EXPRGPD")));
        },
    }
</script>

<style>
    #app {
        font-family: Avenir, Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-align: center;
        color: #2c3e50;
    }

    nav {
        padding: 30px;
    }

    nav a {
        font-weight: bold;
        color: #2c3e50;
    }

    nav a.router-link-exact-active {
        color: #42b983;
    }

    .v-sheet {
        background-color: #f5f5f5 !important;
        border-color: #f5f5f5 !important;
        color: rgba(0,0,0,.87) !important;
    }

    .v-card {
        border-width: thin;
        display: block;
        max-width: 100%;
        outline: none;
        text-decoration: none;
        transition-property: box-shadow,opacity;
        overflow-wrap: break-word;
        position: relative;
        white-space: normal;
        background-color: #ffffff !important;
        border-color: #000000 !important;
    }

</style>

