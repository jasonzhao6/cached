class EvernoteClone.Models.Article extends Backbone.Model
  paramRoot: 'article'

  defaults:
    title: null
    body: null

class EvernoteClone.Collections.ArticlesCollection extends Backbone.Collection
  model: EvernoteClone.Models.Article
  url: '/articles'
