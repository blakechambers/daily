
class TodoView extends Marionette.ItemView
  template: require "./templates/todo"
  tagName: "li"
  className: "task"

  ui:
    destroy: ".destroy"

  events:
    "click @ui.destroy" : "destroyModel"

  destroyModel: ->
    @model.destroy()

class TodosView extends Marionette.CollectionView
  childView: TodoView
  tagName: "ol"

module.exports = TodosView
