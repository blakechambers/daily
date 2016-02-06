'use strict'

RootView = require './views/root_view'

App = do (Backbone, Marionette) ->
  App = new Marionette.Application()


  App.on "before:start", ->
    App.root = new RootView
    App.root.render()

  App

module.exports = App
