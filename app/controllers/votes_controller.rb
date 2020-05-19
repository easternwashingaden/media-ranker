class VotesController < ApplicationController
  def show
    @vote = Vote.find_by(id: params[:id])
    head :not_found if @vote.nil?
    return
  end

  def create
    # Check if there is a user logged in
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @work = Work.find_by(id: params[:work_id])
      user_voted_works_list = @user.votes.map {|vote| vote.work_id }
      
      if user_voted_works_list.include?(@work.id)
        flash[:warning] = "user: has already voted for this work"
        redirect_to works_path
      else
        @vote = Vote.new(
          user_id: @user.id,
          work_id: @work.id
        )
        if @vote.save
          flash[:success] = "Successfully upvoted"
          redirect_to works_path
          return
        end
      end
    else
      flash[:error] = "You have to log in order to upvote"
      redirect_to works_path
      return
    end
  end

  

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end 
end
