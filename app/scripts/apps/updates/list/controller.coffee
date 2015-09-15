View = require './view'
App  = require 'app'

class Controller extends App.Controllers.Base

  initialize: ->
    updates = App.request "entities:updates"

    @layoutView = @getLayoutView(updates)
    @show @layoutView

  getLayoutView: (updates)->
    new View
      collection: updates

module.exports = Controller
