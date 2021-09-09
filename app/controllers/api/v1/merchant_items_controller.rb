class Api::V1::MerchantItemsController < ApplicationController
  def index
    if params[:merchant_id] && Merchant.find(params[:merchant_id])
      items = Item.where(merchant_id: params[:merchant_id])
      render json: ItemSerializer.new(items)
    else
      not_found_404
    end
  end
end
