class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    # query = "SELECT * FROM tweets"
    # @tweets = Tweet.find_by_sql(query)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.valid?
      @tweet.save
      redirect_to root_path
    else
      render :new
    end
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

  def search
    @tweets = SearchTweetsService.search_tweets(params[:keyword]).includes(:user).order("created_at DESC")
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
