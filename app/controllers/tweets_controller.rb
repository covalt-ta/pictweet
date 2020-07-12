class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit]

  def index
    @tweets = Tweet.all
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.delete
    # redirect_to root_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text, :name)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
