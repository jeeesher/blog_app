class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user).all.order(created_at: :desc)
  end

  def my_posts
    @posts = current_user.posts.order(created_at: :desc)
  end

  def show
    @comments = @post.comments.includes(:user)
    @comment = Comment.new # For comment form
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully!"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_post_owner
    unless current_user == @post.user || admin?
      flash[:alert] = "You are not authorized to modify this post."
      redirect_to @post
    end
  end
end
