class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Proszę się zalogować"
      redirect_to login_url
    end
  end
  
end