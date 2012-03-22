require 'yaml'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  protected
  
  def current_user
    if !@current_user
      if session[:current_user]
        @current_user = session[:current_user]
      elsif cookies[:current_user_id]
        @current_user = User.find cookies[:current_user_id]
        if generate_key(@current_user) != cookies[:current_user_key]
          @current_user = nil
        end
      end
    end
    @current_user
  end
  
  def set_current_user user
    if user
      @current_user = session[:current_user] = user
      cookies[:current_user_id] = {value: user.id, expires: 30.days.from_now}
      cookies[:current_user_key] = {value: generate_key(user), expires: 30.days.from_now}
    else
      @current_user = session[:current_user] = nil
      cookies.delete :current_user_id
      cookies.delete :current_user_key
    end
  end
  
  def extract_first_error_message messages
    messages.select! {|k| (k.to_s =~ /_id\Z/) == nil } # do not display foreign id related errors (ex. 'hash_tag_id can't be blank').. assuming that there are attribute validators on the foreign model that will be redundant enough (ex. HashTag.hash_tag presence validator).. I actually tried to just get rid of foreign key validators all together since they are assumed to be redundant, but it created errors.. couldn't figure out why.. worth a second look some other day
    messages.map{|k, v| "#{k.to_s.capitalize.gsub(/\_/, ' ')} #{v.first}"}.first.to_s
  end
  
  private
  
  def generate_key user
    Digest::SHA1.hexdigest(user.created_at.to_s)[6,10]
  end
  
end