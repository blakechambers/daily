'use strict'

class View extends Marionette.ItemView
  template: require("./templates/manager")
  prior_text: "foooooo"
  className:  "manager wrap"

  ui:
    clock:      ".clock"
    # start:      ".start"
    # stop:       ".stop"
    message:    ".message"
    messageIn:  ".messageIn"

  events:
    # "click @ui.start"     : "startTimer"
    # "click @ui.stop"      : "stopTimer"
    "input @ui.messageIn" : "updateMessage"
    "click .action"    : "transitionStateAction"

  onBeforeRender: ->
    console.log "before:render", @model.isTimed()
    @stopTimer()

  onRender: ->
    console.log "render", @model.isTimed()
    if @model.isTimed()
      @startTimer()

  transitionStateAction: (event) ->
    nextState =  @$el.find(event.currentTarget).attr("data-next-state")

    @model.setState(nextState)
    @render()

  updateMessage: ->
    @model.save
      message: @ui.messageIn.val()

  updateTimer: =>
    clock_text = @model.getUpdatedRemainingDuration()

    if clock_text != @prior_text
      @ui.clock.text(clock_text)
      @prior_text = clock_text

  startTimer: ->
    @stopTimer()
    @interval = setInterval @updateTimer, 33

  stopTimer: ->
    if @interval
      window.clearInterval @interval
      @interval = undefined

  isCurrentState: (state) =>
    @model.is(state)

  hasNextState: (state) =>
    @model.hasNextState(state)

  serializeData: ->
    _.extend super(),
      hasNextState:   @hasNextState
      isCurrentState: @isCurrentState

module.exports = View
