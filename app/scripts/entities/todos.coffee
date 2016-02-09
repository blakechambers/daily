App  = require 'app'
Todo = require "./todo"

class Todos extends Backbone.Collection
  model:        Todo
  localStorage: new Backbone.LocalStorage('daily-todos-items')

App.reqres.setHandler "todos:all", ->
  todos = new Todos()
  todos.fetch()

  todos
