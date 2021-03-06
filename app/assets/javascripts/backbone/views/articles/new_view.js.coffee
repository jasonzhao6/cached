Cached.Views.Articles ||= {}

class Cached.Views.Articles.NewView extends Backbone.View
  template: JST["backbone/templates/articles/new"]

  events:
    "submit #new-article" : "save"
    "keydown [contenteditable='true']" : "clearPlaceholder"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @beforeSave()
    @model.unset("errors")

    collection = @collection
    @collection.create(@model.toJSON(),
      success: (article) =>
        window.location.hash = "/#{article.id}"

      error: (article, jqXHR) =>
        collection.remove article
        alert jqXHR.responseText
    )

  clearPlaceholder: ->
    $contentEditable = $("[contenteditable='true']")
    if $contentEditable.data('placeholder')
      $contentEditable.data('placeholder', false)
      $contentEditable.text('')

  beforeSave: ->
    @$('#body').val $("[contenteditable='true']").html()
    @$('#body').change()

  render: ->
    $(@el).html(@template(@model.toJSON()))

    @$("form").backboneLink(@model)

    return this