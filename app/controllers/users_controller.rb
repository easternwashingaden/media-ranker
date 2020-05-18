class UsersController < ApplicationController
  def index
  end

  def show
  end

  def create
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      # New user
      user = User.new(name: params[:user][:name])
      if ! user.save
          flash[:error] = "Unable to login"
          redirect_to root_path
          return
      end
      flash[:welcome] = "Welcome #{user.name}"
    else
      # Existing User
      flash[:welcome] = "Welcome back #{user.name}"
    end

    session[:user_id] = user.id 
    redirect_to root_path
  end

  def logout 
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Goodby #{user.name}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end
end
