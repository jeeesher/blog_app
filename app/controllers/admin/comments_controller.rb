class Admin::CommentsController < ApplicationController
  before_action :require_admin
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = Comment.includes(:post, :user).order(created_at: :desc)

    # If coming from "Comments" action in post manager
    if params[:post_id].present?
      @comments = @comments.where(post_id: params[:post_id])
      @selected_post = Post.find(params[:post_id])
    end

    # Filter by author
    if params[:author_id].present?
      @comments = @comments.where(user_id: params[:author_id])
    end

    # Filter by post title
    if params[:post_id].present?
      @comments = @comments.where(post_id: params[:post_id])
    end

    # Filter by date posted
    if params[:start_date].present?
      start_date = Date.parse(params[:start_date]).beginning_of_day
      @comments = @comments.where("comments.created_at >= ?", start_date)
    end

    # Load all authors for dropdown filter
    @available_authors = User.joins(:comments).distinct.select(:id, :name).order(:name)
    # Load all posts for dropdown filter
    @available_posts = Post.joins(:comments).distinct.select(:id, :title).order(:title)
  end

  def edit
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: "Comment updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_path, notice: "Comment deleted successfully."
  end

  def destroy_all
    Comment.destroy_all
    redirect_to admin_comments_path, notice: "All comments have been deleted."
  end

  private

  def require_admin
    unless logged_in? && admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
