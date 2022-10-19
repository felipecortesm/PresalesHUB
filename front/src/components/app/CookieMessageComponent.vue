<template>
    <v-container fill-height>
        <v-layout justify-center>
            <v-flex xs6 sm6 md6 lg4>
                <v-bottom-sheet v-model="sheet" persistent>
                    <v-sheet height="150px">
                        <v-row>
                            <v-col>
                                <h3 class="text-center">
                                    {{ $t('cookie.titulo') }}
                                </h3>
                            </v-col>
                        </v-row>
                        <v-row style="margin: 0 100px 0 100px; font-size: small">
                            <v-col cols="10">
                                <div class="text-left">
                                    {{ $t('cookie.linea1') }}
                                </div>
                            </v-col>
                            <v-col>
                                <v-btn @click.prevent="$store.commit('SET_COOKIE', true)" color="secondary">
                                    Aceptar
                                </v-btn>
                            </v-col>
                        </v-row>
                    </v-sheet>
                </v-bottom-sheet>
            </v-flex>
        </v-layout>
    </v-container>

</template>

<script>
    export default {
        name: "CookieMessageComponent",
        data() {
            return {
                sheet: true,
            }
        },
    }
</script>

