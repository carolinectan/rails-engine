class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant

  # before_destroy :destroy_invoices
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items # , dependent: :destroy

  self.per_page = 20

  #
  #   def destroy_invoices
  #     invoices.each do |invoice|
  #       invoice.destroy if invoice.items.count == 1
  #     end
  #   end
end
