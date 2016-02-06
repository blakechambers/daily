'use strict'

RootView    = require './views/root_view'

class TodoApp extends Marionette.Application
  setRootLayout: ->
    @root = new RootView()

App = new TodoApp()

App.on "before:start", ->
  App.setRootLayout()
  App.root.render()

module.exports = App
