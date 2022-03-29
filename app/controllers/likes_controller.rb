class LikesController < ApplicationController
  def show
    @like = Like.find(params[:id])
  end

  def index;
    @likes = Like.all
  end

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(params.require(:like).permit(:name, :photo, :bio))
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