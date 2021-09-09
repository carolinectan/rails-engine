class Api::V1::Merchants::MerchantSearchController < ApplicationController
  def index
    if params[:name]
      merchant = Merchant.where('name ILIKE ?', "%#{params[:name]}%").first
      render json: MerchantSerializer.new(merchant)
    else
    not_found_404
    #   render json: MerchantSerializer.new(data: null)
    end
  end

  private
  #
  # def no_fragment_matched
  #   render json: {data: null}, status: 200
  # end
end
