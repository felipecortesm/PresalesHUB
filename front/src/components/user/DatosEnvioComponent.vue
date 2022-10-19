<template>
    <v-container>
        <v-card>
            <v-card-title>
                Datos de envío
            </v-card-title>
            <v-card-text>
                <v-form
                    ref="form"
                    :disabled="disabled"
                >
                    <v-row class="row">
                        <v-col cols="4" sm="4">
                            <v-text-field
                                v-model="datosEnvio.nombre"
                                label="Nombre"
                                :rules="[rules.obligatorio]"
                                outlined
                                dense
                                @change="onChange"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="8" sm="8">
                            <v-text-field
                                v-model="datosEnvio.apellidos"
                                label="Apellidos"
                                :rules="[rules.obligatorio]"
                                outlined
                                dense
                                @change="onChange"
                            ></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row class="row">
                        <v-col cols="4" sm="4">
                            <v-text-field
                                v-model="datosEnvio.dni"
                                label="DNI"
                                :rules="[rules.obligatorio,rules.nif]"
                                maxlength="9"
                                outlined
                                dense
                                @change="onChange"
                            ></v-text-field>
                        </v-col>
                        <v-col cols="8" sm="8">
                            <v-text-field
                                v-model="datosEnvio.email"
                                label="Correo electrónico"
                                :rules="[rules.obligatorio,rules.email]"
                                outlined
                                dense
                                @change="onChange"
                            ></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row class="row">
                        <v-col>
                            <v-text-field
                                v-model="datosEnvio.direccion"
                                label="Dirección completa"
                                :rules="[rules.obligatorio]"
                                outlined
                                dense
                                @change="onChange"
                            ></v-text-field>
                        </v-col>
                    </v-row>
                    <v-row class="row">
                        <v-col>
                            <v-text-field
                                v-model="datosEnvio.poblacion"
                                label="Población"
                                :rules="[rules.obligatorio]"
                                outlined
                                dense
                                @change="onChange">
                            </v-text-field>
                        </v-col>
                        <v-col cols="4" sm="4">
                            <v-text-field v-model="datosEnvio.cod_postal"
                                label="Código postal"
                                :rules="[rules.obligatorio,rules.cpos]"
                                maxlength="5"
                                outlined
                                dense
                                @change="onChange">
                            </v-text-field>
                        </v-col>
                    </v-row>
                    <v-row class="row">
                        <v-col>
                            <v-text-field v-model="datosEnvio.provincia"
                                label="Provincia"
                                :rules="[rules.obligatorio]"
                                outlined
                                dense
                                @change="onChange">
                            </v-text-field>
                        </v-col>
                        <v-col cols="4" sm="4">
                            <v-text-field v-model="datosEnvio.telefono"
                                label="Teléfono"
                                :rules="[rules.obligatorio,rules.tfno]"
                                outlined dense
                                @change="onChange">
                            </v-text-field>
                        </v-col>
                    </v-row>
                    <v-row class="row">
                        <v-col>
                            <v-textarea
                                auto-grow
                                clearable
                                clear-icon="mdi-close-circle"
                                outlined
                                label="Comentario"
                                v-model="datosEnvio.comentario"
                                rows="3"
                                @change="onChange"
                            ></v-textarea>
                        </v-col>
                    </v-row>
                </v-form>
            </v-card-text>
        </v-card>
    </v-container>
</template>

<script>
    export default {
        name: "DatosEnvioComponent",
        props: {
            value: Object,
            disabled: Boolean,
        },
        data() {
            return {
                datosEnvio: {
                    nombre: null,
                    apellidos: null,
                    dni: null,
                    email: null,
                    direccion: null,
                    cod_postal: null,
                    telefono: null,
                    comentario: null,
                    provincia: null,
                    poblacion: null,
                },
                rules: {
                    obligatorio: value => !!value || 'Campo obligatorio',
                    email: value => { return this.$utils.validaEmail(value) || 'Correo electrónico no válido' },
                    nif: value => { return this.$utils.validaDni(value) || 'DNI no válido' },
                    tfno: value => { return this.$utils.validaTelefono(value) || 'Teléfono no válido' },
                    cpos: value => { return this.$utils.validaCodPostal(value) || 'Código no válido' },
                },
            };
        },
        mounted() {
            if (this.value)
                this.datosEnvio = this.value;
        },
        methods: {
            onChange() {
                this.$emit('select', this.datosEnvio);
            },
            validarDatosEnvio() {
                return this.$refs.form.validate();
            },
        },
    }
</script>

<style scoped>
    .row {
        margin-bottom: -35px
    }
</style>
