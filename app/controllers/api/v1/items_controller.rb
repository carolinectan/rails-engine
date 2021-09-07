class Api::V1::ItemsController < ApplicationController
  def index
    item = Item.paginate(page: params[:page], per_page: params[:per_page])
    render json: ItemSerializer.new(item)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
    rescue ActiveRecord::RecordNotFound
    render_not_found
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
