_          = require 'underscore'
Backbone   = require 'backbone'
Backbone.$ = window.$
Marionette = require 'backbone.marionette'
Cocktail   = require 'cocktail'
URI        = require 'urijs'

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
window.Backbone        = Backbone
window.Marionette      = Marionette
window._               = _
window.URI             = URI
window.App             = require "./app"
window.App.Controllers = require "./lib/controllers"
window.App.CopyPaste   = require "./lib/copy_paste"

##################### load behaviors ###########################################

# Behaviors = {
#   ToLink : require 'behaviors/to_link'
# }
#
# window.Behaviors = Behaviors
# Marionette.Behaviors.behaviorsLookup = ->
#   window.Behaviors

##################### load entities ############################################

##################### load sub apps ############################################

require './apps/tasks'

################################################################################

$(document).ready ->
  App.start()
