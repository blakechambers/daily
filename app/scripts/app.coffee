AppLayout  = require './appLayout.coffee'

App = new Marionette.Application()

App.on 'start', ->
  'use strict'

  App.rootLayout = new AppLayout
    el: '#demo'
  App.rootLayout.render()

module.exports = App
