'use strict'

class EventNote extends Backbone.Model
  defaults:
    created:  0
    duration: 0
    type:     "entry"

  initialize: ->
    if @isNew()
      @set
        created: Date.now()

module.exports = EventNote
