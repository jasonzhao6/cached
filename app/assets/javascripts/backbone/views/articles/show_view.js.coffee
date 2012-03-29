EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.ShowView extends Backbone.View
  template: JST['backbone/templates/articles/show']

  id: 'article-show'

  render: ->
    console.log 'show view render'
    $(@el).html(@template(@model.toJSON() ))

    return this