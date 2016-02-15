class RootView extends Marionette.LayoutView
  template: require "./templates/root"

  el: "#main-region"

  regions:
    manager:  "section#manager"
    newTodo:  "section#new-todo"
    todos:    "section#todos"
    notes:    "section#notes"

module.exports = RootView
