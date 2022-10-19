<template>
    <v-banner elevation="2" outlined rounded>
        <v-avatar slot="icon" color="secondary" size="40">
            <v-icon icon="mdi-waving_hand" color="white">
                mdi-hand-wave
            </v-icon>
        </v-avatar>

        <h3 style="text-align: start;">
            Bienvenid@!
        </h3>

        <br v-if="texto" >

        <p v-if="texto" style="text-align: start;" v-html="texto"/>

    </v-banner>
</template>

<script>
    export default {
        name: "BannerComponent",
        props: ['texto'],
    }
</script>

