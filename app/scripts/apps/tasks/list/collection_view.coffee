
class TodoView extends Marionette.ItemView
  template: require "./templates/todo"
  tagName: "li"

  ui:
    destroy: ".destroy"

  events:
    "click @ui.destroy" : "destroyModel"

  destroyModel: ->
    @model.destroy()

class TodosView extends Marionette.CollectionView
  childView: TodoView
  tagName: "ul"

module.exports = TodosView
