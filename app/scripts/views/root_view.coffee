class RootView extends Marionette.LayoutView
  template: require "./templates/root"

  el: "#main-region"

  regions:
    newTodo:  "#new-todo-region"
    todos:    "#todos-region"

module.exports = RootView
