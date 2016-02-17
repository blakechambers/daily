'use strict'

class View extends Marionette.ItemView
  template: require("./templates/manager")
  prior_text: "foooooo"
  className:  "manager wrap"

  ui:
    clock:      ".clock"
    start:      ".start"
    stop:       ".stop"
    message:    ".message"
    messageIn:  ".messageIn"

  events:
    "click @ui.start"     : "startTimer"
    "click @ui.stop"      : "stopTimer"
    "input @ui.messageIn" : "updateMessage"

  onBeforeRender: ->
    if @model.isTimed()
      window.clearInterval @interval if @interval
  onRender: ->
    if @model.isTimed()
      @setupTimer()

  updateMessage: ->
    @model.save
      message: @ui.messageIn.val()

  updateTimer: =>
    clock_text = @model.getUpdatedRemainingDuration()

    if clock_text != @prior_text
      @ui.clock.text(clock_text)
      @prior_text = clock_text

  setupTimer: ->
    @interval = setInterval @updateTimer, 33

  startTimer: ->
    if @hasNextState("started")

      @model.start()
      @setupTimer()

      @render()
    else
      console.log "[Error] timer already started"

  stopTimer: ->
    if @hasNextState("stopped")
      window.clearInterval @interval
      @model.stop()

      @render()
    else
      console.log "[Error] timer already stopped"

  hasNextState: (state) =>
    @model.hasNextState(state)

  serializeData: ->
    _.extend super(),
      nextState: @hasNextState

module.exports = View
