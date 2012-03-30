EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.SearchView extends Backbone.View
  template: JST["backbone/templates/articles/search"]

  events:
    'submit #search': 'searchFormSubmit'
    'keyup #search-field': 'delayedSearch'
    'click #clear-search-btn': 'clearSearch'

  searchFormSubmit: (e) ->
    e.preventDefault()

  search: =>
    $searchFieldVal = @$('#search-field').val();
    if ($searchFieldVal.length > 0)
      $.ajax
        url: "/search?q=" + escape($searchFieldVal)
        success: (data) =>
          @searchResult = data
          console.log 'trigger search:success'
          @trigger 'search:success'
    else
      @trigger 'search:clear'

  delayedSearch: ->
    if typeof (@searchId) is "number"
      clearTimeout @searchId
      @searchId = null
    @searchId = setTimeout(@search, 450)

  clearSearch: ->
    $searchField = @$('#search-field')
    if ($searchField.val().length > 0)
      $searchField.val('')
      @search()

  render: =>
    window.bar = @
    $(@el).html(@template())

    return this