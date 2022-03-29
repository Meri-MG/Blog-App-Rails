class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index;
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :photo, :bio))
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(params.require(:user).permit(:name, :photo, :bio))
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def three_recent_posts
    @user = User.find(params[:id])
  end
end
