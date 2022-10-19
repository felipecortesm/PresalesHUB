<template>
    <v-container>
        <v-footer padless style="max-height: 70px; font-size: small" class="justify-center">
            <div class="text-center">
                <v-row>
                    <v-col cols="12" >
                        {{ $t('footer.copyright') }}
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12">
                        <a  style="text-decoration: none" @click="$refs.Cookies.mostrar = true">{{ $t('footer.cookies') }}</a>&nbsp;|&nbsp;
                        <a style="text-decoration: none" @click="$refs.Terminos.mostrar = true">{{ $t('footer.terminos_uso') }}</a>&nbsp;|&nbsp;
                        <a  style="text-decoration: none" @click="$refs.Privacidad.mostrar = true">{{ $t('footer.privacidad') }}</a>
                    </v-col>
                </v-row>
            </div>
        </v-footer>

        <dialog-component ref="Cookies" :width="800" :titulo="$t('footer.cookies')"  yes="Cerrar" visibleYes>
            <template v-slot>
                <v-container>
                     <div v-html="cookies"></div>
                </v-container>
            </template>
        </dialog-component>
        <dialog-component ref="Terminos" :width="800" :titulo="$t('footer.terminos_uso')" yes="Cerrar" visibleYes>

            <template v-slot>
                <v-container>
                    <div v-html="terminos"></div>
                </v-container>
            </template>
        </dialog-component>
        <dialog-component ref="Privacidad" :width="800" :titulo="$t('footer.privacidad')" yes="Cerrar" visibleYes>
            <template v-slot>
                <v-container>
                    <div v-html="privacidad"></div>
                </v-container>
            </template>
        </dialog-component>



    </v-container>
</template>

<script>
    import dialogComponent from "@/components/app/DialogComponent";
    import Referencia from "@/apis/Referencia";

    export default {
        name: "FooterComponent",
        components: {
            dialogComponent,
        },
        data() {
            return {
                terminos:null,
                privacidad:null,
                cookies:null,
            }
        },
        mounted() {
            this.loadData();
        },
        methods: {
            async loadData() {
                let respuesta = await Referencia.getTable("FOOTER");
                respuesta.forEach(element => {
                    switch (element.codigo) {
                        case "TERMINOS":
                            this.terminos = element.valor;
                            break;
                        case "PRIVACIDAD":
                            this.privacidad = element.valor;
                            break;
                        case "COOKIES":
                            this.cookies = element.valor;
                            break;
                    }
                });
            }
        }
    }
</script>

