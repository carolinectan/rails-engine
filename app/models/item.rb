class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant

  # before_destroy :destroy_invoices
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items # , dependent: :destroy

  self.per_page = 20

  # def destroy_invoices
  #   invoices.each do |invoice|
  #     invoice.destroy if invoice.items.count == 1
  #   end
  # end

  def self.top_revenue(quantity)
    joins(:invoices)
      .joins(invoices: :transactions)
      .select('items.*', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .where("transactions.result = 'success' AND invoices.status = 'shipped'")
      .group('items.id')
      .order('revenue DESC')
      .limit(quantity)
  end
end
