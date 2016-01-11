FactoryGirl.define do
  factory :event do |f|
    f.date Faker::Time.backward(5)
    f.user Faker::Internet.user_name
    f.type_of "comment"
    f.message Faker::Lorem.words
    f.otheruser Faker::Internet.user_name
  end

end
