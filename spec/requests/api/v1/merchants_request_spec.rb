require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 20)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end
end
