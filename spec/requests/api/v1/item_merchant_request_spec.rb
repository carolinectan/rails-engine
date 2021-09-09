require 'rails_helper'

describe "item's merchant API" do
  describe "get an item's merchant" do
    it 'returns the merchant associated with an item' do
      merchant_id = create(:merchant).id
      item_id = create(:item, merchant_id: merchant_id).id

      get "/api/v1/items/#{item_id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data].length).to eq(3)
      expect(merchant[:data]).to be_a(Hash)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_a(String)
      expect(merchant[:data][:id]).to eq(merchant_id.to_s)

      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to be_a(String)

      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes].length).to eq(1)
      expect(merchant[:data][:attributes]).to be_a(Hash)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    xit 'returns a 404 if the item is not found' do
    end
  end
end
