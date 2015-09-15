layoutTemplate = require './templates/layout'

class Layout extends Marionette.LayoutView
  template: layoutTemplate

  events:
    'click a': 'toLink'

  toLink: (e) ->
    console.log "testtest"
    return if (e.metaKey || e.ctrlKey || e.shiftKey)
    e.preventDefault()
    location = new URI()
    e.currentTarget
    uri  = new URI(e.currentTarget.href)

    if location.hostname() == uri.hostname()
      path = uri.pathname().replace(/^\//, '')
      path = "#{path}?#{uri.query()}" if uri.query()
      App.navigate path
    else
      window.open(uri, '_blank')

module.exports = Layout
