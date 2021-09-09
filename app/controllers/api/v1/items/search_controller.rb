class Api::V1::Items::SearchController < ApplicationController
  def index
    if params[:name]
      items = Item.where('name ILIKE ?', "%#{params[:name]}%")
      render(json: ItemSerializer.new(items), status: 200)
    else
      not_found_404
    end
  end
end
