CACHE_NAME = 'todos-cache-v1'

# The files we want to cache
urlsToCache = [
  '/'
  '/styles/app.css'
  '/scripts/env.js'
]

@addEventListener 'install', (event) ->
  performCache = (cache) ->
    cache.addAll urlsToCache

  event.waitUntil caches.open(CACHE_NAME).then(performCache

@addEventListener 'push', (e) ->
  if !(@Notification and @Notification.permission == 'granted')
    console.error 'Failed to display notification - not supported'
  title = 'Why you no title?'

  registration.showNotification title

# self.addEventListener 'notificationclick', (event) ->
#   event.notification.close()
#
#   clients.openWindow 'http://localhost:9000'
@counter = 0
