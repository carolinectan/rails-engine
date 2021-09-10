class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description, :unit_price, :merchant_id

  def self.item_revenue(items)
    {
      data:
        items.map do |item|
          {
            id: item.id.to_s,
            type: 'item_revenue',
            attributes: {
              name: item.name,
              description: item.description,
              unit_price: item.unit_price,
              merchant_id: item.merchant_id,
              revenue: item.revenue
            }
          }
        end
    }
  end
end
