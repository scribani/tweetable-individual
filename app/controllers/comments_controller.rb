class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = new_comment

    flash[:alert] = @comment.errors.full_messages.join(', ') unless @comment.save
    redirect_back fallback_location: root_path
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    updated = @comment.update(body: params[:comment][:body])

    flash[:alert] = @comment.errors.full_messages.join(', ') unless updated
    redirect_to @comment.tweet
  end

  def destroy
    authorize @comment
    @comment.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def new_comment
    Comment.new do |c|
      c.body = params[:comment][:body]
      c.user = current_user
      c.tweet_id = params[:comment][:tweet_id].to_i
    end
  end
end
