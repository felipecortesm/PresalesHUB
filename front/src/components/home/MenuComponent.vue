<template>
    <v-col v-if="visible">
        <v-card :to="ruta"
                class="mx-auto card-menu"
        >
            <v-card-title>
                <v-img alt="eXp" class="v-img" contain height="80px" :src="imagen"></v-img>
                {{ titulo }}
            </v-card-title>

            <v-card-subtitle>
                {{ subtitulo }}
            </v-card-subtitle>

        </v-card>
    </v-col>
</template>

<script>
    export default {
        name: "MenuComponent",
        props: {
            titulo: String,
            subtitulo: String,
            icono: String,
            ruta: Object,
            peso: Number,
        },
        data() {
            return {
                imagen: null,
                visible: true,
            }
        },
        mounted() {
            if (this.icono)
                this.imagen = require('@/assets/'+this.icono);

            // Control de acceso
            //
            this.visible = this.$acceso.permitido(this.peso);
        },
        methods: {

        }
    }
</script>

<style scoped>
    .card-menu {
        transition: transform .5s;
        max-width: 225px;
        box-shadow: -7px 11px 25px -9px rgba(0,0,0,1);
    }

    .card-menu:hover {
        transform: scale(1.1);
    }
</style>
