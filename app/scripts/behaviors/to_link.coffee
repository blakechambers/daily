class ToLink extends Marionette.Behavior

  events:
    "click a" : "toLink"

  toLink: (e) ->
    return if (e.metaKey || e.ctrlKey || e.shiftKey)
    e.preventDefault()
    location = new URI()
    e.currentTarget
    uri  = new URI(e.currentTarget.href)

    if location.hostname() == uri.hostname()
      path = uri.pathname().replace(/^\//, '')
      path = "#{path}?#{uri.query()}" if uri.query()
      App.navigate path, trigger: true
    else
      window.open(uri, '_blank')

module.exports = ToLink
