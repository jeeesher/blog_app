class Admin::PostsController < ApplicationController
  before_action :require_admin

  def index
    @posts = Post.includes(:user).order(created_at: :desc)

    # Search by title
    if params[:search].present?
      @posts = @posts.where("title ILIKE ?", "%#{params[:search]}%")
    end

    # Filter by author
    if params[:author_id].present?
      @posts = @posts.where(user_id: params[:author_id])
    end

    # Filter by date posted
    if params[:start_date].present?
      start_date = Date.parse(params[:start_date]).beginning_of_day
      @posts = @posts.where("posts.created_at >= ?", start_date)
    end

    # Load all authors for dropdown filter
    @authors =   
      User.joins(:posts)
        .distinct
        .select(:id, :name)
        .order(:name)
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
