'use strict'

class View extends Marionette.ItemView
  template: require("./templates/view")

  ui:
    start: ".start"
    stop:  ".stop"

  events:
    "click @ui.start" : "startTimer"
    "click @ui.stop"  : "stopTimer"

  startTimer: ->
    console.log "manager start timer"

    if @model.isStopped()
      @model.start()
      @render()
    else
      console.log "[Error] timer already started"

  stopTimer: ->
    console.log "manager start timer"

    if @model.isStarted()
      @model.stop()
      @render()
    else
      console.log "[Error] timer already stopped"

module.exports = View
