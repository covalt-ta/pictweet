require 'rails_helper'
RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end
  describe 'ツイートの保存' do
    context 'ツイートが保存できる場合' do
      it "画像とテキストがあればツイートは保存できる" do
        expect(@tweet).to be_valid
      end
      it "テキストのみあれば保存できる" do
        @tweet.image = ""
        expect(@tweet).to be_valid
      end
    end
    context 'ツイートが保存できない場合' do
      it 'テキストがないと保存できない' do
        @tweet.text = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Text can't be blank")
      end
      it 'ユーザーが紐付いてないと保存できない' do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("")
      end
    end
  end
end
