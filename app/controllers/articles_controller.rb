class ArticlesController < ApplicationController
  before_filter :authenticated?
  before_filter :inject_current_user_into_params, only: [:create, :update] # an alternative measure to this could be mass assignment
  
   # on error, return error message with 400, client should show error message
   # on success, return nothing with 200, client should redirect to homepage
  def create
    article = Article.create params['article']
    if article.invalid?
      render status: 400, inline: extract_first_error_message(article.errors.messages)
    else
      render status: 200, inline: article.id.to_s
    end
  end
  
  def destroy
    article = Article.of(current_user).find params[:id]
    article.delete
  end
  
  def edit
    @article = Article.of(current_user).find params[:id]
  end

  # show all tweets; handle search queries and pagination
  def index
    # query = params[:q].try(:downcase)
    # if query.blank?
    #   @articles = Article.of(current_user).paginate(page: params[:page])
    # else
    #   @articles = Article.of(current_user).where('LOWER(title) like ?', "%#{query}%").paginate(page: params[:page])
    # end
    @articles = Article.all
  end
  
  def new; end
  
  def show
    @article = Article.of(current_user).find params[:id]
  end
  
  # on error, return error message with 400, client should show error message
  # on success, return nothing with 200, client should redirect to either :show or :index
  def update
    article = Article.of(current_user).find params[:id] rescue render status: 500, inline: 'Article not found' and return
    # old_article = article.clone TODO used to update Redis index
    params['article']['created_at'] = "#{params['created_at_date']} #{params['created_at_time']}"
    article.update_attributes params['article']
    if article.invalid?
      render status: 400, inline: extract_first_error_message(article.errors.messages)
    else
      render status: 200, nothing: true
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