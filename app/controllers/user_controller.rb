class UserController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_user_path
    else
      flash[:error] = "Corriger vos erreurs"
      render 'new'
    end
  end

  def login
    if params[:username]
      username, password = params[:username], params[:password]

      @user = User.authenticate username, password

      if @user
        session[:user] = @user
        flash[:success] = "Connecté"

        redirect_to '/'
      else
        flash[:error] = "Nom d'utilisateur ou mot de passe incorrect"
      end
    end
  end

  def logout
    session[:user] = nil
    redirect_to new_user_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
