Cached.Views.Articles ||= {}

class Cached.Views.Articles.ArticleView extends Backbone.View
  className: 'two-column'
    
  template: JST['backbone/templates/articles/article']

  events:
    'click' : 'show'

  show: (e) ->
    e.preventDefault()
    window.location.hash = "/#{@model.id}"

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @