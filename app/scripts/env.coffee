window._          = require 'underscore'
window.Backbone   = require 'backbone'
window.Marionette = require 'backbone.marionette'
window.URI        = require 'URIjs'

window.App = require "./app.coffee"

window.App.Controllers = {}
window.App.Controllers.Base = require "./lib/controllers/base.coffee"

UpdatesApp = require './apps/updates/updates_app.coffee'

$(document).ready ->
  App.start()
