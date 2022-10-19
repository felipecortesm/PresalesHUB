<template>
    <div class="text-center">
        <v-dialog
            v-model="mostrar"
            :width="width"
            persistent
        >
            <v-card>
                <v-card-title class="text-h6 grey lighten-2">
                    {{ titulo }}
                </v-card-title>

                <v-card-text>
                    <slot></slot>
                </v-card-text>

                <v-divider></v-divider>

                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn v-if="yes && visibleYes"
                        color="primary"
                        dark
                        @click="onClick('YES')"
                    >
                        {{yes}}
                    </v-btn>
                    <v-btn v-if="no && visibleNo"
                        color="secondary"
                        dark
                        @click="onClick('NO')"
                    >
                        {{no}}
                    </v-btn>
                    <v-btn v-if="cancel && visibleCancel"
                           color="secondary"
                           dark
                           @click="onClick('CANCEL')"
                    >
                        {{cancel}}
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
    export default {
        name: "DialogComponent",
        props: {
            titulo: String,
            width: Number,
            yes: {
                type: String,
            },
            visibleYes: {
                type: Boolean,
            },
            no: {
                type: String,
            },
            visibleNo: {
                type: Boolean,
            },
            cancel: {
                type: String,
            },
            visibleCancel: {
                type: Boolean,
            },
            tieneComentario:{
                type: Boolean,
            },
            comentario:String,
        },
        data() {
            return {
                mostrar: false,
            };
        },
        methods: {
            onClick(valor) {
                if(this.tieneComentario && !this.comentario && valor === 'YES'){
                    return;
                }
                this.$emit('close', valor);
                this.mostrar = false;
            },
        },
    }
</script>

