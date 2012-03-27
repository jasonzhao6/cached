EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.NewView extends Backbone.View
  template: JST["backbone/templates/articles/new"]

  events:
    "submit #new-article": "save"
    "blur [contenteditable='true']": "beforeSubmit"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    console.log 'new view save'
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    collection = @collection
    @collection.create(@model.toJSON(),
      success: (article) =>
        console.log 'success callback'
        window.location.hash = "/#{article.id}"

      error: (article, jqXHR) =>
        console.log 'error callback'
        collection.remove article
        alert jqXHR.responseText
    )

  beforeSubmit: ->
    $('#body').val $("[contenteditable='true']").html()

  render: ->
    $(@el).html(@template(@model.toJSON()))

    this.$("form").backboneLink(@model)

    return this
