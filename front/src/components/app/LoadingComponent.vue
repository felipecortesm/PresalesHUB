<template>
    <v-dialog
        v-model="mostrar"
        persistent
        width="300"
    >
        <v-card
            color="primary"
            dark
        >
            <v-card-text>
                {{ texto }}
                <v-progress-linear
                    indeterminate
                    color="white"
                    class="mb-0"
                ></v-progress-linear>
            </v-card-text>
        </v-card>
    </v-dialog>
</template>

<script>
    export default {
        name: "LoadingComponent",
        props: {
            texto: {
                String,
                default() {
                    return 'Un momento por favor...';
                },
            },
        },
        data() {
            return {
                mostrar: false,
            };
        },
    }
</script>

