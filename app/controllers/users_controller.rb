class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      redirect_to users_path
      return
    end
  end
  
  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(name: params[:user][:name])

    if @user.nil?
      # New user
      @user = User.new(name: params[:user][:name])
      if ! @user.save
          flash.now[:error] = "A problem occurred: Could not log in"
          render :login_form, status: :bad_request
          return
      end
      flash[:success] = "Successfully created new user #{@user.name} with ID #{@user.id}"
    else
      # Existing User
      flash[:success] = "Successfully logged in as existing user #{@user.name}"
    end

    session[:user_id] = @user.id 
    redirect_to root_path
  end

  def logout 
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      unless @user.nil?
        session[:user_id] = nil
        flash[:success] = "Successfully logged out. Goodbye #{@user.name}"
      else
        session[:user_id] = nil
        flash[:notice] = "Error Unknown User"
      end
    else
      flash[:error] = "You must be logged in to logout"
    end
    redirect_to root_path
  end

  # The current method is not needed for this project but leave it here FFY
  # def current
  #   @user = User.find_by(id: session[:user_id])

  #   if @user.nil?
  #     flash[:error] = "You must be logged in to view this page"
  #     redirect_to root_path
  #     return
  #   end
  # end

  private
  def user_params
    return params.require(:user).permit(:name)
  end

end
