class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page].to_i <= 1
      render json: MerchantSerializer.new(Merchant.paginate(page: 1, per_page: params[:per_page]))
    else
      render json: MerchantSerializer.new(Merchant.paginate(page: params[:page], per_page: params[:per_page]))
    end

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
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  # def new
  #
  # end
  # def create
  #
  # end
  # def edit
  #
  # end
  # def update
  #
  # end
  # def destroy
  #
  # end
  # private
  # def _params
  #   params.permit(:)
  # end
end
