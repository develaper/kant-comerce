class BuyMinimumPurchaseGetFreeProduct
  attr_accessor :code, :minimun_purchase, :free_quantity

  def initialize(code, minimun_purchase, free_quantity)
    @code = code.to_s
    @minimun_purchase = minimun_purchase
    @free_quantity = free_quantity
    validate!
  end

  def apply(quantity, product_price)
    quantity = (quantity - ( free_quantity * quantity/minimun_purchase )) if quantity >= @minimun_purchase
    quantity * product_price
  end

  def validate!
    raise ArgumentError.new("Minimum purchase must be a positive number") unless @minimun_purchase.is_a? Integer and @minimun_purchase > 0
    raise ArgumentError.new("Free quantity must be a positive number") unless @free_quantity.is_a? Integer and @free_quantity > 0
  end
end
