class ArticlesController < ApplicationController
  before_filter :authenticated?, except: [:index, :show] # allow anonymous browsing of articles; currently, the only route enabled is '/demo'
  before_filter :inject_current_user_into_params, only: [:create, :update] # enforce correct current user, an alternative could be using mass assignment
  respond_to :json, except: :index
  
   # on error, return error message with 400, client should show error message
   # on success, return new article in json format, client should extract article id
  def create
    article = Article.create params['article']
    if article.invalid?
      render status: 400, inline: extract_first_error_message(article.errors.messages)
    else
      respond_with article
    end
  end
  
  def destroy
    article = Article.of(current_user).find params[:id]
    article.delete
    render nothing: true
  end
  
  # load all articles' titles into Backbone on start up
  def index
    # query = params[:q].try(:downcase)
    # if query.blank?
    #   @articles = Article.of(current_user).paginate(page: params[:page])
    # else
    #   @articles = Article.of(current_user).where('LOWER(title) like ?', "%#{query}%").paginate(page: params[:page])
    # end
    # if a user id is specified, list that user's articles; or if user is loggged in, display current user's articles
    if params[:user_id] || current_user
      @articles = Article.of(params[:user_id] || current_user).for_index.chronological # displayed in reverse by Backbone
    # otherwise, ask user to log in
    else 
      redirect_to login_path and return
    end
  end
  
  def show
    article = Article.find params[:id]
    article.body.gsub! /color:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /font-family:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /font-size:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /line-height:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /margin-top:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /margin-right:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /margin-bottom:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /margin-left:[a-z0-9, -.]+;/i, ''
    article.body.gsub! /width="[0-9]{3,}"/, 'width="100%"'
    respond_with article
  end
  
  # on error, return error message with 400, client should show error message
  # on success, return nothing with 204, client should redirect to :show
  def update
    article = Article.of(current_user).find params[:id] rescue render status: 500, inline: 'Article not found' and return
    # old_article = article.clone TODO used to update Redis index
    article.update_attributes params['article']
    if article.invalid?
      render status: 400, inline: extract_first_error_message(article.errors.messages)
    else
      render status: 204, nothing: true
    end
  end
  
  private
  
  def authenticated?
    if !current_user
      redirect_to login_path and return
    end
  end

  def inject_current_user_into_params
    params['article']['user'] = current_user
  end

end