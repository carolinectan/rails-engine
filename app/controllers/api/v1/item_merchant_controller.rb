class Api::V1::ItemMerchantController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    merchant = Merchant.find(item.merchant_id)
    render json: MerchantSerializer.new(merchant)
  end
end
