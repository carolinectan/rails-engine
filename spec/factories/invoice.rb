FactoryBot.define do
  factory :invoice do
    status { "pending" }
    customer
    merchant
  end
end
