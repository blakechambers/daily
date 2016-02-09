Backbone.$ = window.$

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

##################### load behaviors ###########################################

# Behaviors = {
#   ToLink : require 'behaviors/to_link'
# }
#
# window.Behaviors = Behaviors
# Marionette.Behaviors.behaviorsLookup = ->
#   window.Behaviors

##################### load entities ############################################

require './entities/todos'

##################### load sub apps ############################################

require './apps/tasks/list/controller'

##################### service worker ###########################################

if 'serviceWorker' of navigator
  navigator.serviceWorker.register('/sw.js').then((registration) ->
    # console.log 'registration success', registration.scope

    return
  ).catch (err) ->
    # console.log 'ServiceWorker registration failed: ', err

  navigator.serviceWorker.ready.then (registration) ->
    # console.log "init subscription"

    registration.pushManager.subscribe({userVisibleOnly: true}).then((pushSubscription) ->
      # console.log 'subscription success', registration.scope

      return
    ).catch (e) ->
      # console.error 'Unable to register for push', e

##################### start some things ########################################

app = require("./app")
app.start()
