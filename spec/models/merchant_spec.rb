require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  before :each do
    merchant1_id = create(:merchant, name: 'George Bluth').id # top rev
    merchant2_id = create(:merchant, name: 'Lucille').id # top rev
    merchant3_id = create(:merchant, name: 'GOB').id # low rev

    item1_id = create(:item, merchant_id: merchant1_id).id
    item2_id = create(:item, merchant_id: merchant1_id).id
    item3_id = create(:item, merchant_id: merchant2_id).id
    item4_id = create(:item, merchant_id: merchant2_id).id
    item5_id = create(:item, merchant_id: merchant3_id).id

    # default status is status: 'shipped'
    invoice1_id = create(:invoice, merchant_id: merchant1_id).id
    invoice2_id = create(:invoice, merchant_id: merchant1_id).id
    invoice3_id = create(:invoice, merchant_id: merchant2_id).id
    invoice4_id = create(:invoice, merchant_id: merchant2_id).id # failed
    invoice5_id = create(:invoice, merchant_id: merchant3_id).id

    invoice_item1_id = create(:invoice_item, invoice_id: invoice1_id, item_id: item1_id, unit_price: 5000.00, quantity: 7) # m1
    invoice_item2_id = create(:invoice_item, invoice_id: invoice1_id, item_id: item2_id, unit_price: 6200.23, quantity: 6) # m1
    invoice_item3_id = create(:invoice_item, invoice_id: invoice1_id, item_id: item1_id, unit_price: 4200.12, quantity: 8) # m1
    invoice_item4_id = create(:invoice_item, invoice_id: invoice2_id, item_id: item2_id, unit_price: 4800.48, quantity: 10) # m1
    invoice_item5_id = create(:invoice_item, invoice_id: invoice3_id, item_id: item3_id, unit_price: 4200.12, quantity: 3) # m2
    invoice_item6_id = create(:invoice_item, invoice_id: invoice4_id, item_id: item4_id, unit_price: 6200.23, quantity: 2) # m2 # failed
    invoice_item7_id = create(:invoice_item, invoice_id: invoice4_id, item_id: item3_id, unit_price: 5000.00, quantity: 2) # m2 # failed
    invoice_item8_id = create(:invoice_item, invoice_id: invoice5_id, item_id: item5_id, unit_price: 48.48, quantity: 1)

    # default status is result: 'success'
    transactions = create(:transaction, invoice_id: invoice1_id)
    transactions = create(:transaction, invoice_id: invoice2_id)
    transactions = create(:transaction, invoice_id: invoice3_id)
    transactions = create(:transaction, invoice_id: invoice4_id, result: 'failed')
    transactions = create(:transaction, invoice_id: invoice5_id)
  end

  describe 'class methods' do
    describe '.top_revenue' do
#       it 'returns a variable number of merchants ranked by total revenue' do
#       end
    end
  end

  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
