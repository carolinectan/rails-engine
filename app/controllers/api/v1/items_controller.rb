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
    # if item.save
    render(json: ItemSerializer.new(item), status: 201)
    # else render 404 error message
    # end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    # render(json: ItemSerializer.new(item), status: 201)
  end

  def destroy
    item = Item.find(params[:id])
    render(json: item.destroy)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
