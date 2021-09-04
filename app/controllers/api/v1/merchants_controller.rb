class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.paginate(page: params[:page], per_page: 20)
    x = render json: MerchantSerializer.new(merchants)
    # require "pry"; binding.pry
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
