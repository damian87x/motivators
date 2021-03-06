FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Name #{n}"}
    sequence(:email) { |n| "#{n}example@count.pl"}
    password 'abc12345678'
    password_confirmation 'abc12345678'

    factory :admin do
      admin true
    end

  end

  factory :motivator do
    sequence(:description) { |n| "Description #{n}"}
    image_file_name File.new(Rails.root + 'spec/fixtures/images/rails.jpg')
    user
    approved 'false'
  end

end

