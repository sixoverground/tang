const { webpackConfig, merge } = require('@rails/webpacker')

const webpack = require('webpack')

const customConfig = {
  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    })
  ],
}

const environment = merge(webpackConfig, customConfig)
  
module.exports = environment
