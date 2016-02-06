class RootView extends Marionette.LayoutView
  template: require "./templates/root"

  el: "#main-region"

  regions:
    list: "#list-region"

module.exports = RootView
