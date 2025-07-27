class Admin::PostsController < ApplicationController
  before_action :require_admin
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)

    # Search by title or author name
    if params[:search].present?
      query = "%#{params[:search]}%"
      @posts = @posts.joins(:user)
                      .where("LOWER(posts.title) LIKE LOWER(?) OR LOWER(users.name) LIKE LOWER(?)", query, query)
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

  def show
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html do
        redirect_to admin_posts_path, notice: "Post deleted successfully."
      end

      format.turbo_stream do
        if request.referer&.include?(admin_posts_path) 
          render turbo_stream: turbo_stream.remove(@post)
        else
          render turbo_stream: turbo_stream.redirect(admin_posts_path)
        end
      end
    end
  end

  def destroy_all
    Post.destroy_all
    redirect_to admin_posts_path, notice: "All posts and their comments have been deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def require_admin
    unless logged_in? && admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
