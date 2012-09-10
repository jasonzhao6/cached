Cached.Views.Articles ||= {}

class Cached.Views.Articles.IndexView extends Backbone.View
  template: JST["backbone/templates/articles/index"]

  initialize: () ->
    @options.articles.bind('reset', @addArticles) # do i need this?

  addArticles: (articles) ->
    i = articles.length
    while i > 0
      view = new Cached.Views.Articles.ArticleView({model : articles.at(i - 1)})
      @$("#articles-table").append(view.render().el)
      i--

  addSearchBindingAndUI: ->
    searchView = new Cached.Views.Articles.SearchView()

    searchView.on 'search:success', =>
      articles = new Cached.Collections.ArticlesCollection()
      articles.reset searchView.searchResult
      @$('#articles-table').html('')
      @addArticles articles

    searchView.on 'search:clear', =>
      @$('#articles-table').html('')
      @addArticles @options.articles

    $(@el).prepend(searchView.render().el)

  render: ->
    $(@el).html(@template(articles: @options.articles.toJSON()))

    @addArticles @options.articles
    
    @addSearchBindingAndUI()

    return this