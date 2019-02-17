require "./lib/pricing_rules/pricing_rule"

class MinimumPurchaseGetDiscount < PricingRule
  attr_accessor :code, :minimun_purchase, :discount_percent

  def initialize(code, minimun_purchase, discount_percent)
    @code = code.to_s
    @minimun_purchase = minimun_purchase
    @discount_percent = discount_percent
    validate!
  end

  def apply(quantity, product_price)
    product_price = (product_price - ((product_price/100) * discount_percent)) if quantity >= @minimun_purchase
    quantity * product_price
  end

  def validate!
    raise ArgumentError.new("Minimum purchase must be a positive number") unless @minimun_purchase.is_a? Integer and @minimun_purchase > 0
    raise ArgumentError.new("Discount percent must be a positive number") unless @discount_percent.is_a? Integer and @discount_percent.between?(0,100)
  end
end
