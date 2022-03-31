class CommentsController < ApplicationController
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
    @comment = Comment.new(params.require(:comment).permit(:text))
    @post.author = User.first
    respond_to do |format|
      format.html do
    if @comment.save
      flash[:notice] = "Comment was created successfully."
      redirect_to user_post_path(User.first.id, @comment.id)
    else
      render 'new', status: :unprocessable_entity 
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
end
