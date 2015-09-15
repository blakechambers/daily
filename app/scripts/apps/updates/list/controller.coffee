View = require './view'

class Controller extends App.Controllers.Base

  initialize: ->
    @layoutView = @getLayoutView()
    @show @layoutView

  getLayoutView: ->
    new View()

module.exports = Controller
