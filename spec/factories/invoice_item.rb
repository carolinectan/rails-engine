FactoryBot.define do
  factory :invoice_item do
    quantity { rand(20) }
    unit_price { rand(10_000) }
    invoice
    item
  end
end
