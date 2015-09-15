View = require './view.coffee'

class Controller extends App.Controllers.Base

  initialize: ->
    @layoutView = @getLayoutView()
    @show @layoutView

  getLayoutView: ->
    new View()

module.exports = Controller
