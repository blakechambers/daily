'use strict'

App  = require "app"

CollectionView = require "./collection_view"
NewView        = require "./new_view"

class Controller extends Marionette.Object

  initialize: ->
    @todos = App.request "todos:all"

  start: ->
    collectionView = @getCollectionView
      collection: @todos

    newView = @getNewView
      collection: @todos

    App.root.showChildView "newTodo", newView
    App.root.showChildView "todos",   collectionView

  getCollectionView: (options) ->
    new CollectionView
      collection: options.collection

  getNewView: (options) ->
    new NewView
      collection: options.collection

App.on "start", ->
  controller = new Controller()
  controller.start()
  Backbone.history.start();

module.exports = Controller
