require 'rails_helper'

RSpec.describe "Non-RESTful: Merchants with Most Revenue API" do
  describe "get merchants with most revenue" do
    it 'returns a variable number of merchants ranked by total revenue' do
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

      get '/api/v1/revenue/merchants', params: { quantity: 2 }

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].length).to eq(2)
      expect(merchants[:data]).to be_an(Array)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)
        expect(merchant[:type]).to eq('merchant_name_revenue')

        expect(merchant).to have_key(:attributes)
        expect(merchant).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:revenue)
        expect(merchant[:attributes][:revenue]).to be_a(Float)
      end
    end
  end
end
