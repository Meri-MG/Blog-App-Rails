class LikesController < ApplicationController
  before_action :current_user, only: [:create]

  def show
    @like = Like.find(params[:id])
  end

  def index
    @likes = Like.all
  end

  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    new_like = current_user.likes.new(
      author_id: current_user.id,
      post_id: @post.id
    )

    redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", notice: 'Like created' if new_like.save
  end

  def edit
    @like = Like.find(params[:id])
  end

  def update
    @like = Like.find(params[:id])
    @like.update(params.require(:like).permit(:name, :photo, :bio))
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
  end

  def update_post_count
    @like = Like.find(params[:id])
  end
end
