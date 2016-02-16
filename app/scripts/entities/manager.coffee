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

    @set
      state:      "started"
      start_time: start_time

  getUpdatedRemainingDuration: ->
    endTime   = moment(@get("start_time")) + (@get("duration") * 60 * 1000)
    startTime = Date.now()
    duration = endTime - startTime
    @displayDuration duration

  displayDuration: (duration) ->

    if duration >= 0
      duration = moment.duration(duration, 'milliseconds')
      duration.minutes() + ':' + duration.seconds().pad()
    else
      duration = moment.duration((duration - 1000) * -1, 'milliseconds')
      "-" + duration.minutes() + ':' + duration.seconds().pad()

  stop: ->
    start_time = @get("start_time")
    end_time   = moment()
    duration   = end_time - start_time

    notesChannel.request "new",
      type:       "pom",
      created:    start_time
      duration:   @displayDuration(duration + 1000)
      message:    @get("message")

    @set
      state:           "stopped"
      start_time:      start_time
      displayDuration: @displayDuration((25 * 60 * 1000))

App.reqres.setHandler "entities:manager", ->
  new Manager()
