
class TodoView extends Marionette.ItemView
  template: require "./templates/todo"
  tagName: "li"

class TodosView extends Marionette.CollectionView
  childView: TodoView
  tagName: "ul"

module.exports = TodosView
