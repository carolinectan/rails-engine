class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page] && params[:per_page]
      merchants = Merchant.paginate(page: params[:page], per_page: params[:per_page])
    elsif params[:page]
      merchants = Merchant.paginate(page: params[:page], per_page: 20)
    # elsif params[:page] == "1"
    #   merchants = Merchant.paginate(page: params[:page], per_page: 50)
    elsif params[:per_page]
      merchants = Merchant.paginate(page: 1, per_page: params[:per_page])
    # elsif params[:page].to_i <= 0
    #   require "pry"; binding.pry
      # merchants = Merchant.paginate(page: 1, per_page: 20)
    else
      merchants = Merchant.paginate(page: 1, per_page: 20)
    end
    render json: MerchantSerializer.new(merchants)
  end

  # def show
  #
  # end
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
