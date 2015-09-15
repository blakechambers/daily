ListController = require './list/controller'

class Router extends Marionette.AppRouter
    appRoutes:
      ''   : 'list'

  API =
    list: ->
      new ListController()

App.addInitializer ->
  new Router
    controller: API
