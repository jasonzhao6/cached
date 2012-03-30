class EvernoteClone.Routers.ArticlesRouter extends Backbone.Router
  initialize: (options) ->
    @navbars = {
      newArticle: JST['backbone/templates/navbars/new']
      index: JST['backbone/templates/navbars/index']
      indexDemo: JST['backbone/templates/navbars/index_demo']
      show: JST['backbone/templates/navbars/show']
      showDemo: JST['backbone/templates/navbars/show_demo']
      edit: JST['backbone/templates/navbars/edit']
    }

    @articles = new EvernoteClone.Collections.ArticlesCollection()
    @articles.reset options.articles

    EvernoteClone.currentUserId = @readCookie('current_user_id')

  routes:
    '/new'      : 'newArticle'
    '/index'    : 'index'
    '/:id/edit' : 'edit'
    '/:id'      : 'show'
    '.*'        : 'index'

  newArticle: ->
    $('#custom-nav').html(@navbars.newArticle)

    view = new EvernoteClone.Views.Articles.NewView(collection: @articles)
    $('#content').html(view.render().el)

  index: ->
    if (EvernoteClone.currentUserId)
      $('#custom-nav').html(@navbars.index)
    else
      $('#custom-nav').html(@navbars.indexDemo)

    view = new EvernoteClone.Views.Articles.IndexView(articles: @articles)
    $('#content').html(view.render().el)

  show: (id) ->
    if (EvernoteClone.currentUserId)
      $('#custom-nav').html(@navbars.show(id: id))
    else
      $('#custom-nav').html(@navbars.showDemo)

    article = @articles.get(id)
    article.fetch
      success: ->
        view = new EvernoteClone.Views.Articles.ShowView(model: article)
        $('#content').html(view.render().el)
        $('body').scrollTop(0)

  edit: (id) ->
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