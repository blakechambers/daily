window.Backbone   = require 'backbone'
window.Marionette = require 'backbone.marionette'

App = require "./app.coffee"
$(document).ready ->
  App.start()
