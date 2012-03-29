EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.EditView extends Backbone.View
  template: JST['backbone/templates/articles/edit']

  events:
    'submit #edit-article': 'update'
    'click #delete-btn': 'delete'

  update: (e) ->
    console.log 'edit view update'
    e.preventDefault()
    e.stopPropagation()

    @beforeSave()
    @model.save(null,
      success: (article) =>
        console.log 'success callback'
        @model = article
        window.location.hash = "/#{@model.id}"

      error: (article, jqXHR) =>
        console.log 'error callback'
        alert jqXHR.responseText
    )

  delete: ->
    if (confirm 'Are you sure you want to delete?')
      @model.destroy
        success: ->
          window.location.hash = "/index"
        error: ->
          alert 'Delete was not successful'

  beforeSave: ->
    $('#body').val $("[contenteditable='true']").html()
    $('#body').change()

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$('form').backboneLink(@model)

    return this
