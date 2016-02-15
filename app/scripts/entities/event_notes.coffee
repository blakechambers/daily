'use strict'

App       = require "app"
EventNote = require "./event_note"

notesChannel = Backbone.Radio.channel('notes');

class EventNotes extends Backbone.Collection
  model: EventNote

  localStorage: new Backbone.LocalStorage('daily-event-notes'),

  comparator: 'created'

App.reqres.setHandler "entities:event_notes", ->
  notes = new EventNotes()
  notes.fetch()

  notes
