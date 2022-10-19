import Vue from 'vue'
import Vuex from 'vuex'
import Csrf from "@/apis/Csrf";

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: null,
    user: null,
    auth: false,
    cookie: false,
  },
  getters: {
    token(state) {
      return state.token;
    },
    user(state) {
      return state.user;
    },
    auth(state) {
      return state.auth;
    },
    cookie(state) {
      return state.cookie;
    },
  },
  mutations: {
    SET_TOKEN(state, value) {
      state.token = value;
    },
    SET_USER(state, data) {
      state.user = data;
      state.auth = Boolean(data);
    },
    SET_COOKIE(state, value) {
      state.cookie = value;
      if (value)
        Csrf.cookiesOk();
    },
  },
  actions: {
  },
  modules: {
  }
})
