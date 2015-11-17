class CommentsController < ApplicationController
  before_action :authenticate_user
  def create
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new(comment_params)
    @idea = Idea.find params[:idea_id]
    @comment.idea = @idea
    if @comment.save
      redirect_to idea_path(@idea), notice: "Comments created Successfully!"
    else
      render "ideas/show"
    end
  end

  def destroy
    comment = Comment.find params[:id]
    comment.destroy
    redirect_to idea_path(comment.idea), notice: "Comment Deleted!"
  end
end
