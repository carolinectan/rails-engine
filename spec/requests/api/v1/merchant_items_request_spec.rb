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

      get "/api/v1/merchants/#{merchant1.id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(3)
      expect(items[:data]).to be_an(Array)
      expect(items[:data].first[:id].to_i).to eq(Item.first.id)
      expect(items[:data].second[:id].to_i).to eq(Item.second.id)
      expect(items[:data].third[:id].to_i).to eq(Item.third.id)

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

    # it 'returns a 404 if the item is not found' do
    # end
  end
end
