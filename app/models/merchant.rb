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

  def self.most_items(quantity)
    # The quantity should default to 5 if not provided, and return an error if it is not an integer greater than 0.
    joins(invoices: :invoice_items)
    .joins(invoices: :transactions)
    .select('merchants.*', 'SUM(invoice_items.quantity) AS items_sold')
    .where("transactions.result = 'success' AND invoices.status = 'shipped'")
    .group('merchants.id').order('items_sold DESC').limit(quantity)
  end
end




# merchant.map do |m|
# m.revenue
# end
