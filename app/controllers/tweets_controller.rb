class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]

  def index
    @tweets = Tweet.all
  end

  def show
    @comments = @tweet.comments
  end

  def create
    @tweet = Tweet.new do |t|
      t.body = params[:body]
      t.user = current_user
    end

    if @tweet.save
      redirect_to @tweet
    else
      flash[:alert] = @tweet.errors.full_messages.join(', ')
      redirect_back fallback_location: root_path
    end
  end

  def edit
    authorize @tweet
  end

  def update
    authorize @tweet

    if @tweet.update(params[:body])
      redirect_to @tweet
    else
      flash[:alert] = @tweet.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    authorize @tweet
    @tweet.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
