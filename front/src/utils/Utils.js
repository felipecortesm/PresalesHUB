import moment from "moment";

let Utils = {
    install(Vue) {
        Vue.prototype.$utils = {
            /**
             * Rutas ADFS
             */
            LOGOUT_URL: "http://dev.presaleshub.com:8080/",


            /**
             * Estados pedido
             */
            EN_CURSO_SEDE: 'SED',
            EN_CURSO_ZELERIS: 'ZEL',
            PEND_APROBACION: 'PEN',
            ENVIADO: 'ENV',
            FINALIZADO: 'FIN',
            CANCELADO: 'CAN',
            RECHAZADO: 'REC',
            BORRADO: 'BOR',

            /**
             * Sumar horas a una fecha dada
             *
             * @param hora
             * @param numHoras
             */
            sumaHoras: function (hora, numHoras = 1) {
                const aux = moment("2000-01-01 " + hora);
                aux.add(numHoras, 'h');

                return aux.format('H:mm');
            },

            /**
             * Formatear una fecha dada
             *
             * @param fecha p.ej. 2022-08-25
             * @param formato p.ej. 'D MMMM, YYYY'
             */
            fechaFormato: function (fecha, formato) {
                const d = moment(fecha);
                return d.locale('es').format(formato);
            },

            /**
             * Diferencia de dias entre dos fechas
             *
             * @param fecha1
             * @param fecha2
             */
            diferenciaDias: function (fecha1, fecha2) {
                const f1 = moment(fecha1);
                const f2 = moment(fecha2);
                return f2.diff(f1, 'days');
            },

            /**
             * Valida si la fecha de cita es correcta
             *
             * @param fecha1
             */
            fechaCorrectaCita: function (fecha1) {
                const f1 = moment(fecha1);
                const f2 = moment();
                return moment(f1).isSameOrAfter(f2, 'day');
            },

            /**
             * Valida si la fecha de cita es hoy
             *
             * @param fecha1
             */
            esHoyCita: function (fecha1) {
                const f1 = moment(fecha1);
                const f2 = moment();
                return moment(f1).isSame(f2, 'day');
            },

            /**
             * Valida si la hora de cita es correcta
             *
             * @param fecha
             * @param hora
             */
            horaCorrectaCita: function (fecha,hora) {
                const f1 = moment(fecha);
                const f2 = moment();

                // Cualquier dia posterior a hoy sin restriccion
                //
                if (moment(f1).isAfter(f2, 'day')){
                    return true;
                }

                // En el dia de hoy o anteriores comprobar si la hora ya se ha pasado
                //
                const ahora = moment().format('HH');
                return parseInt(hora) > parseInt(ahora);
            },

            /**
             * Validar dni
             *
             * @param dni
             */
            validaDni: function (dni) {
                let numero;
                let letr;
                let letra;
                let expresion_regular_dni;

                expresion_regular_dni = /^\d{8}[a-zA-Z]$/;

                if (expresion_regular_dni.test(dni) === true) {
                    numero = dni.substr(0, dni.length - 1);
                    letr = dni.substr(dni.length - 1, 1);
                    numero = numero % 23;
                    letra = 'TRWAGMYFPDXBNJZSQVHLCKET';
                    letra = letra.substring(numero, numero + 1);
                    return letra === letr.toUpperCase();
                } else {
                    // Formato no válido
                    return false;
                }
            },

            /**
             * Validar email
             *
             * @param email
             */
            validaEmail: function (email) {
                const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                return pattern.test(email);
            },

            /**
             * Validar url
             *
             * @param url
             */
            validaUrl: function (url) {
                const pattern = /https?:\/\/(www)?[-a-zA-Z0-9@:%._~#=]{2,256}.[a-z]{2,6}\b([-a-zA-Z0-9@:%_.~#?&/=]*)/gm;
                return pattern.test(url);
            },

            /**
             * Validar telefono
             *
             * @param tfno
             */
            validaTelefono: function (tfno) {
                const pattern = /^(?:(?:\+?[0-9]{2,4})?[ ]?[6789][0-9 ]{8,13})$/gm;
                return pattern.test(tfno);
            },

            /**
             * Validar codigo postal españa
             *
             * @param cp
             */
            validaCodPostal: function (cp) {
                const pattern = /^(?:0[1-9]|[1-4]\d|5[0-2])\d{3}$/;
                return pattern.test(cp);
            },

            /**
             * Validar imei
             *
             * @param imei
             */
            validaImei: function (imei) {
                const etal = /^[0-9]{15}$/;
                if (!etal.test(imei))
                    return false;
                let sum = 0;
                let mul = 2;
                let l = 14;
                for (let i = 0; i < l; i++) {
                    let digit = imei.substring(l-i-1,l-i);
                    let tp = parseInt(digit,10)*mul;
                    if (tp >= 10)
                        sum += (tp % 10) +1;
                    else
                        sum += tp;
                    if (mul === 1)
                        mul++;
                    else
                        mul--;
                }
                let chk = ((10 - (sum % 10)) % 10);
                return chk === parseInt(imei.substring(14, 15), 10);
            },

            /**
             * Compara dos objetos.
             * Devuelve true si son iguales
             *
             * @param a
             * @param b
             */
            compare: function(a, b) {
                const isEqual = (...objects) => objects.every(obj => JSON.stringify(obj) === JSON.stringify(objects[0]));
                return isEqual(a, b);
            },
        }
    },
}

export default Utils;
