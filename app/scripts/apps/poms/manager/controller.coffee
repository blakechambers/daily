'use strict'

App         = require "app"
ManagerView = require "./view"

class Controller extends Marionette.Object

  initialize: ->
    console.log "pom controller init"
    App.request "entities:manager", (manager)=>
      @manager = manager

      console.log "item", manager

      @view = new ManagerView
        model: @manager

  start: ->
    App.root.showChildView "manager", @view

App.on "start", ->
  controller = new Controller()
  controller.start()
