
class TodoView extends Marionette.ItemView
  template: require "./templates/todo"
  tagName: "li"
  className: "task wrap"

  ui:
    destroy:  ".destroy"
    checkbox: ".checkbox"

  events:
    "click @ui.destroy"  : "destroyModel"
    "click @ui.checkbox" : "toggle"

  destroyModel: ->
    @model.destroy()

  toggle: ->
    console.log "toggle"

    @model.toggle().save()
    @render()

class TodosView extends Marionette.CollectionView
  childView: TodoView
  tagName: "ol"

module.exports = TodosView
