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

      get '/api/v1/items', params: { page: 20000}

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

      get '/api/v1/items', params: { per_page: 250_000}

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
      expect(item[:data][:id]).to eq("#{id}")

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
      id = "string-instead-of-integer"

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
    end
  end
end
