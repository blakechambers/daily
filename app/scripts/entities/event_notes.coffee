'use strict'

App       = require "app"
EventNote = require "./event_note"

class EventNotes extends Backbone.Collection
  model: EventNote

  localStorage: new Backbone.LocalStorage('daily-event-notes'),

  comparator: 'created'

App.reqres.setHandler "todos:all", ->
  notes = new EventNotes()
  notes.fetch()

  notes
