'use strict'

App  = require 'app'
View = require './view'

class Controller extends Marionette.Object

  initialize: ->
    @event_notes = App.request "entities:event_notes"

    @view = new View
      collection: @event_notes

  start: ->
    App.root.showChildView "notes", @view

App.on "start", ->
  controller = new Controller()
  controller.start()
