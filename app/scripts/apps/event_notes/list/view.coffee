'use strict'

class NoteView extends Marionette.ItemView
  template: require("./templates/note")
  tagName:  "li"

class NotesView extends Marionette.CollectionView
  childView: NoteView
  tagName:   "ul"
  className: "panel"

module.exports = NotesView
