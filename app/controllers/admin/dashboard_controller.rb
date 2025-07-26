class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @recent_posts = Post.order(created_at: :desc).limit(3)
    @recent_comments = Comment.includes(:post, :user).order(created_at: :desc).limit(3)
  end

  private

  def require_admin
    unless logged_in? && admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
