EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.IndexView extends Backbone.View
  template: JST["backbone/templates/articles/index"]

  events:
    'keyup #search-field': 'delayedSearch'
    'click #clear-search-btn': 'clearSearch'
    'submit #search': 'searchFormSubmit'

  delayedSearch: ->
    $clearSearch = @$('#clear-search-btn')
    if typeof (@searchId) is "number"
      clearTimeout @searchId
      @searchId = null
    @searchId = setTimeout(@search, 450)

  clearSearch: ->
    $searchField = @$('#search-field')
    if ($searchField.val().length > 0)
      $searchField.val('')
      @search()

  searchFormSubmit: (e) ->
    alert 'uu'
    e.preventDefault()

  search: =>
    console.log 'searching'
    $searchField = @$('#search-field')
    $.ajax
      url: "/search?q=" + escape($searchField.val())
      success: (data) =>
        articles = new EvernoteClone.Collections.ArticlesCollection()
        articles.reset data
        @options.articles = articles
        @render $searchField.val()

  initialize: () ->
    @options.articles.bind('reset', @addAll)

  addAll: () =>
    i = @options.articles.length
    while i > 0
      @addOne @options.articles.at(i - 1)
      i--

  addOne: (article) =>
    view = new EvernoteClone.Views.Articles.ArticleView({model : article})
    @$("#articles-table").append(view.render().el)

  render: (searchTerm) =>
    console.log 'index view render'
    $(@el).html(@template(q: searchTerm || ''))
    @addAll()

    return this
