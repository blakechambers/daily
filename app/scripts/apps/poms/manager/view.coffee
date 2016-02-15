'use strict'

class View extends Marionette.ItemView
  template: require("./templates/view")
  prior_text: "foooo"

  ui:
    clock:    ".clock"
    start:    ".start"
    stop:     ".stop"
  message:    ".message"

  events:
    "click @ui.start" : "startTimer"
    "click @ui.stop"  : "stopTimer"

  updateTimer: =>
    duration = @endTime - Date.now()

    if duration >= 0
      duration = moment.duration(duration, 'milliseconds')

      clock_text = duration.minutes() + ':' + duration.seconds().pad()
    else
      duration = moment.duration((duration - 1000) * -1, 'milliseconds')
      clock_text = "-" + duration.minutes() + ':' + duration.seconds().pad()

    if clock_text != @prior_text
      @ui.clock.text(clock_text)
      @prior_text = clock_text

  setupTimer: ->
    @endTime  = moment(@model.get("start_time")) + (15 * 1000);
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
