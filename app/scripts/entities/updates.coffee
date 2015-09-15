Update = require './update'
App    = require 'app'

class Updates extends Backbone.Collection
  model: Update
  url:   'http://localhost:3000/api/v2/top.json'

  parse: (data) ->
    data.updates

App.reqres.setHandler "entities:updates", ->
  updates = new Updates([])
  updates.fetch
    data:
      limit: 15 

  updates

module.exports = Updates
