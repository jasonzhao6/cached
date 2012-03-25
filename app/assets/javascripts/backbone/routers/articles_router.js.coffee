class EvernoteClone.Routers.ArticlesRouter extends Backbone.Router
  initialize: (options) ->
    console.log 'routing initialize'
    @navbars = {
      newArticle: JST['backbone/templates/navbars/new']
      index: JST['backbone/templates/navbars/index']
      indexWhenLoggedOut: JST['backbone/templates/navbars/index_when_logged_out']
      show: JST['backbone/templates/navbars/show']
      edit: JST['backbone/templates/navbars/edit']
    }

    @articles = new EvernoteClone.Collections.ArticlesCollection()
    @articles.reset options.articles

    EvernoteClone.currentUserId = @readCookie('current_user_id')
    console.log 'logged in as user ' + EvernoteClone.currentUserId

  routes:
    '/new'      : 'newArticle'
    '/index'    : 'index'
    '/:id/edit' : 'edit'
    '/:id'      : 'show'
    '.*'        : 'index'

  newArticle: ->
    console.log 'routing new'
    $('#custom-nav').html(@navbars.newArticle)

    view = new EvernoteClone.Views.Articles.NewView(collection: @articles)
    $('#content').html(view.render().el)

  index: ->
    console.log 'routing index'
    if (EvernoteClone.currentUserId)
      $('#custom-nav').html(@navbars.index)
    else
      $('#custom-nav').html(@navbars.indexWhenLoggedOut)

    view = new EvernoteClone.Views.Articles.IndexView(articles: @articles)
    $('#content').html(view.render().el)

  show: (id) ->
    console.log 'routing show'
    $('#custom-nav').html(@navbars.show(id: id))

    article = @articles.get(id)
    article.fetch
      success: ->
        view = new EvernoteClone.Views.Articles.ShowView(model: article)
        $('#content').html(view.render().el)

  edit: (id) ->
    console.log 'routing edit'
    $('#custom-nav').html(@navbars.edit(id: id))

    article = @articles.get(id)
    article.fetch
      success: ->
        view = new EvernoteClone.Views.Articles.EditView(model: article)
        $('#content').html(view.render().el)

  # HELPER METHODS

  readCookie: (name) ->
    nameEQ = name + '='
    ca = document.cookie.split(';')
    i = 0
    while i < ca.length
      c = ca[i]
      c = c.substring(1, c.length)  while c.charAt(0) is ' '
      return c.substring(nameEQ.length, c.length)  if c.indexOf(nameEQ) is 0
      i++
    null