ListController = require './list/controller'

App.addInitializer ->
  new ListController()
