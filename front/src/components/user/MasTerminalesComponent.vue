<template>
    <v-container>
        <v-row justify="center" class="pa-3">
            <h3>
                {{$t('quiere_term.text')}}
            </h3>
        </v-row>

        <v-row justify="center" v-for="(terminal, index) in terminales" :key="terminal.id" cols="2">
            <v-col cols="2">
                <v-text-field
                    :label="terminal.marca + '-' + terminal.modelo"
                    v-model="terminal.cantidad"
                    type="number"
                    :min="min"
                    :max="max"
                    outlined
                    dense
                    suffix="unidades"
                    @change="onChange(terminal, index)"
                    :disabled="disabled"
                ></v-text-field>
            </v-col>
            <v-col cols="2">
                <v-text-field
                    v-model="terminal.precio"
                    label="Precio de compra"
                    outlined
                    readonly
                    dense
                    filled
                    append-icon="mdi-currency-eur"
                    hint="IVA y seguro incluidos"
                    persistent-hint
                    :disabled="disabled"
                ></v-text-field>
            </v-col>
        </v-row>
        <p class="h5-local">
            {{$t('quiere_term.nota')}}
        </p>
    </v-container>
</template>

<script>
    import Terminal from "@/apis/Terminal";

    export default {
        name: "MasTerminalesComponent",
        props: {
            datos: {
                type: Array,
                default () {
                    return [];
                }
            },
            disabled: Boolean,
        },
        data() {
            return {
                max: 5,
                min: 0,
                terminales: [],
            };
        },
        watch: {
            datos() {
                // Limpiar campos
                //
                for (let i = 0; i < this.terminales.length; i++){
                    this.terminales[i].cantidad = 0;
                }

                this.$forceUpdate();

                if (this.datos.length <= 0)
                    return;

                // Poner la cantidad del pedido en el terminal
                //
                for (let i = 0; i < this.datos.length; i++){
                    if (this.datos[i].id_terminal_extra === null)
                        continue;

                    let terminal = this.terminales.find((element) => element.id === this.datos[i].id_terminal_extra);
                    terminal.cantidad = this.datos[i].cantidad;
                }

                this.$forceUpdate();

                this.$emit('select', this.terminales);
            },
        },
        async mounted() {
            try {
                const params = {
                    where: "nuevo = 0 and mas_terminales = 1",
                };
                this.terminales = await Terminal.getTerminal(params);

                for (let i = 0; i < this.terminales.length; i++){
                    this.terminales[i].cantidad = 0;
                }
            }
            catch (e) {
                console.log(e)
                this.$toast.error(e.message);
            }
        },
        methods: {
            onChange(terminal, index) {
                if (terminal.cantidad > this.max) {
                    terminal.cantidad = this.max;
                    this.terminales[index].cantidad = terminal.cantidad;
                    this.$forceUpdate();
                }

                this.terminales[index] = terminal;
                this.$emit('select', this.terminales);
            },
        },
    }
</script>

<style scoped>
    .h5-local {
        font-size: 12px;
        margin-top: 0;
        margin-bottom: 0;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        color: rgb(102 102 102);
    }

</style>
