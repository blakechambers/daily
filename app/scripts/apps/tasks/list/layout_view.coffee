layoutTemplate = require "./templates/layout"

class RootLayoutView extends Marionette.LayoutView
  template: layoutTemplate

  regions:
    todos: "#todos-region"

  initialize: (options)->
    @collection = options.collection

    @layout = @getCollectionView
      collection: collection

  onShow: ->
    @showChildView 'todos', @layout

  getCollectionView: (options) ->
    new TodosView
      collection: options.collection


module.exports = RootLayoutView
