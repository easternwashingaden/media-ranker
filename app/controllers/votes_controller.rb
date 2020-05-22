class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def create
    # Check if there is a user logged in
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @work = Work.find_by(id: params[:work_id])
    
      @vote = Vote.new(
        user_id: @user.id,
        work_id: @work.id
      )
      if @vote.save
        flash[:success] = "Successfully upvoted"
        redirect_to works_path
        return
      else
        flash[:warning] = "A problem occurred: Could not upvote. The user has already voted for this work."
        redirect_to works_path
        return
      end
    else
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to works_path
      return
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end 
end
