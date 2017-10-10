class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method 'user_signed_in?', 'current_user', 'user_current', 'logged_in'

  def current_user
    session[:user]
  end

  def user_current
    user = User.find_by(current_user)
    return user
  end

  def user_signed_in?
    session[:user] != nil
  end

  def logged_in
    if !current_user
      flash[:success] = "Vous devez être connecté pour accéder a cette page"
      redirect_to login_user_path
    end
  end
end
