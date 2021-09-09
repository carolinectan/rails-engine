class Api::V1::Merchants::MerchantSearchController < ApplicationController
  def index
    if params[:name] && !(Merchant.where('name ILIKE ?', "%#{params[:name]}%").first).nil?
      merchant = Merchant.where('name ILIKE ?', "%#{params[:name]}%").first
      render json: MerchantSerializer.new(merchant)
    else
      # render json: [{}]
      # render json: MerchantSerializer.new(data: null)
      # render json: MerchantSerializer.new({data: []})
      # render json: {} # => sad path, no fragment matched | AssertionError: expected {} to have property 'data'
      render json: {data: {}} # =>sad path, no fragment matched | AssertionError: expected { Object (status, error, ...) } to have property 'data'
      # render(json: null) # not this
    end
  end

  private
  #
  # def no_fragment_matched
  #   render json: {data: null}, status: 200
  # end
end
