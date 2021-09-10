require 'rails_helper'

RSpec.describe "Revenue API" do
  describe 'Non-RESTful: Merchants with Most Revenue API' do
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

      # expect(merchants[:data].first.id).to eq(merchant1_id)
      # expect(merchants[:data].second.id).to eq(merchant2_id)

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

  describe 'Non-RESTful: Merchants with Most Items Sold' do
    it 'returns a variable number of merchants ranked by total number of items sold:' do
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

      # quantity is the number of merchantsto be returned
      get '/api/v1/merchants/most_items', params: {quantity: 2}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].length).to eq(2)
      expect(merchants[:data]).to be_an(Array)

      expect(merchants[:data].first[:id]).to eq(merchant1_id.to_s)
      expect(merchants[:data].second[:id]).to eq(merchant2_id.to_s)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)
        expect(merchant[:type]).to eq('items_sold')

        expect(merchant).to have_key(:attributes)
        expect(merchant).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:count)
        expect(merchant[:attributes][:count]).to be_an(Integer)
      end
    end
  end

  describe 'Non-RESTful: Total Revenue for a Given Merchant' do
    it 'returns the total revenue for a single merchant' do
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

      get "/api/v1/revenue/merchants/#{merchant1_id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant.length).to eq(1)

      expect(merchant[:data]).to be_a(Hash)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_a(String)

      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to be_a(String)
      expect(merchant[:data][:type]).to eq('merchant_revenue')

      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to be_a(Hash)

      expect(merchant[:data][:attributes]).to have_key(:revenue)
      expect(merchant[:data][:attributes][:revenue]).to be_a(Float)
    end
  end

  describe 'Non-RESTful: Find items ranked by Revenue' do
    it 'returns a quantity of items ranked by descending revenue' do
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
      invoice_item2_id = create(:invoice_item, invoice_id: invoice1_id, item_id: item2_id, unit_price: 62000.23, quantity: 6) # m1
      invoice_item3_id = create(:invoice_item, invoice_id: invoice1_id, item_id: item1_id, unit_price: 4200.12, quantity: 8) # m1
      invoice_item4_id = create(:invoice_item, invoice_id: invoice2_id, item_id: item2_id, unit_price: 48000.48, quantity: 10) # m1
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

      # where ‘x’ is the maximum count of results to return.
      get "/api/v1/revenue/items", params: {quantity: 2}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].length).to eq(2)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id]).to eq(item2_id.to_s)
      expect(items[:data].second[:id]).to eq(item1_id.to_s)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)
        expect(item[:type]).to eq('item_revenue')

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(5)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)

        expect(item[:attributes]).to have_key(:revenue)
        expect(item[:attributes][:revenue]).to be_a(Float)
      end
    end
  end
end
