FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number: 2)}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end
# FactoryBotを利用しない場合
# user = User.new(nickname: "abe", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
# FactoryBotを利用する場合
# user = FactoryBot.build(:user)