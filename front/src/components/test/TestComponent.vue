<template>
    <v-container>
        <v-row justify="center" style="padding-bottom: 20px">
            <v-btn @click.stop="dialog = true" color="primary" dark>
                Calendario
            </v-btn>

            <v-btn @click.stop="onClick" color="primary" dark>
                Usuario
            </v-btn>
        </v-row>

        <v-row justify="center" style="padding-bottom: 20px">
            <a :href="datos ? datos.link : ''">
                {{ datos ? datos.link : '' }}
            </a>
        </v-row>

        <v-row justify="center" style="padding-bottom: 20px">
            <h2>{{ usuario }}</h2>
        </v-row>

        <v-row>
            <v-col>
                <v-dialog max-width="300px" persistent v-model="dialog">
                    <v-date-picker v-model="fecha" scrollable actions>
                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <v-btn color="primary" @click="dialog=false">Cancel</v-btn>
                            <v-btn color="primary" @click="dialog = false">OK</v-btn>
                        </v-card-actions>
                    </v-date-picker>
                </v-dialog>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    import Auth from "@/apis/Auth";

    export default {
        name: 'TestComponent',
        props: {
            msg: String
        },
        data () {
            return {
                usuario: {name: '', email: ''},
                dialog: false,
                datos: null,
                fecha: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
            }
        },
        methods: {
            async onClick() {
                try{
                    const resp = await Auth.me();
                    this.usuario.name = resp.data.name;
                    this.usuario.email = resp.data.email;
                    this.$toast.success(this.$t('general.datos_ok'));
                }
                catch (e) {
                    this.$toast.error(e.message);
                }
            }
        }
    }
</script>

