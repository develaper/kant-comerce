require "./lib/pricing_rules/pricing_rule"

class MinimumPurchaseGetDiscount < PricingRule
  attr_accessor :code, :minimun_purchase, :discount_fraction

  def initialize(code, minimun_purchase, discount_fraction)
    @code = code.to_s
    @minimun_purchase = minimun_purchase
    @discount_fraction = discount_fraction
    validate!
  end

  def apply(quantity, product_price)
    product_price = (product_price - (product_price/discount_fraction)) if quantity >= @minimun_purchase
    quantity * product_price
  end

  def validate!
    raise ArgumentError.new("Minimum purchase must be a positive number") unless @minimun_purchase.is_a? Integer and @minimun_purchase > 0
    raise ArgumentError.new("Discount percent must be a positive number") unless @discount_fraction.is_a? Integer and @discount_fraction.between?(0,100)
  end
end
