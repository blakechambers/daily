'use strict'

App  = require 'app'

notesChannel = Backbone.Radio.channel('notes');

class Manager extends Backbone.Model
  defaults:
    state:           "break"
    start_time:      "0"
    duration:        25
    displayDuration: "25:00"
    message:         ""

  states:
    stopped:
      nextStates:   ["break"]
      timed:        false
    break:
      nextStates:   ["stopped", "started"]
      timed:        true
      duration:     5
      noteType:     "break"
      clearMessage: true
    started:
      nextStates:   ["stopped", "break"]
      timed:        true
      duration:     25
      noteType:     "sprint"

  isBreak: ->
    @is "break"

  isStopped: ->
    @is "stopped"

  isStarted: ->
    @is "started"

  is: (state) ->
    @get("state") == state

  isTimed: ->
    @states[@get("state")].timed

  hasNextState: (state) ->
    validNextStates = @states[@get("state")].nextStates

    _.indexOf(validNextStates, state) != -1

  start: ->
    # start_time = new Date()
    #
    # @save
    #   state:      "started"
    #   start_time: start_time
    @setState "started"

  stop: ->
    # start_time = moment(@get("start_time"))
    # end_time   = moment()
    # duration   = end_time - start_time
    #
    # notesChannel.request "new",
    #   type:       "pom",
    #   created:    start_time
    #   duration:   @displayDuration(duration + 1000)
    #   message:    @get("message")
    #
    # @save
    #   state:           "stopped"
    #   message:         ""
    #   displayDuration: @displayDuration((25 * 60 * 1000))
    @setState "stopped"

  setState: (state) ->
    throw "InvalidStateTransistion" unless @hasNextState(state)

    @exitCurrentState()

    nextState = @states[state]
    start_time  = new Date()

    opts =
      state:      state
      start_time: start_time

    if nextState.clearMessage
      opts.message         = ""
    if nextState.timed
      opts.duration        = nextState.duration
      opts.displayDuration = @displayDuration((nextState.duration * 60 * 1000))

    @save(opts)

  exitCurrentState: ->
    currentState = @states[@get("state")]

    if currentState.timed
      start_time = moment(@get("start_time"))
      end_time   = moment()
      duration   = end_time - start_time

      notesChannel.request "new",
        type:       currentState.noteType
        created:    start_time
        duration:   @displayDuration(duration + 1000)
        message:    @get("message")

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
