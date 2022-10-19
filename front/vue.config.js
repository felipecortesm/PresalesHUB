const { defineConfig } = require('@vue/cli-service')

module.exports = defineConfig({
  transpileDependencies: true,
  filenameHashing: false,
  //publicPath: process.env.NODE_ENV === 'production' ? '/' : '/',
  publicPath: '/',

  // Configuracion CORS. Solo desarrollo
  // En el caso de que la api y el servidor no esten en el mismo dominio
  //
  devServer: {
    host: 'dev.presaleshub.com',
    port: 8080,
    proxy: "http://dev.presaleshub.com:8000"
  }
})
