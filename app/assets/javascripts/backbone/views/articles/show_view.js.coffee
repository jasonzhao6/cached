EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.ShowView extends Backbone.View
  template: JST["backbone/templates/articles/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
