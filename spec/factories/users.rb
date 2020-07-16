FactoryBot.define do
  factory :user do
    nickname {Faker::Name.initials(number:2)}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
  # FactoryBotのドキュメントでの記述方法は上記の為、下記では定義できない
  # factory :user do
  #   nickname = Faker::Name.initials(number:2)
  #   email = Faker::Internet.free_email
  #   password = Faker::Internet.password(min_length: 6)
  #   password_confirmation = password
  # end
end