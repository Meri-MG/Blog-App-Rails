class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments.includes(:author)
    @likes = @post.likes.includes(:author)
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(new_post_params)
    @post.likes_counter = 0
    @post.comments_counter = 0
    respond_to do |format|
      format.html do
        if @post.save
          flash[:notice] = 'Post was created successfully.'
          redirect_to user_post_path(current_user.id, @post.id)
        else
          render 'new', status: :unprocessable_entity
        end
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post).permit(:title, :text))
  end

  def destroy
    post = Post.find(params[:post_id])
    post.author.decrement!(:posts_counter)
    post.destroy
    flash[:notice] = 'Post was deleted successfully.'
    redirect_to "/users/#{post.author.id}/posts"
  end

  private

  def new_post_params
    params.require(:post).permit(:title, :text)
  end
end
