require 'rails_helper'

describe "merchant's items API" do
  describe "get a merchant's items" do
    it 'returns the items associated with a merchant' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant_id: merchant1.id)
      item2 = create(:item, merchant_id: merchant1.id)
      item3 = create(:item, merchant_id: merchant1.id)
      item4 = create(:item, merchant_id: merchant2.id)

      get "/api/v1/merchant/#{merchant1.id}/items"

      expect(response).to be_successful

      # write expects here  
    end

    xit 'returns a 404 if the item is not found' do
    end
  end
end
