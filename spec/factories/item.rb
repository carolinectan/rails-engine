FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::TvShows::HowIMetYourMother.quote }
    unit_price { Faker::Number.binary(digits: 5) }
    merchant
  end
end
