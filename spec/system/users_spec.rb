require 'rails_helper'
RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができて、トップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content("新規登録")
      # ユーザー情報を入力する
      visit new_user_registration_path
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{find('input[name="commit"]').click}.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # カーソルを合わせるとログアウトボタンが表示される
      expect(
        find(".user_nav").find("span").hover
        ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへの遷移するボタンがある
      expect(page).to have_content("新規登録")
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      @user.nickname = ""
      fill_in "Nickname", with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押してもユーザーモデルのカウントは上がらない
      expect{find('input[name="commit"]').click}.to change { User.count }.by(0)
      # 新規登録ページへ戻される
      expect(current_path).to eq '/users'
    end
  end
end
RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへの遷移ボタンがある
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # カーソルを合わせるとログアウトボタンが表示される
      expect(
        find(".user_nav").find("span").hover
        ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへの遷移ボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
    it 'ログインできないとき' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへの遷移ボタンがある
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # 誤ったユーザー情報を入力する
      @user.email = ""
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻される
      expect(current_path).to eq new_user_session_path
    end
  end
end