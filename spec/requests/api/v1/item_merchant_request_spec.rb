require 'rails_helper'

describe "item's merchant API" do
  describe "get an item's merchant" do
    it 'returns the merchant associated with an item' do
      merchant_id = create(:merchant).id
      item_id = create(:item, merchant_id: merchant_id).id

      get "/api/v1/items/#{item_id}/merchant"

      expect(response).to be_successful

      # is this the right way to test this?
      expect(merchant_id).to eq(Item.find(item_id).merchant_id)

      items = JSON.parse(response.body, symbolize_names: true)
      #
      # expect(items[:data].count).to eq(20)
      # expect(items[:data]).to be_an(Array)
      # expect(items[:data].first[:id].to_i).to eq(Item.first.id)
      #
      # items[:data].each do |item|
      #   expect(item.length).to eq(3)
      #   expect(item).to have_key(:id)
      #   expect(item[:id]).to be_a(String)
      #
      #   expect(item).to have_key(:type)
      #   expect(item[:type]).to be_a(String)


    end

    xit 'returns a 404 if the item is not found' do
    end
  end
end
