'use strict'

class NoteView extends Marionette.ItemView
  template: require("./templates/note")
  tagName:  "li"

  ui:
    destroy: ".destroy"

  events:
    "click @ui.destroy" : "destroyModel"

  destroyModel: ->
    @model.destroy()

class NotesView extends Marionette.CollectionView
  childView: NoteView
  tagName:   "ul"
  className: "panel"

module.exports = NotesView
