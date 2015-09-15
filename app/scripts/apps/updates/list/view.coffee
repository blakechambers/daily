layoutTemplate = require './templates/layout'
itemTemplate   = require './templates/item'

class UpdateView extends Marionette.ItemView
  tagName:   "li"
  className: "update"
  template:  itemTemplate

  modelEvents:
    "change:visited" : "render"

  events:
    "click @ui.headline" : "markVisited"

  ui:
    headline : ".headline"

  markVisited: ->
    @model.set "visited", true

class UpdatesView extends Marionette.CollectionView
  childView:  UpdateView
  className: "updates"
  tagName:   "ol"

class Layout extends Marionette.LayoutView
  template: layoutTemplate

  regions:
    updatesRegion: ".updates-container"

  initialize: (options) ->
    @updatesView = @getUpdatesView(options.collection)

  onShow: ->
    @updatesRegion.show @updatesView

  getUpdatesView: (collection) ->
    new UpdatesView
      collection: collection

module.exports = Layout
