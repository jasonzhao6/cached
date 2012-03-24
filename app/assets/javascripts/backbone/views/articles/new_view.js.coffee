EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.NewView extends Backbone.View
  template: JST["backbone/templates/articles/new"]

  events:
    "submit #new-article": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (article) =>
        @model = article
        window.location.hash = "/#{@model.id}"

      error: (article, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
