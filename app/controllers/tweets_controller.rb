class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
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
      redirect_back fallback_location: root_path
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])

    if @tweet.update(tweet_params)
      redirect_to @tweet
    else
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    redirect_back fallback_location: root_path
  end
end
