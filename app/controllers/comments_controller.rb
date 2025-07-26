class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment_owner, only: [:edit, :update, :destroy]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Comment added successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment deleted successfully!"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_comment_owner
    unless current_user == @comment.user || admin?
      flash[:alert] = "You are not authorized to modify this comment."
      redirect_to post_path(@post)
    end
  end
end
