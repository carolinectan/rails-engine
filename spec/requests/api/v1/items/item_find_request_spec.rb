require 'rails_helper'

describe 'find items API' do
  describe 'find all items by name' do
    it 'finds a single item which matches a search term for name' do
      create_list(:item, 5)
      dog1_id = create(:item, name: 'dog toy').id
      dog2_id = create(:item, name: 'dog food').id

      search_query = 'doG'

      get '/api/v1/items/find_all', params: {name: search_query}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(2)
      expect(items[:data]).to be_an(Array)
      expect(items[:data][-2][:id].to_i).to eq(dog1_id)
      expect(items[:data][-1][:id].to_i).to eq(dog2_id)
    end
  end
end
