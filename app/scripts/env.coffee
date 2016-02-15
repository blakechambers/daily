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
require './entities/event_notes'
require './entities/manager'

##################### load sub apps ############################################

require './apps/tasks/list/controller'
require './apps/event_notes/list/controller'
require './apps/poms/manager/controller'

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

##### other junk ####

# eventTime = 1366549200
# # Timestamp - Sun, 21 Apr 2013 13:00:00 GMT
# currentTime = 1366547400
# # Timestamp - Sun, 21 Apr 2013 12:30:00 GMT
# diffTime = eventTime - currentTime
# duration = moment.duration(diffTime * 1000, 'milliseconds')
# interval = 1000
#
Number.prototype.pad = (size) ->
  s = String(this)
  while s.length < (size or 2)
    s = '0' + s
  s
#
# setInterval (->
#   duration = moment.duration(duration - interval, 'milliseconds')
#   $('.countdown').text duration.minutes() + ':' + duration.seconds().pad()
#   return
# ), interval

##################### start some things ########################################

app = require("./app")
app.start()
