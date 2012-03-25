EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.ShowView extends Backbone.View
  template: JST['backbone/templates/articles/show']

  render: ->
    console.log 'show view render'
    that = @
    @model.fetch
      success: ->
        $(that.el).html(that.template(that.model.toJSON()))
    return this