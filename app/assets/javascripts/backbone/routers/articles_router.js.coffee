class EvernoteClone.Routers.ArticlesRouter extends Backbone.Router
  initialize: (options) ->
    console.log 'routing initialize'
    @articles = new EvernoteClone.Collections.ArticlesCollection()
    @articles.reset options.articles
    EvernoteClone.currentUserId = @readCookie('current_user_id')
    console.log 'logged in as user ' + EvernoteClone.currentUserId

  routes:
    "/new"      : "newArticle"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newArticle: ->
    console.log 'routing new'
    @view = new EvernoteClone.Views.Articles.NewView(collection: @articles)
    $("#content").html(@view.render().el)

  index: ->
    console.log 'routing index'
    @view = new EvernoteClone.Views.Articles.IndexView(articles: @articles)
    $("#content").html(@view.render().el)

  show: (id) ->
    console.log 'routing show'
    article = @articles.get(id)

    @view = new EvernoteClone.Views.Articles.ShowView(model: article)
    $("#content").html(@view.render().el)

  edit: (id) ->
    console.log 'routing edit'
    article = @articles.get(id)

    @view = new EvernoteClone.Views.Articles.EditView(model: article)
    $("#content").html(@view.render().el)

  readCookie: (name) ->
    nameEQ = name + "="
    ca = document.cookie.split(";")
    i = 0
    while i < ca.length
      c = ca[i]
      c = c.substring(1, c.length)  while c.charAt(0) is " "
      return c.substring(nameEQ.length, c.length)  if c.indexOf(nameEQ) is 0
      i++
    null