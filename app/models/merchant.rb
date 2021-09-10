class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices
  has_many :items

  self.per_page = 20

  def self.top_revenue(quantity)
    joins(invoices: :invoice_items)
    .joins(invoices: :transactions)
    .select('merchants.*', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .where("transactions.result = 'success' AND invoices.status = 'shipped'")
    .group('merchants.id')
    .order('revenue DESC')
    .limit(quantity)
  end
end




# merchant.map do |m|
# m.revenue
# end
