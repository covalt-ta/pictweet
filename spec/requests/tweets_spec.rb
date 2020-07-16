require 'rails_helper'

RSpec.describe TweetsController, type: :request do
  before do
    @tweet = FactoryBot.create(:tweet)
  end
  describe "GET #index" do
    before do
      get root_path
    end
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      # get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済のツイートのテキストが存在する" do
      # get root_path
      expect(response.body).to include(@tweet.text)
    end
    it "indexアクションにリクエストするとレスポンスに投稿済のツイートの画像URLが存在する" do
      # get root_path
      expect(response.body).to include(@tweet.image)
    end
    it "indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する" do
      # get root_path
      expect(response.body).to include("投稿を検索する")
    end
  end
  describe "GET #show" do
    before do
      get tweet_path(@tweet)
    end
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済のツイートテキストが存在する' do
      expect(response.body).to include(@tweet.text)
    end
    it 'showアクションにリクエストとするレスポンスに投稿済のツイート画像URLが存在する' do
      expect(response.body).to include(@tweet.image)
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do
      expect(response.body).to include("＜コメント一覧＞")
    end
  end
end
