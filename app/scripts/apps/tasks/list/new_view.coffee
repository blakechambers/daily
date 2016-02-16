class NewTodoView extends Marionette.ItemView
  template: require "./templates/new"
  className: "new-todo wrap"

  ui:
    input: "#newText"

  events:
    "keypress @ui.input"  : "onInputKeypress"
    "keyup @ui.input"     : "onInputKeyup"

  onInputKeyup: (e) ->
    ESC_KEY = 27
    if e.which == ESC_KEY
      @render()

  onInputKeypress: (e) ->
    ENTER_KEY = 13
    todoText = @ui.input.val().trim()
    if e.which == ENTER_KEY and todoText
      @collection.create
        title:   todoText
        created: Date.now()
      @ui.input.val ''

module.exports = NewTodoView
