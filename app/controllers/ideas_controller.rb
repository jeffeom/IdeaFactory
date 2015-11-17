class IdeasController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  # before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :destroy]

  def new
    authenticate_user
    @idea = Idea.new
  end

  def create
    idea_params = params.require(:idea).permit(:title, :body)
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      redirect_to(idea_path(@idea), notice: "Idea Uploaded!")
    else
      render new
    end
  end

  def show
    @comment = Comment.new
    @idea = Idea.find params[:id]
  end

  def index
    @ideas = Idea.all
    @user = current_user
  end

  def edit
    @idea = Idea.find params[:id]
  end

  def update
    @idea = Idea.find params[:id]
    idea_params = params.require(:idea).permit([:title, :body, :join])
    if @idea.update(idea_params)
        # redirect_to idea_path(@idea), notice: "Idea Updated!"
        redirect_to ideas_path, notice: "Idea Updated!"
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find params[:id]
    @idea.destroy
    flash[:notice] = "Idea Deleted Successfully"
    redirect_to ideas_path
  end

  private

  # def find_idea
  #   @idea = Idea.find params[:id]
  # end

  def authorize
    redirect_to root_path, alert: "Access Denied!" unless can? :manage, @idea
  end
end
