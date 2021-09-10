class Api::V1::MerchantsController < ApplicationController
  def index
    merchant = if params[:page].to_i <= 1
                 Merchant.paginate(page: 1, per_page: params[:per_page])
               else
                 Merchant.paginate(page: params[:page], per_page: params[:per_page])
               end
    render json: MerchantSerializer.new(merchant)

    # if params[:page] && params[:per_page]
    #   merchants = Merchant.paginate(page: params[:page], per_page: params[:per_page])
    # elsif params[:page].to_i > 0
    #   merchants = Merchant.paginate(page: params[:page], per_page: 20)
    # elsif params[:per_page]
    #   merchants = Merchant.paginate(page: 1, per_page: params[:per_page])
    # else
    #   merchants = Merchant.paginate(page: 1, per_page: 20)
    # end
    # render json: MerchantSerializer.new(merchants)
  end

  def show
    # render json: Merchant.find(params[:id])
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  def merchant_revenue
    if params[:quantity] && params[:quantity].empty? == false
      merchants = Merchant.top_revenue(params[:quantity])
      render json: MerchantSerializer.merchant_name_revenue(merchants)
    else
      render json: {error: ""}, status: :bad_request
    end
  end

  def merchant_most_items
    if params[:quantity]
      merchants = Merchant.most_items(params[:quantity])
      render json: MerchantSerializer.items_sold(merchants)
    else
      render json: {error: ""}, status: :bad_request
    end
  end
end
