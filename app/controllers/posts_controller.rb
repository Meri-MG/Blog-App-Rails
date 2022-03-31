class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments.includes(:author)
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text))
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post).permit(:title, :text))
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end
end
