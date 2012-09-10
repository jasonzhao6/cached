class Cached.Models.Article extends Backbone.Model
  paramRoot: 'article'

  defaults:
    title: null
    body: null

class Cached.Collections.ArticlesCollection extends Backbone.Collection
  model: Cached.Models.Article
  url: '/articles'
