class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = " Successfully created #{@work.category} #{@work.title}"
      redirect_to works_path
      return
    else
      flash.now[:error] = "Something went wrong. Work was NOT added 😞"
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      redirect_to works_path
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = " Successfully updated #{@work.category} #{@work.title}"
      redirect_to work_path(@work)
      return
    else 
      flash.now[:error] = "Something went wrong. Work cannot be updated 😞"
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif Vote.where(work_id: @work.id).count > 0
      Vote.where(work_id: @work.id).destroy_all
      @work.destroy
      flash[:success] = "Successfully deleted #{@work.category} #{@work.title}"
      redirect_to works_path
      return
    else
      @work.destroy
      flash[:success] = "Successfully deleted #{@work.category} #{@work.title}"
      redirect_to works_path
      return
    end
  end 
  
  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end

