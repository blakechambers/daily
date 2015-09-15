View = require './view'
App  = require 'app'

class Controller extends App.Controllers.Base

  initialize: ->
    updates = App.request "entities:updates"

    @layoutView = @getLayoutView()
    @show @layoutView

  getLayoutView: ->
    new View()

module.exports = Controller
