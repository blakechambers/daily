'use strict'

App  = require 'app'

notesChannel = Backbone.Radio.channel('notes');

class Manager extends Backbone.Model
  defaults:
    state:           "stopped"
    start_time:      "0"
    duration:        25
    displayDuration: "25:00"
    message:         ""

  isStopped: ->
    @get("state") == "stopped"

  isStarted: ->
    @get("state") == "started"

  start: ->
    start_time = new Date()

    @save
      state:      "started"
      start_time: start_time

  getFinishTime: ->
    moment(@get("start_time")) + (@get("duration") * 60 * 1000)

  getUpdatedRemainingDuration: ->
    end_time   = @getFinishTime()
    start_time = moment()
    duration   = end_time - start_time

    @displayDuration duration

  displayDuration: (duration) ->

    if duration >= 0
      duration = moment.duration(duration, 'milliseconds')
      duration.minutes() + ':' + duration.seconds().pad()
    else
      duration = moment.duration((duration - 1000) * -1, 'milliseconds')
      "-" + duration.minutes() + ':' + duration.seconds().pad()

  stop: ->
    start_time = moment(@get("start_time"))
    end_time   = moment()
    duration   = end_time - start_time

    console.log "stopping", end_time, start_time, duration

    notesChannel.request "new",
      type:       "pom",
      created:    start_time
      duration:   @displayDuration(duration + 1000)
      message:    @get("message")

    @save
      state:           "stopped"
      message:         ""
      displayDuration: @displayDuration((25 * 60 * 1000))

notesChannel = Backbone.Radio.channel('notes');

class Managers extends Backbone.Collection
  model:        Manager
  localStorage: new Backbone.LocalStorage('daily-manager')

App.reqres.setHandler "entities:manager", (callback) ->
  collection = new Managers()
  collection.fetch
    success: (coll) ->
      firstItem = coll.first() || coll.create()

      callback firstItem

  null
