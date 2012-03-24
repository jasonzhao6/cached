class EvernoteClone.Routers.ArticlesRouter extends Backbone.Router
  initialize: (options) ->
    @articles = new EvernoteClone.Collections.ArticlesCollection()
    @articles.reset options.articles

  routes:
    "/new"      : "newArticle"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newArticle: ->
    console.log 'routing new'
    @view = new EvernoteClone.Views.Articles.NewView(collection: @articles)
    $("#articles").html(@view.render().el)

  index: ->
    console.log 'routing index'
    @view = new EvernoteClone.Views.Articles.IndexView(articles: @articles)
    $("#articles").html(@view.render().el)

  show: (id) ->
    console.log 'routing show'
    article = @articles.get(id)

    @view = new EvernoteClone.Views.Articles.ShowView(model: article)
    $("#articles").html(@view.render().el)

  edit: (id) ->
    console.log 'routing edit'
    article = @articles.get(id)

    @view = new EvernoteClone.Views.Articles.EditView(model: article)
    $("#articles").html(@view.render().el)
