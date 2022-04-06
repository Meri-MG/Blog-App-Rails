class CommentsController < ApplicationController
  before_action :current_user, only: [:create]

  def show
    @comment = Comment.find(params[:id])
  end

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comments_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]

    respond_to do |format|
      format.html do
        if @comment.save
          flash[:notice] = 'Thanks for your comment!'
          redirect_to user_post_path(current_user.id, Post.find(params[:post_id]))
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(params.require(:comment).permit(:name, :photo, :bio))
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
