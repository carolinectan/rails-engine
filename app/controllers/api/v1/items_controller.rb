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

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item)
  end
  # def edit
  #
  # end
  # def update
  #
  # end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
