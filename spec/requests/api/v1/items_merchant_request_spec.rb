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
    end

    xit 'returns a 404 if the item is not found' do
    end
  end
end
