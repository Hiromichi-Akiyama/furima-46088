FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    # パスワードは英数字混合を生成するように修正
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    # gimei を使って日本の名前とフリガナを生成
    last_name             { Gimei.last.kanji }
    first_name            { Gimei.first.kanji }
    last_name_kana        { Gimei.last.katakana }
    first_name_kana       { Gimei.first.katakana }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
