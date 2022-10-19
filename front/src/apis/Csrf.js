import Api from "../config/axios.config";
import Cookies from "js-cookie";

export default {
  /**
   * Obtener el token para la spa
   */
  getXsrfToken() {
    let token = Cookies.get("XSRF-TOKEN");

    if (token) {
      // Hay cookie. Devolvemos la cookie en la promesa
      return new Promise(resolve => {
        resolve(token);
      });
    }
    // No hay cookie. Peticion al servidor
    return Api.get("/api/csrf-cookie");
  },

  /**
   * Eliminar el token
   */
  deleteCookie() {
    Cookies.remove("XSRF-TOKEN", {path: '/'});
  },

  /**
   * Recuperar una cookie por el nombre
   *
   * @param nombre
   */
  getCookie(nombre){
    return Cookies.get(nombre);
  },

  /**
   * Establece la cookie para aceptacion de la politica proteccion de datos
   */
  cookiesOk() {
    Cookies.set("EXPRGPD","AceptaPoliticaRGPD",{ expires: 365 });
  },

  /**
   * Establece la cookie para recordar al usuario en el acceso la proxima vez
   */
  rememberCookie(id) {
    Cookies.set("EXPIDREMEMBER",window.btoa(id),{ expires: 365 });
  }

};
