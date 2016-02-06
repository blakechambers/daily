'use strict'

App  = require "app"
View = require "./view"

class Controller extends Marionette.Object

  initialize: ->
    @todos = App.request "todos:all"

  start: ->
    view = @getView
      collection: @todos

    App.root.showChildView "list", view

  getView: (options) ->
    new View
      collection: options.collection

App.on "start", ->
  controller = new Controller()
  controller.start()
  Backbone.history.start();

module.exports = Controller
