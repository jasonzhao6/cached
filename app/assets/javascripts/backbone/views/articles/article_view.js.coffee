EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.ArticleView extends Backbone.View
  template: JST['backbone/templates/articles/article']

  events:
    'click' : 'show'

  tagName: 'article'
  className: 'well'

  show: () ->
    window.location.hash = "/#{@model.id}"

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this
