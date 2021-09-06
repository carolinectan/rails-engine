class Api::V1::ItemsController < ApplicationController
  def index
    item = Item.paginate(page: 1, per_page: params[:per_page])
    render json: ItemSerializer.new(item)
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
