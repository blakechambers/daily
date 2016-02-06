App  = require 'app'
Todo = require "./todo"

Backbone.LocalStorage = require "backbone.localStorage"

class Todos extends Backbone.Collection
  model: Todo
  localStorage: new Backbone.LocalStorage('daily-todos-items')

App.reqres.setHandler "todos:all", ->
  todos = new Todos([])
  todos.fetch()
  console.log "todos from entities:", todos, Todo
  todos
