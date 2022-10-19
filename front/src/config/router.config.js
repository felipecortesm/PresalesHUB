import Vue from 'vue';
import VueRouter from 'vue-router';
import store from './store.config';
import Cookies from "js-cookie";
import Auth from "@/apis/Auth";
import HomeView from "@/views/HomeView";
import TestView from "@/views/test/TestView";
import LoginView from "@/views/LoginView";


Vue.use(VueRouter);

const routes = [
  {
    path: "/login",
    name: "login",
    component: LoginView,
    meta: { authOnly: false }
  },
  {
    path: '/',
    name: 'home',
    component: HomeView,
    meta: { authOnly: true }
  },
  {
    path: "/logout",
    name: "logout",
    meta: { authOnly: true }
  },
  {
    path: '/test',
    name: 'test',
    component: TestView,
    meta: { authOnly: true }
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})



router.beforeEach(async (to, from, next) => {
if (to.matched.some(record => record.meta.authOnly)){
    // No está autenticado
    //
    if (!store.getters.auth){
      // Hay cookie?
      //
      if (Cookies.get("XSRF-TOKEN")){
        // Recuperar el usuario
        //
        let resp = await Auth.me();

        if (resp === null)
          next({name: "login"});
        else
          next();
      }
      else {
        // Redirigir al login
        //
        next({name: "login"});
      }
    }
    else {
      // Está autenticado
      //
      next();
    }
  }
  else {
    // No se requiere autenticacion
    //
    next();
  }
})

export default router;
