class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  self.per_page = 20
end
