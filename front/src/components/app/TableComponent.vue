<template>
    <v-card elevation="3">
        <v-card-title v-if="showBuscador">
            <v-text-field
                v-model="search"
                append-icon="mdi-magnify"
                label="Buscar"
                hide-details
                outlined
                class="customBackgroundColor"
                dense
            ></v-text-field>
        </v-card-title>
        <v-card-subtitle class="mt-0">
            <v-data-table
                dense
                :value="value"
                :headers="headers"
                :items="items"
                :search="search"
                :items-per-page="itemsPerPage"
                :loading="cargando"
                :custom-filter="customSearch"
                :sort-by="sortBy"
                :sort-desc="sortDesc"
                loading-text="Cargando datos"
                @click:row="filaSeleccionada"
                :show-select="showSelect"
                :single-select="singleSelect"
                @input="filasSeleccionadas"
                :item-class="rowClass"
            >
                <!-- Si hay un atributo formatter que tiene una funcion para dar un formato distinto al dato -->
                <template
                    v-for="header in headers.filter((header) =>
                        header.hasOwnProperty('formatter')
                    )"
                    v-slot:[`item.${header.value}`]="{ value }"
                >
                    {{ header.formatter(value) }}
                </template>
            </v-data-table>
            <slot name="customFooter"></slot>
        </v-card-subtitle>
    </v-card>
</template>
<script>
export default {
    name: "TableComponent",
    props: {
        /*
            headers =
            [
                {
                    text: "Solicitante",        // Titulo que se mostrara en la columna
                    value: "nombreUsuario",     // Clave de los item del array de datos al cual se asociara el titulo

                    align: "center",            // (Opcional) Para alinear el texto
                    sortable: false,            // (Opcional) Para permitir que pueda ser ordenado de menor a mayor y viceversa al seleccionar la columna
                    filterable: false,          // (Opcional) Para que el buscador busque o no en los datos de esta columna
                    formatter: function(value)  // (Opcional) Si se necesita mostrar el dato de otra forma, se le puede dar un atributo formatter con una funcion para ello, por ejemplo, para que la fecha se muestre en formato DD/MM/YYYY
                    ...
                },
                {...},
            ]
         */
        headers: Array,

        /*
            items =
            [
                {
                    clave1: valor1,
                    clave2: valor2,
                    ...
                }
                {...}
            ]
         */
        items: Array,

        // Numero de items que se mostraran por defecto en la tabla
        itemsPerPage: {
            type: Number,
            default: 5,
        },

        // Valor que indica si esta cargando los datos
        cargando: {
            type: Boolean,
            default: false,
        },

        // Valor que indica si se muestra el buscador o no
        showBuscador: {
            type: Boolean,
            default: true,
        },
        sortBy: Array,      // ['claveColumna1','claveColumna2',...]
        sortDesc: Array,    // [true, false, ...]
        showSelect: Boolean,
        singleSelect: Boolean,
        value: {
            type: Array,
            default () {
                return [];
            },
        },
    },
    data() {
        return {
            search: "",
            selected: null,
        };
    },
    methods: {
        /**
         * Cambiar estilo de la fila seleccionada
         * @param {*} item
         */
        rowClass(item) {
            if (this.selected && item.id === this.selected.id){
                return "selectedRowColor";
            }
        },
        /**
         * Al seleccionar una fila de la tabla, se lanzara un evento llamado filaSeleccionada
         * el cual devuelve los datos de esa fila junto a la posicion
         * @param {*} value
         * @param {*} rowData
         */
        filaSeleccionada(value, rowData) {
            this.selected = rowData.item;
            this.$emit("select", value, rowData.index);
        },

        /**
         * Evento para informar al padre de las filas seleccionadas
         * Devuelve un array con los objetos
         * @param {*} value
         */
        filasSeleccionadas(value) {
            this.$emit("input", value);
        },

        /**
         * Metodo que sobreescribe la busqueda por defecto que hace la tabla de vuetify, de esta forma, si un
         * valor tiene una funcion formatter dada como sucede en el caso de la fecha, filtra correctamente
         * segun el formato dado y no por el valor que se usa por "debajo"
         * @param value
         * @param search
         * @param item
         */
        customSearch(value, search, item) {
            // Se obtiene los headers para ver que atributos se deben usar de "items" y si tienen una
            // funcion formatter asociada
            for (let elem of this.headers) {
                // Se obtiene el dato segun el path del atributo que contiene "elem"
                let dato = this.getAttributeValueByPath(item, elem.value);

                // Si es null o undefined es que o no hay dato para filtrar o que no existe el atributo dado
                if (dato == null) {
                    continue;
                }

                // Si hay funcion para formatear el dato
                if (elem.formatter != null) {
                    // Se formatea el dato
                    let datoFormateado = elem.formatter(dato);

                    // Si contiene el texto a buscar, entonces devuelve true
                    if (
                        datoFormateado
                            .toString()
                            .toLowerCase()
                            .includes(search.toLowerCase())
                    ) {
                        return true;
                    }
                } else if (
                    // Si no hay funcion para formatear, se mira si el dato contiene el texto a buscar
                    dato.toString().toLowerCase().includes(search.toLowerCase())
                ) {
                    return true;
                }
            }

            // En el caso que ningun dato contenga el texto de "search" entonces se devuelve false
            return false;
        },

        /**
         * Dado un objeto obj, se devuelve el valor del atributo
         * que este en la ruta dada en el parametro path
         *
         * @param obj Objeto del cual buscar el valor segun el atributo dado en path
         * @param {string} path Ruta del atributo a buscar en obj
         * @return Valor u objecto que este en el path dado, si no se puede acceder
         * hasta el path dado, entonces devuelve null
         */
        getAttributeValueByPath(obj, path) {
            let split = path.split(".");
            let objAux = obj;
            for (let elem of split) {
                if (objAux == null) return null;

                objAux = objAux[elem];
            }
            return objAux;
        },
    },
};
</script>
<style>
    .customBackgroundColor {
        background-color: #f5f5f5 !important;
    }
    .v-data-table > .v-data-table__wrapper > table > thead > tr > th {
        font-size: 1rem !important;
    }
    .v-data-table > .v-data-table__wrapper > table > tbody {
        background-color: #f5f5f5 !important;
        cursor: pointer;
    }
    .selectedRowColor {
        color: #00358e;
        background-color: #f5f5f5 !important;
    }
</style>
