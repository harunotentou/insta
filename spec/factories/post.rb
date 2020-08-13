FactoryBot.define do
  factory :post do
    content { Faker::Hacker.say_something_smart }
    pictures { [File.open("#{Rails.root}/spec/fixtures/fixture.png")] }
    user
  end
end