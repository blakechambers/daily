_          = require 'underscore'
Backbone   = require 'backbone'
Backbone.$ = window.$
Marionette = require 'backbone.marionette'
Cocktail   = require 'cocktail'
URI        = require 'URIjs'

Cocktail.entendables = [
  Backbone.Model,
  Backbone.Collection,
  Backbone.Router,
  Backbone.View,
  Marionette.ItemView,
  Marionette.Controller,
  Marionette.CollectionView,
  Marionette.LayoutView
]

Cocktail.patch(Backbone)

Marionette.Behaviors.behaviorsLookup = ->
  window.Behaviors

# expose to window
window.Backbone   = Backbone
window.Marionette = Marionette
window._          = _
window.URI        = URI
window.App        = require "./app"

##################### load behaviors ###########################################

Behaviors = {
  ToLink : require 'behaviors/to_link'
}

window.Behaviors = Behaviors
Marionette.Behaviors.behaviorsLookup = ->
  window.Behaviors

##################### load entities ############################################

require 'entities/updates'

##################### load sub apps ############################################

require 'apps/updates/updates_app'

################################################################################

$(document).ready ->
  App.start()
