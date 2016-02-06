App  = require 'app'
ListController = require './list/controller'

App.on "start" , ->
  controller = new ListController()
  controller.start()
