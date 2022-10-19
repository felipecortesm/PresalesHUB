<template>
    <v-expansion-panels v-model="panel"
                        focusable
                        active-class="v-item--active">
        <v-expansion-panel>
            <v-expansion-panel-header style="padding-top: 0; padding-bottom: 0">
                <h4 class="v-card__title">
                    Datos del usuario
                </h4>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
                <v-container>
                    <v-row style="margin-bottom: -40px">
                        <v-col cols="6" sm="6">
                            <v-text-field
                                :value="datosUsuario ? datosUsuario.name : ''"
                                label="Nombre"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                        <v-col cols="6" sm="6">
                            <v-text-field
                                :value="datosUsuario ? datosUsuario.email : ''"
                                label="Correo electrónico"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row style="margin-bottom: -40px">
                        <v-col cols="4" sm="4">
                            <v-text-field
                                :value="datosUsuario ? datosUsuario.telefono : ''"
                                label="Teléfono"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                        <v-col cols="2" sm="2">
                            <v-text-field
                                :value="datosUsuario ? datosUsuario.extension : ''"
                                label="Extensión"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                        <v-col cols="6" sm="6">
                            <v-text-field
                                :value="datosUsuario ? datosUsuario.perfil_pwc : ''"
                                label="Perfil"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                    </v-row>
                </v-container>
            </v-expansion-panel-content>
        </v-expansion-panel>

        <v-expansion-panel>
            <v-expansion-panel-header style="padding-top: 0; padding-bottom: 0">
                <h4 class="v-card__title">
                    Datos del terminal actual
                </h4>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
                <v-container>
                    <v-row style="margin-bottom: -40px">
                        <v-col cols="6" sm="6">
                            <v-text-field
                                :value="datosUsuario.terminalActual ? datosUsuario.terminalActual.terminal.marca : ''"
                                label="Marca"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                        <v-col cols="6" sm="6">
                            <v-text-field
                                :value="datosUsuario.terminalActual ? datosUsuario.terminalActual.terminal.modelo : ''"
                                label="Modelo"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row style="margin-bottom: -40px">
                        <v-col cols="6" sm="6">
                            <v-text-field
                                :value="datosUsuario.terminalActual ? datosUsuario.terminalActual.terminal.precio : ''"
                                label="Precio de compra"
                                outlined
                                readonly
                                dense
                                filled
                                append-icon="mdi-currency-eur"
                                hint="IVA y seguro incluidos"
                                persistent-hint
                            ></v-text-field>
                        </v-col>
                        <v-col cols="6" sm="6">
                            <v-text-field
                                :value="datosUsuario.terminalActual ? datosUsuario.terminalActual.imei : ''"
                                label="IMEI"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                    </v-row>
                </v-container>
            </v-expansion-panel-content>
        </v-expansion-panel>

        <v-expansion-panel>
            <v-expansion-panel-header style="padding-top: 0; padding-bottom: 0">
                <h4 class="v-card__title">
                    Datos del terminal nuevo
                </h4>
            </v-expansion-panel-header>
            <v-expansion-panel-content>
                <v-container>
                    <v-row style="margin-bottom: -40px">
                        <v-col cols="4" sm="4">
                            <v-text-field
                                :value="datosUsuario.terminalNuevo ? datosUsuario.terminalNuevo.terminal.marca : ''"
                                label="Marca"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                        <v-col cols="4" sm="4">
                            <v-text-field
                                :value="datosUsuario.terminalNuevo ? datosUsuario.terminalNuevo.terminal.modelo : ''"
                                label="Modelo"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                        <v-col cols="4" sm="4" v-if="!!datosUsuario.terminalNuevo && datosUsuario.terminalNuevo.imei">
                            <v-text-field
                                :value="datosUsuario.terminalNuevo ? datosUsuario.terminalNuevo.imei : ''"
                                label="IMEI"
                                outlined
                                readonly
                                dense
                                filled
                            ></v-text-field>
                        </v-col>
                    </v-row>
                </v-container>
            </v-expansion-panel-content>
        </v-expansion-panel>

    </v-expansion-panels>
</template>

<script>
    import Terminal from "@/apis/Terminal";
    import Usuario from "@/apis/Usuario";

    export default {
        name: "DatosUsuarioComponent",
        props: {
            value: {
                type: Object
            },
            idUsuario: {
                type: Number,
                default () {
                    return this.$store.getters.user.id;     // usuario logado
                }
            },
        },
        data() {
            return {
                panel: 0,
                datosUsuario: {},
            };
        },
        watch: {
            datosUsuario (newValue) {
                this.$emit('input', newValue);
            },
            value (newValue) {
                this.datosUsuario = newValue;
            },
            async idUsuario (newValue) {
                await this.loadData(newValue);
            }
        },
        async mounted(){
            await this.loadData(this.idUsuario)
        },
        methods: {
            async loadData(idUsuario){
                try {
                    if (idUsuario == null) {
                        return;
                    }
                    this.datosUsuario = await Usuario.getUsuario(idUsuario);

                    // Obtener los datos de los terminales
                    //
                    const params = {
                        where: "id_usuario = " + this.datosUsuario.id,
                        eager: {
                            terminal: null,
                        },
                    };
                    const datos = await Terminal.getTerminalUsuario(params);

                    this.datosUsuario.terminalActual = datos.find((element) => element.terminal.nuevo === 0);
                    this.datosUsuario.terminalNuevo = datos.find((element) => element.terminal.nuevo === 1);

                    this.$forceUpdate();
                } catch (e) {
                    console.log(e);
                    this.$toast.error(e.message);
                }
            }
        },
    }
</script>

