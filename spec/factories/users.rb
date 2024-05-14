FactoryBot.define do
  factory :user do
    nickname               { Faker::Internet.username }
    email                  { Faker::Internet.email }
    password               { Faker::Internet.password }
    password_confirmation  { password }
    f_name                 { Gimei.last.kanji }
    p_name                 { Gimei.first.kanji }
    f_name_kana            { Gimei.last.katakana }
    p_name_kana            { Gimei.first.katakana }
    birthday               { Faker::Date.between(from: '1930-01-01', to: '2019-12-31') }
  end
end
