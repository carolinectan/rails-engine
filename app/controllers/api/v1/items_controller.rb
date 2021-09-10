class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.paginate(page: params[:page], per_page: params[:per_page])
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  rescue ActiveRecord::RecordNotFound
    not_found_404
  end

  def create
    item = Item.create(item_params)

    if item.save
      render(json: ItemSerializer.new(item), status: 201)
    else
      not_found_404
    end
  end

  def update
    item = Item.find(params[:id])

    if item_params[:merchant_id] && Merchant.find(item_params[:merchant_id]) == ActiveRecord::RecordNotFound
      not_found_404
    else
      item.update(item_params)
      render(json: ItemSerializer.new(item), status: 201)
    end
  end

  def destroy
    item = Item.find(params[:id])
    render(json: item.destroy)
  end

  def items_revenue
    if !params[:quantity]
      items = Item.top_revenue(10)
      render json: ItemSerializer.item_revenue(items), status: 200
    elsif params[:quantity].to_i != 0 && params[:quantity].empty? == false
      items = Item.top_revenue(params[:quantity])
      render json: ItemSerializer.item_revenue(items), status: 200
    else
      render status: :bad_request
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
