require 'rails_helper'
describe Tweet, type: :model do #何に対して
  before do
    @tweet = FactoryBot.build(:tweet)
  end
  describe 'tweetの保存' do #どんな機能に対して
    context "tweetが保存できる場合" do #どんな状況ー正常系
      it "画像URLとテキストがあれば投稿できる" do
        expect(@tweet).to be_valid
      end
      it "テキストだけあれば投稿できる" do
        @tweet.image = ""
        expect(@tweet).to be_valid
      end
    end
    context "tweetが保存できない場合" do #どんな状況ー異常系
      it "テキストがないと投稿できない" do
        @tweet.text = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Text can't be blank")
      end
      it "ユーザーが紐付いてないと投稿できない" do
        @tweet.user = nill
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("User must exist")
      end
    end
  end
end
