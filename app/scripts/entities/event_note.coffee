'use strict'

class EventNote extends Backbone.Model
  defaults:
    created:  0
    duration: 0

  initialize: ->
    if @isNew()
      @set
        created: Date.now()
