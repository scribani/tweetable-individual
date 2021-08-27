class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = new_comment

    flash[:alert] = @comment.errors.full_messages.join(', ') unless @comment.save
    redirect_back fallback_location: root_path
  end

  def edit; end

  def update
    flash[:alert] = @comment.errors.full_messages.join(', ') unless @comment.update(params[:body])
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def new_comment
    Comment.new do |c|
      c.body = params[:body]
      c.user = current_user
      c.tweet = params[:tweet_id]
    end
  end
end
