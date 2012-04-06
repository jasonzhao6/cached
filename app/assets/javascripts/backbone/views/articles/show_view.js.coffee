EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.ShowView extends Backbone.View
  template: JST['backbone/templates/articles/show']

  render: ->
    $(@el).html(@template(@model.toJSON()))

    @$('img, iframe').each (i, el) -> $(el).wrap '<div style="text-align: center;" />'

    return this