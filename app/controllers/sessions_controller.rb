class SessionsController < ApplicationController
  before_filter :set_current_user_to_null # if the user is doing anything related to session, log user out first
  
  def actually_login
    render status: 400, inline: 'Email can\'t be blank' and return if params[:email].blank?
    render status: 400, inline: 'Password can\'t be blank' and return if params[:password].blank?
    user = User.find_by_email params[:email]
    if !user
      render status: 400, inline: 'Email not found' and return
    elsif user.password != params[:password]
      render status: 400, inline: 'Incorrect password' and return
    else
      set_current_user user
      render status: 200, nothing: true
    end
  end
  
  def sign_up
    render status: 400, inline: 'Email can\'t be blank' and return if params[:email].blank?
    render status: 400, inline: 'Password can\'t be blank' and return if params[:password].blank?
    render status: 400, inline: 'Password too short' and return if params[:password].length < 4
    render status: 400, inline: 'Account already exist' and return if User.find_by_email params[:email]
    user = User.create(email: params[:email], password: params[:password])
    if user.invalid?
      render status: 400, inline: extract_first_error_message(user.errors.messages)
    else
      set_current_user user
      render status: 200, nothing: true
    end
  end
  
  def logout
    redirect_to login_path
  end
  
  private
  
  def set_current_user_to_null
    set_current_user nil
  end
end