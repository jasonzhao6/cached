Cached.Views.Articles ||= {}

class Cached.Views.Articles.ArticleView extends Backbone.View
  template: JST['backbone/templates/articles/article']

  events:
    'click' : 'show'

  show: () ->
    window.location.hash = "/#{@model.id}"

  render: ->
    $(@el).html(@template(@model.toJSON()))

    return this