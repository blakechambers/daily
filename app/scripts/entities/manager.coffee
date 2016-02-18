'use strict'

App  = require 'app'

notesChannel = Backbone.Radio.channel('notes');

class Manager extends Backbone.Model
  defaults:
    state:        "stopped"
    start_time:   "0"

  isStopped: ->
    @get("state") == "stopped"

  isStarted: ->
    @get("state") == "started"

  start: ->
    start_time = new Date()
    console.log "[Manager] starting...", start_time

    notesChannel.request "new",
      type:    "pom",
      created: start_time

    @set
      state:      "started"
      start_time: start_time

  stop: ->
    console.log "[Manager] stopping..."

    @set
      state:      "stopped"

App.reqres.setHandler "entities:manager", ->
  new Manager()
