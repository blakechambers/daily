'use strict'

class View extends Marionette.ItemView
  template: require("./templates/view")
  prior_text: "foooooo"

  ui:
    clock:      ".clock"
    start:      ".start"
    stop:       ".stop"
    message:    ".message"
    messageIn:  ".messageIn"
    duration:   ".duration"

  events:
    "click @ui.start"     : "startTimer"
    "click @ui.stop"      : "stopTimer"
    "input @ui.messageIn" : "updateMessage"

  modelEvents:
    "change:message": "ping"


  ping: ->
    console.log "message change", @model.get("message")


  updateMessage: ->
    @model.set "message", @ui.messageIn.val()

  updateTimer: =>
    clock_text = @model.getUpdatedRemainingDuration()

    if clock_text != @prior_text
      @ui.clock.text(clock_text)
      @prior_text = clock_text

  setupTimer: ->
    @interval = setInterval @updateTimer, 33

  startTimer: ->
    if @model.isStopped()

      @model.start()
      @setupTimer()

      @render()
    else
      console.log "[Error] timer already started"

  stopTimer: ->
    if @model.isStarted()
      window.clearInterval @interval
      @model.stop()

      @render()
    else
      console.log "[Error] timer already stopped"

module.exports = View
