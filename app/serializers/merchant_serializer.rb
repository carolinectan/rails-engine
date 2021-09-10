class MerchantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  def self.merchant_name_revenue(merchants)
    {
      data:
        merchants.map do |merchant|
        {
          id: merchant.id.to_s,
          type: "merchant_name_revenue",
          attributes: {
            name: merchant.name,
            revenue: merchant.revenue
          }
        }
      end
      }
  end
end
