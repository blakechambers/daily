ListController = require './list/controller.coffee'

class Router extends Marionette.AppRouter
    appRoutes:
      ''   : 'list'

  API =
    list: ->
      new ListController()

App.addInitializer ->
  new Router
    controller: API
