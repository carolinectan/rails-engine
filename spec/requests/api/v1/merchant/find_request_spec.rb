require 'rails_helper'

describe 'find merchant API' do
  describe 'find ONE merchant by name' do
    it 'finds a single item which matches a search term for name' do
      merchant1_id = create(:merchant, name: 'George Bluth').id
      merchant2_id = create(:merchant, name: 'Lucille').id
      merchant3_id = create(:merchant, name: 'GOB').id
      merchant4_id = create(:merchant, name: 'Lindsay').id
      merchant5_id = create(:merchant, name: 'Buster').id
      merchant5_id = create(:merchant, name: 'Michael Bluth').id

      search_query = 'bLutH'

      get '/api/v1/merchants/find', params: {name: search_query}

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant.count).to eq(1)
      expect(merchant[:data].count).to eq(3)
      expect(merchant[:data]).to be_a(Hash)
      expect(merchant[:data][:id].to_i).to eq(merchant1_id)
    end
  end
end
