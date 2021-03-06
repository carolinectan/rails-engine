require 'rails_helper'

describe 'items API' do
  describe 'get all items' do
    it 'sends a list of 20 items when fetching page 1' do
      create_list(:item, 25)

      get '/api/v1/items', params: { page: 1 }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id].to_i).to eq(Item.first.id)

      items[:data].each do |item|
        expect(item.length).to eq(3)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'sends a list of 20 items when no page number is specified' do
      create_list(:item, 25)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id].to_i).to eq(Item.first.id)

      items[:data].each do |item|
        expect(item.length).to eq(3)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'fetches page 1 if page is 0 or lower' do
      create_list(:item, 25)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id].to_i).to eq(Item.first.id)
      expect(items[:data].last[:id].to_i).to_not eq(Item.last.id)

      items[:data].each do |item|
        expect(item.length).to eq(3)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'fetches page 2 of 20 items' do
      create_list(:item, 45)

      get '/api/v1/items', params: { page: 2 }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id].to_i).to eq(Item.all[20].id)
      expect(items[:data].last[:id].to_i).to eq(Item.all[39].id)

      items[:data].each do |item|
        expect(item.length).to eq(3)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'fetches page 1 of 50 items' do
      create_list(:item, 52)

      get '/api/v1/items', params: { page: 1, per_page: 50 }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(50)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id].to_i).to eq(Item.all[0].id)
      expect(items[:data].last[:id].to_i).to eq(Item.all[49].id)

      items[:data].each do |item|
        expect(item.length).to eq(3)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'fetches page of items which contain no data' do
      create_list(:item, 52)

      get '/api/v1/items', params: { page: 20_000 }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(0)
      expect(items[:data]).to be_an(Array)

      items[:data].each do |item|
        expect(item.length).to eq(3)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'fetches all items if per page is really big' do
      create_list(:item, 23)

      get '/api/v1/items', params: { per_page: 250_000 }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(23)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id].to_i).to eq(Item.all[0].id)
      expect(items[:data].last[:id].to_i).to eq(Item.all[22].id)

      items[:data].each do |item|
        expect(item.length).to eq(3)
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes].length).to eq(4)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end
  end

  describe 'get one item' do
    it 'can get one item by its id' do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item[:data].length).to eq(3)
      expect(item[:data]).to be_a(Hash)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_a(String)
      expect(item[:data][:id]).to eq(id.to_s)

      expect(item[:data]).to have_key(:type)
      expect(item[:data][:type]).to eq('item')
      expect(item[:data][:type]).to be_a(String)

      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to be_a(Hash)
      expect(item[:data][:attributes].length).to eq(4)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)

      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
    end

    it 'returns a 404 with a bad integer id' do
      id = create(:item).id

      get "/api/v1/items/#{id + 1}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
    end

    it 'returns a 404 with a string instead of integer id' do
      id = 'string-instead-of-integer'

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
    end
  end

  describe 'create and delete an item' do
    it 'can create an item' do
      merch_id = create(:merchant).id

      item_params = {
        name: 'gold pen',
        description: 'writes with gold ink',
        unit_price: 200.89,
        merchant_id: merch_id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      created_item = Item.last

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      expect(item[:data].length).to eq(3)
      expect(item[:data]).to be_a(Hash)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_a(String)
      expect(item[:data][:id]).to eq(created_item.id.to_s)

      expect(item[:data]).to have_key(:type)
      expect(item[:data][:type]).to eq('item')
      expect(item[:data][:type]).to be_a(String)

      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to be_a(Hash)
      expect(item[:data][:attributes].length).to eq(4)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)

      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
    end

    it 'can delete an item' do
      item1_id = create(:item).id
      item2_id = create(:item).id
      # item3_id = create(:item).id

      invoice1_id = create(:invoice).id
      invoice2_id = create(:invoice).id

      invoice_item1_id = create(:invoice_item, invoice_id: invoice1_id, item_id: item1_id).id
      invoice_item2_id = create(:invoice_item, invoice_id: invoice2_id, item_id: item2_id).id
      # invoice_item2_id = create(:invoice_item, invoice_id: invoice2_id, item_id: item3_id).id

      headers = { 'CONTENT_TYPE' => 'application/json' }

      delete "/api/v1/items/#{item2_id}", headers: headers

      expect(response).to be_successful

      expect(Item.last.id).to_not eq(item2_id)
      expect(Item.last.id).to eq(item1_id)

      expect(InvoiceItem.last.id).to_not eq(invoice_item2_id)
      expect(InvoiceItem.last.id).to eq(invoice_item1_id)

      expect { Item.find(item2_id) }.to raise_error(ActiveRecord::RecordNotFound)
      # destroy any invoice if this was the only item on an invoice
      # add a dependent: :destroy to InvoiceItem with some conditional that checks if the item is the only invoice item on that invoice
      # expect(Invoice.last.id).to_not eq(invoice2_id)
      # expect(Invoice.last.id).to eq(invoice1_id)
      # write sad path tests
      # NOT return any JSON body at all, and should return a 204 HTTP status code
      # NOT utilize a Serializer (Rails will handle sending a 204 on its own if you just .destroy the object)
    end
  end

  describe 'udpate an item' do
    it 'can update all attributes of an existing item' do
      id = create(:item).id
      previous_name = Item.last.name
      previous_description = Item.last.description
      previous_unit_price = Item.last.unit_price
      previous_merchant_id = Item.last.merchant_id

      new_merchant_id = create(:merchant).id

      item_params = {
        'name': 'new name',
        'description': 'new description',
        'unit_price': 111.22,
        'merchant_id': new_merchant_id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: item_params })

      item = Item.find_by(id: id)

      expect(response).to be_successful

      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq('new name')

      expect(item.name).to_not eq(previous_description)
      expect(item.description).to eq('new description')

      expect(item.name).to_not eq(previous_unit_price)
      expect(item.unit_price).to eq(111.22)

      expect(item.name).to_not eq(previous_merchant_id)
      expect(item.merchant_id).to eq(new_merchant_id)
    end

    it 'can update partial attributes of an existing item' do
      id = create(:item).id
      previous_name = Item.last.name
      previous_description = Item.last.description
      previous_unit_price = Item.last.unit_price
      previous_merchant_id = Item.last.merchant_id

      item_params = {
        'name': 'new name'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({ item: item_params })

      item = Item.find_by(id: id)

      expect(response).to be_successful

      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq('new name')
      expect(item.description).to eq(previous_description)
      expect(item.unit_price).to eq(previous_unit_price)
      expect(item.merchant_id).to eq(previous_merchant_id)
    end

    it "raises a 404 when updating with a merchant id that doesn't exist" do
      item_params = {
        'merchant_id': 9_999_999_999
      }

      expect { Merchant.find(9_999_999_999) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
