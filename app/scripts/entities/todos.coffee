App  = require 'app'
Todo = require "./todo"

class Todos extends Backbone.Collection
  model:        Todo
  localStorage: new Backbone.LocalStorage('daily-todos-items')

  getCompleted: ->
    @filter @_isCompleted

  getActive: ->
    @reject @_isCompleted

  _isCompleted: (todo) ->
    todo.isCompleted()

App.reqres.setHandler "todos:all", ->
  todos = new Todos()
  todos.fetch()

  todos
