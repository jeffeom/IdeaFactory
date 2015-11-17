class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    like          = Like.new
    idea     = Idea.find params[:idea_id]
    like.idea = idea
    like.user     = current_user
    if like.save
      redirect_to ideas_path, notice: "Thanks for liking!"
    else
      redirect_to ideas_path, alert: "Can't like! Liked already?"
    end
  end

  def destroy
    idea = Idea.find params[:idea_id]
    like     = current_user.likes.find params[:id]
    like.destroy
    redirect_to ideas_path, notice: "Like removed!"
  end
end
