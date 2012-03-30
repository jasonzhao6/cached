EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.IndexView extends Backbone.View
  template: JST["backbone/templates/articles/index"]

  initialize: () ->
    @options.articles.bind('reset', @addAll) # do i need this?

  addAll: (articles) =>
    i = articles.length
    while i > 0
      @addOne articles.at(i - 1)
      i--

  addOne: (article) =>
    view = new EvernoteClone.Views.Articles.ArticleView({model : article})
    @$("#articles-table").append(view.render().el)

  addSearchBindingAndUI: ->
    searchView = new EvernoteClone.Views.Articles.SearchView()

    searchView.on 'search:success', =>
      console.log 'received search:success'
      articles = new EvernoteClone.Collections.ArticlesCollection()
      articles.reset searchView.searchResult
      @$('#articles-table').html('')
      @addAll articles

    searchView.on 'search:clear', =>
      @$('#articles-table').html('')
      @addAll @options.articles

    $(@el).prepend(searchView.render().el)

  render: =>
    $(@el).html(@template(articles: @options.articles.toJSON()))

    @addAll @options.articles
    
    @addSearchBindingAndUI()

    return this