'use strict'

App = do (Backbone, Marionette) ->
  App = new Marionette.Application()

  App.addRegions
    flashRegion:             "#flash-container"
    mainRegion:              "#main-region"

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  App.navigate = (route, options = {}) ->
    Backbone.history.navigate route, options

  App.Controllers = require "./lib/controllers"

  App.on 'start', ->
    Backbone.history.start
      pushState: true

  App

module.exports = App
