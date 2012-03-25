EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.ArticleView extends Backbone.View
  template: JST["backbone/templates/articles/article"]

  events:
    "click .destroy" : "destroy"

  tagName: "article"
  className: "well"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this
