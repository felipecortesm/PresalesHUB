<template>
    <v-container fill-height>
        <v-layout justify-center >
            <v-flex md7 lg5>
                <div class="justify-center">
                    <v-card-title class="justify-center">
                        <v-img alt="ExP" class="v-img" contain height="92px" :src="logo" style=" background-color:#b1afc5 ;"></v-img>
                        <div style="margin: 25px">
                            <h3 v-if="pagina === 3">Establecer contraseña</h3>
                            <h3 v-else>Iniciar sesión</h3>
                        </div>
                    </v-card-title>

                    <form @submit.prevent="login" ref="form">
                        <v-chip v-if="pagina === 2"
                            style="margin-bottom: 20px"
                            pill
                            color="primary"
                        >
                            <v-icon left>
                                mdi-account-circle-outline
                            </v-icon>
                            {{ form.email }}
                        </v-chip>

                        <v-text-field v-if="pagina === 1"
                            outlined
                            label="Correo"
                            name="email"
                            placeholder="correo"
                            required
                            type="text"
                            v-model="form.email"
                        ></v-text-field>

                        <!-- Reset Password
                        -->
                        <v-text-field v-if="pagina === 2"
                            outlined
                            autofocus
                            label="Password"
                            name="password"
                            placeholder="password"
                            required
                            v-model="form.password"
                            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                            :type="show1 ? 'text' : 'password'"
                            @click:append="show1 = !show1"
                        ></v-text-field>

                        <v-text-field v-if="pagina === 3"
                            outlined
                            autofocus
                            label="Nueva password"
                            name="password-new"
                            placeholder="password"
                            required
                            v-model="form.newPassword"
                            :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                            :type="show2 ? 'text' : 'password'"
                            @click:append="show2 = !show2"
                        ></v-text-field>
                         <v-text-field v-if="pagina === 3"
                            outlined
                            label="Confirmar password"
                            name="password-confirm"
                            placeholder="password"
                            required
                            v-model="form.confirmPassword"
                            :append-icon="show3 ? 'mdi-eye' : 'mdi-eye-off'"
                            :type="show3 ? 'text' : 'password'"
                            @click:append="show3 = !show3"
                        ></v-text-field>

                        <v-row justify="end" style="padding: 0px">
                            <v-col cols="8">
                                <v-checkbox v-if="pagina === 1"
                                    v-model="remember"
                                    label="Recordar mis datos"
                                ></v-checkbox>
                            </v-col>
                            <v-col>
                                <v-btn class="mt-4"
                                       color="primary"
                                       type="submit"
                                       large
                                       :disabled="!$store.getters.cookie"
                                       :loading="overlay"
                                >
                                    <v-icon v-if="pagina > 1" left>mdi-login</v-icon>
                                    {{ pagina === 1 ? "Siguiente" : "Iniciar sesión" }}
                                </v-btn>
                            </v-col>
                        </v-row>
                    </form>
                </div>
            </v-flex>
        </v-layout>

        <cookie-message-component v-if="!$store.getters.cookie"></cookie-message-component>

    </v-container>
</template>

<script>
    import Auth from "@/apis/Auth";
    import CookieMessageComponent from "@/components/app/CookieMessageComponent";
    import Csrf from "@/apis/Csrf";

    export default {
        name: "LoginView",
        components: {CookieMessageComponent},
        data() {
            return {
                form: {
                    email: "",
                    password: "",
                    newPassword:"",
                    confirmPassword:"",
                },
                overlay: false,
                remember: false,
                pagina: 1,
                logo: require('@/assets/logo-exp.png'),
                show1: false,
                show2: false,
                show3: false,
            };
        },
        mounted() {
            // Comprobar si se recuerda al usuario, si es así recuperar el dato de la cookie
            // y pasar a introducir clave si NO es usuario PwC
            //
            let idRemember = Csrf.getCookie('EXPIDREMEMBER');
            if (idRemember) {
                this.form.email = window.atob(idRemember);
                // Mientras no haya adfs no se hace ésto...
                //if (!this.isPwc)
                    this.pagina++;
                //else
                //    this.login();
            }
        },
        computed: {
            isPwc: function () {
                return this.$utils.isPwC(this.form.email.toLowerCase())
            }
        },
        methods: {
            async login() {
                try{
                    if (this.pagina === 1) {
                        // Cualquier otro usuario debe introducir password
                        //
                        this.pagina++;
                        return;
                    }
                    else if (this.pagina === 3) {
                        // Pagina de confirmacion de nueva contraseña
                        //
                        if (!this.validateNewPassword())
                            return;
                    }

                    this.overlay = true;
                    await Auth.login(this.form);

                    // Cookie remember
                    //
                    if (this.remember)
                        Csrf.rememberCookie(this.form.email);

                    this.overlay = false;
                    this.$router.push({name: "home"})
                        .catch(() => {
                            // ignorar error
                        });
                }
                catch (error) {
                    this.overlay = false;

                    if (error.code === 999){
                        this.pagina = 3;
                        this.$toast.warning(error.message);
                        return;
                    }
                    this.$toast.error(error.message);
                }
            },
            validateNewPassword() {
                if(this.form.newPassword !== "" && this.form.newPassword === this.form.confirmPassword){
                    let strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[_!@#\\$%\\^&\\*])(?=.{8,})");
                    //Check password regex
                    if(!strongRegex.test(this.form.newPassword)) {
                        this.$toast.error(this.$t('auth.err_caracteres_especiales'));
                        return false;
                    }
                }else{
                    this.$toast.error(this.$t('auth.err_no_coinciden'));
                    return false;
                }

                return true;
            },
        },
    }
</script>

