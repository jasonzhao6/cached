EvernoteClone.Views.Articles ||= {}

class EvernoteClone.Views.Articles.IndexView extends Backbone.View
  template: JST["backbone/templates/articles/index"]

  initialize: () ->
    console.log 'index view initialize'
    @options.articles.bind('reset', @addAll)

  addAll: () =>
    console.log 'index view add all'
    i = @options.articles.length
    while i > 0
      @addOne @options.articles.at(i - 1)
      i--

  addOne: (article) =>
    console.log 'index view add one'
    view = new EvernoteClone.Views.Articles.ArticleView({model : article})
    @$("#articles-table").append(view.render().el)

  render: =>
    console.log 'index view render'
    $(@el).html(@template(articles: @options.articles.toJSON() ))
    @addAll()

    return this
