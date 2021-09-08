require 'rails_helper'

describe 'merchants API' do
  describe 'get all merchants' do
    it 'sends a list of 20 merchants when fetching page 1' do
      create_list(:merchant, 25)

      get '/api/v1/merchants', params: { page: 1 }

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'fetches page 1 of 20 people if page is 0 or lower' do
      create_list(:merchant, 25)

      get '/api/v1/merchants', params: { page: 0 }

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end

      expect(merchants[:data].first[:id].to_i).to eq(Merchant.first.id)
      expect(merchants[:data].last[:id].to_i).to_not eq(Merchant.last.id)
    end
  end

  describe 'get one merchant' do
    it 'can get one merchant by its id' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to eq(id.to_s)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end
  end
end
