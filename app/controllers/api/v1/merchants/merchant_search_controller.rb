class Api::V1::Merchants::MerchantSearchController < ApplicationController
  def index
    if params[:name] && !(Merchant.where('name ILIKE ?', "%#{params[:name]}%").first).nil?
      merchant = Merchant.where('name ILIKE ?', "%#{params[:name]}%").first
      render json: MerchantSerializer.new(merchant)
    else
      render json: {data: {}}
    end
  end
end
