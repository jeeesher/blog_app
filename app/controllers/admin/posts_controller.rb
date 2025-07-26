class Admin::PostsController < ApplicationController
  before_action :require_admin

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: "Post deleted successfully."
  end

  private

  def require_admin
    unless logged_in? && admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
