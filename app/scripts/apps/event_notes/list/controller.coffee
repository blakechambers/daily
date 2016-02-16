'use strict'

App  = require 'app'
View = require './view'

class Controller extends Marionette.Object

  initialize: ->
    @event_notes = App.request "entities:event_notes"

    @notesChannel = Backbone.Radio.channel('notes');

    @notesChannel.reply "new", (args) =>
      @event_notes.create(args)

    @notesView = new View
      collection: @event_notes

  start: ->
    App.root.showChildView "notes", @notesView

App.on "start", ->
  controller = new Controller()
  controller.start()
