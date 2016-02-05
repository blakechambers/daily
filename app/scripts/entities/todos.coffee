Todo = require "./todo"
Backbone.LocalStorage = require "backbone.localstorage"

class Todos extends Backbone.Collection
  model: Todo
  localStorage: new Backbone.LocalStorage('daily-todos-items')
