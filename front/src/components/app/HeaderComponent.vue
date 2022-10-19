<template>
    <v-container>
        <v-toolbar flat color="bannertop">
            <router-link to="/">
                <v-img alt="eXp" class="v-img" contain height="48px" position="center right" :src="logo"></v-img>
            </router-link>

            <v-toolbar-title style="padding-left: 10px;">{{ $t('header.text') }}</v-toolbar-title>

            <v-spacer></v-spacer>

            <v-toolbar-items>
                <v-chip style="align-self: center;" pill color="primary">
                    <v-icon left>
                        mdi-account-circle-outline
                    </v-icon>

                    {{ !user ? '' : user.name + ' · '+ user.perfil.descripcion}}

                    <v-tooltip right>
                        <template v-slot:activator="{ on, attrs }">
                            <v-icon right style="cursor: pointer;"
                                    @click="logout"
                                    v-bind="attrs"
                                    v-on="on"
                            >
                                mdi-logout
                            </v-icon>
                        </template>
                        <span>Desconectar</span>
                    </v-tooltip>
                </v-chip>
            </v-toolbar-items>
        </v-toolbar>
    </v-container>
</template>

<script>
    import Auth from "@/apis/Auth";

    export default {
        name: "HeaderComponent",
        data() {
            return {
                logo: require('@/assets/logo-exp.png'),
                user: null,
            };
        },
        mounted() {
            this.user = this.$store.getters.user;
        },
        methods: {
            async logout() {
                await Auth.logout();
                window.location.href = this.$utils.LOGOUT_URL;
            }
        }
    }
</script>

<style scoped>
    .v-img {
        max-width: 100px !important;
        margin-right: 15px;
    }
</style>
