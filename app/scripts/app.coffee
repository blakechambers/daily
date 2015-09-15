'use strict'

App = new Marionette.Application()

App.addRegions
  flashRegion:             "#flash-container"
  mainRegion:              "#main-region"

App.reqres.setHandler "default:region", ->
  App.mainRegion

App.navigate = (route, options = {}) ->
  # route = "#" + route if route.charAt(0) is "/"
  Backbone.history.navigate route, options

App.on 'start', ->
  Backbone.history.start
    pushState: true

module.exports = App
