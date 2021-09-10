class MerchantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  def self.merchant_name_revenue(merchants)
    {
      data:
        merchants.map do |merchant|
          {
            id: merchant.id.to_s,
            type: 'merchant_name_revenue',
            attributes: {
              name: merchant.name,
              revenue: merchant.revenue
            }
          }
        end
    }
  end

  def self.items_sold(merchants)
    {
      data:
        merchants.map do |merchant|
          {
            id: merchant.id.to_s,
            type: 'items_sold',
            attributes: {
              name: merchant.name,
              count: merchant.items_sold
            }
          }
        end
    }
  end

  def self.merchant_revenue(merchant)
    {
      data: {
        id: merchant.id.to_s,
        type: 'merchant_revenue',
        attributes: {
          revenue: merchant.total_revenue
        }
      }
    }
  end
end
