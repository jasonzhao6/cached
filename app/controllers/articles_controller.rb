class ArticlesController < ApplicationController
  before_filter :authenticated?, except: [:index]
  before_filter :inject_current_user_into_params, only: [:create, :update] # an alternative measure to this could be mass assignment
  before_filter :inject_current_user_into_params, only: [:create, :update] # an alternative way to enforce correct current user could be mass assignment
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
      @articles = Article.of(params[:user_id] || current_user).for_index
    # otherwise, ask user to log in
    else 
      redirect_to login_path and return
    end
  end
  
  def show
    article = Article.of(current_user).find params[:id]
    respond_with article
  end
  
  # on error, return error message with 400, client should show error message
  # on success, return nothing with 204, client should redirect to :show
  def update
    article = Article.of(current_user).find params[:id] rescue render status: 500, inline: 'Article not found' and return
    # old_article = article.clone TODO used to update Redis index
    params['article']['created_at'] = "#{params['created_at_date']} #{params['created_at_time']}"
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