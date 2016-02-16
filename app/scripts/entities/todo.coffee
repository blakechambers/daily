class Todo extends Backbone.Model
  defaults:
    title: ''
    completed: false
    created: 0

  initialize: ->
    if @isNew()
      @set 'created', Date.now()

  toggle: ->
    @set 'completed', !@isCompleted()

  isCompleted: ->
    @get 'completed'

  matchesFilter: (filter) ->
    if filter == 'all'
      return true
    if filter == 'active'
      return !@isCompleted()

    @isCompleted()

module.exports = Todo
