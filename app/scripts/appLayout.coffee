App = require './app.coffee'
layoutTemplate = require './templates/layout.hamlc'

module.exports = class AppLayout extends Marionette.LayoutView
  template: layoutTemplate
