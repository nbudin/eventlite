module.exports = {
  test: /\.js(\.erb)?$/,
  exclude: /node_modules/,
  loader: 'babel-loader',
  options: {
    plugins: [
      'transform-class-properties',
      'transform-object-rest-spread',
      'transform-decorators-legacy',
    ]
  }
}
