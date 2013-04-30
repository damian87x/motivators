FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'abc12345678'
    password_confirmation 'abc12345678'

    factory :admin do
      admin true
    end

  end



end

