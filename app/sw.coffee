CACHE_NAME = 'todos-cache-v1'

# The files we want to cache
urlsToCache = [
  '/'
  '/styles/app.css'
  '/scripts/env.js'
]

# Set the callback for the install step
@addEventListener 'install', (event) ->
  # Perform install steps
  event.waitUntil caches.open(CACHE_NAME).then((cache) ->
    # console.log 'Opened cache'
    cache.addAll urlsToCache
  )

@addEventListener 'push', (e) ->
  # console.log 'Push Event Received', e
  if !(@Notification and @Notification.permission == 'granted')
    console.error 'Failed to display notification - not supported'
  title = 'Why you no title?'

  registration.showNotification title

self.addEventListener 'notificationclick', (event) ->
  event.notification.close()

  clients.openWindow 'http://localhost:9000'
  #   # Example: Open window after 3 seconds.
  #   # (doing so is a terrible user experience by the way, because
  #   #  the user is left wondering what happens for 3 seconds.)
  #   promise = new Promise((resolve) ->
  #     setTimeout resolve, 1000
  #     return
  # ).then(->
  #     clients.openWindow 'https://localhost:9000'
  #   )
  #   # Now wait for the promise to keep the permission alive.
  #   event.waitUntil promise
  #   return
  #
@counter = 0

# timer = ->
#   @counter += 1
#   console.log "ping #{counter}"


# setInterval timer, 20000
