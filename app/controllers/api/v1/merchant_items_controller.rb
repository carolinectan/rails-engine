class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    items = Item.where(merchant_id: params[:merchant_id])
    render json: ItemSerializer.new(items)
  end
end
